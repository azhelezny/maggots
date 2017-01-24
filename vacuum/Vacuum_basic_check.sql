
1. On one of the Regionals create table and populate it with data: 

create schema vacuum;
drop table vac_t;
create table vacuum.vac_t(id INT generated by default as identity, c_char char(30));

2. Open HBASE UI on master node: http://<Master Node URL>:16010/master-status
http://stl-colo-srv021.splicemachine.colo:16010/master-status
 
and under the "Tables" section search for the entry with table name that you've just created something like 'tableDisplayName' => 'VAC_T' 
the string should be like following: 'splice:2512', {TABLE_ATTRIBUTES => {METADATA => {'tableDisplayName' => 'VAC_T'}}, {NAME => 'V', VERSIONS => '2147483647', COMPRESSION => 'SNAPPY'}
Note the table name in HBase which is 'splice:2512'.

3. Open ssh terminal to the regional where the table was created and launch "hbase shell".
Do scan of the table that you have created using hbase name that we get in previous step.
hbase> scan 'splice:2512', {RAW => true, VERSIONS => 1}

The result should be like that: 
scan 'splice:2512', {RAW => true, VERSIONS => 1}
ROW                                                                  COLUMN+CELL                                                                                                                                                                                              
0 row(s) in 0.0180 seconds

4. Insert several rows to the table that we just created via IJ console: 

insert into  vacuum.vac_t (c_char) values 'test__^l.~Y{KHn{', 'test__#J@&epS~x&', 'test__iGKZQ}A%eL', 'test__})i^@B(HpD';
select * from vacuum.vac_t;

the result should be like that: 

ID         |C_CHAR                        
------------------------------------------
1          |test__^l.~Y{KHn{              
2          |test__#J@&epS~x&              
3          |test__iGKZQ}A%eL              
4          |test__})i^@B(HpD  

5. Check the data in the hbase shell: 

scan 'splice:2512', {RAW => true, VERSIONS => 100}
ROW                                                                  COLUMN+CELL                                                                                                                                                                                              
 \xA45\x92 \x1F\x16\xC0\x05                                          column=V:7, timestamp=3150, value=\x8F\x80\x00\x81\x00vguvaa`n0\x80[}MJp}""""""""""""""                                                                                                                  
 \xA4U\x92 \x1F\x16\xC0\x05                                          column=V:7, timestamp=3150, value=\x8F\x80\x00\x82\x00vguvaa%LB(grU\x80z(""""""""""""""                                                                                                                  
 \xA4u\x92 \x1F\x16\xC0\x05                                          column=V:7, timestamp=3150, value=\x8F\x80\x00\x83\x00vguvaakIM\x5CS\x7FC'gN""""""""""""""                                                                                                               
 \xA4\x95\x92 \x1F\x16\xC0\x05                                       column=V:7, timestamp=3150, value=\x8F\x80\x00\x84\x00vguvaa\x7F+k`BD*JrF""""""""""""""                                                                                                                  
4 row(s) in 0.0210 seconds


6. Update one row in the IJ console 3 times with 3 different values:

UPDATE vacuum.vac_t set c_char = 'test__:@SKvmazas' where id = 1;
UPDATE vacuum.vac_t set c_char = '0000' where id = 1;
UPDATE vacuum.vac_t set c_char = 'test__Zdx:tsduku' where id = 1;

7. Check Historical data changes in hbase shell
scan 'splice:2512', {RAW => true, VERSIONS => 100}

The result should be like that: 

ROW                                                                  COLUMN+CELL                                                                                                                                                                                              
 \xB4\xB5\x92 \xA2\x9B0\x05                                          column=V:7, timestamp=3189, value=\x84\x00vguvaa\x5Cfz<vufwmw""""""""""""""                                                                                                                              
 \xB4\xB5\x92 \xA2\x9B0\x05                                          column=V:7, timestamp=3183, value=\x84\x002222""""""""""""""""""""""""""                                                                                                                                 
 \xB4\xB5\x92 \xA2\x9B0\x05                                          column=V:7, timestamp=3177, value=\x84\x00vguvaa<BUMxoc|cu""""""""""""""                                                                                                                                 
 \xB4\xB5\x92 \xA2\x9B0\x05                                          column=V:7, timestamp=3171, value=\x8F\x80\x00\x81\x00vguvaa`n0\x80[}MJp}""""""""""""""                                                                                                                  
 \xB4\xD5\x92 \xA2\x9B0\x05                                          column=V:7, timestamp=3171, value=\x8F\x80\x00\x82\x00vguvaa%LB(grU\x80z(""""""""""""""                                                                                                                  
 \xB4\xF5\x92 \xA2\x9B0\x05                                          column=V:7, timestamp=3171, value=\x8F\x80\x00\x83\x00vguvaakIM\x5CS\x7FC'gN""""""""""""""                                                                                                               
 \xB5\x15\x92 \xA2\x9B0\x05                                          column=V:7, timestamp=3171, value=\x8F\x80\x00\x84\x00vguvaa\x7F+k`BD*JrF""""""""""""""                                                                                                                  
4 row(s) in 0.0420 seconds

You can see that first 4 rows names are similar, but have different time stamps, which means that this row has 4 historical changes, and other 4 remains unchanged.

8. Delete first row and check that this change reflected in the historical data via hbase shell:

delete from vacuum.vac_t where id = 1;

Make sure that table contains only 3 rows: 

select * from vacuum.vac_t;
ID         |C_CHAR                        
------------------------------------------
2          |test__#J@&epS~x&              
3          |test__iGKZQ}A%eL              
4          |test__})i^@B(HpD          

Check historical data wia hbase shell: 

scan 'splice:2512', {RAW => true, VERSIONS => 100}
ROW                                                                  COLUMN+CELL                                                                                                                                                                                              
 \xB4\xB5\x92 \xA2\x9B0\x05                                          column=V:1, timestamp=3197, value=                                                                                                                                                                       
 \xB4\xB5\x92 \xA2\x9B0\x05                                          column=V:7, timestamp=3189, value=\x84\x00vguvaa\x5Cfz<vufwmw""""""""""""""                                                                                                                              
 \xB4\xB5\x92 \xA2\x9B0\x05                                          column=V:7, timestamp=3183, value=\x84\x002222""""""""""""""""""""""""""                                                                                                                                 
 \xB4\xB5\x92 \xA2\x9B0\x05                                          column=V:7, timestamp=3177, value=\x84\x00vguvaa<BUMxoc|cu""""""""""""""                                                                                                                                 
 \xB4\xB5\x92 \xA2\x9B0\x05                                          column=V:7, timestamp=3171, value=\x8F\x80\x00\x81\x00vguvaa`n0\x80[}MJp}""""""""""""""                                                                                                                  
 \xB4\xD5\x92 \xA2\x9B0\x05                                          column=V:7, timestamp=3171, value=\x8F\x80\x00\x82\x00vguvaa%LB(grU\x80z(""""""""""""""                                                                                                                  
 \xB4\xF5\x92 \xA2\x9B0\x05                                          column=V:7, timestamp=3171, value=\x8F\x80\x00\x83\x00vguvaakIM\x5CS\x7FC'gN""""""""""""""                                                                                                               
 \xB5\x15\x92 \xA2\x9B0\x05                                          column=V:7, timestamp=3171, value=\x8F\x80\x00\x84\x00vguvaa\x7F+k`BD*JrF""""""""""""""                                                                                                                  
4 row(s) in 0.0620 seconds

You may see that ROW ( \xB4\xB5\x92 \xA2\x9B0\x05 ) value is empty. 

9. perform vacuum procedure in IJ console:

call SYSCS_UTIL.VACUUM();

10. Check via hbase shell that the only latest versions of table rows are remains: 

scan 'splice:2512', {RAW => true, VERSIONS => 100}
ROW                                                                  COLUMN+CELL                                                                                                                                                                                              
 \xB4\xB5\x92 \xA2\x9B0\x05                                          column=V:1, timestamp=3197, value=                                                                                                                                                                                                                                                                                       
 \xB4\xD5\x92 \xA2\x9B0\x05                                          column=V:7, timestamp=3171, value=\x8F\x80\x00\x82\x00vguvaa%LB(grU\x80z(""""""""""""""                                                                                                                  
 \xB4\xF5\x92 \xA2\x9B0\x05                                          column=V:7, timestamp=3171, value=\x8F\x80\x00\x83\x00vguvaakIM\x5CS\x7FC'gN""""""""""""""                                                                                                               
 \xB5\x15\x92 \xA2\x9B0\x05                                          column=V:7, timestamp=3171, value=\x8F\x80\x00\x84\x00vguvaa\x7F+k`BD*JrF""""""""""""""                                                                                                                  
4 row(s) in 0.0620 seconds

        