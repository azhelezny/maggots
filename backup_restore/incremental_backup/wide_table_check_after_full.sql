select count(*) from sys.systables where tablename in ('WIDE_TABLE_0') and schemaid in (select schemaid from sys.sysschemas where schemaname = 'INC_BACKUP_SCHEMA');
-- expected 1 
select count(*) from sys.systables where tablename in ('WIDE_TABLE_1', 'WIDE_TABLE_2', 'WIDE_TABLE_3' ) and schemaid in (select schemaid from sys.sysschemas where schemaname = 'INC_BACKUP_SCHEMA');
-- expected 0

select cl_1, cl_2, cl_3, cl_4, cl_5, cl_6, cl_7, cl_8, cl_9, cl_10, cl_11, cl_12, cl_13, cl_14, cl_15, cl_16, cl_17  from INC_BACKUP_SCHEMA.WIDE_TABLE_0 order by 1 asc;
-- expected:
--CL_1 |CL_2 |CL_3                                                                                                                                                                                                                                                            |CL_4    |CL_5      |CL_6    |CL_7                         |CL_8                |CL_9  |CL_10                 |CL_11        |CL_12                 |CL_13      |CL_14 |CL_15        |CL_16 |CL_17
-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--xb3on|b&Xpp|QGFtu                                                                                                                                                                                                                                                           |98      |9161-12-04|21:40:16|1970-01-20 12:49:05.015      |-2010986424305435594|94407 |0.5260820746660415    |0.65892124   |0.30800515            |738714100  |1205  |0.007087469  |2913  |true 

select cl_1, cl_2, cl_3, cl_4, cl_5, cl_6, cl_7, cl_8, cl_9, cl_10, cl_11, cl_12, cl_13, cl_14, cl_15, cl_16, cl_17  from INC_BACKUP_SCHEMA.WIDE_TABLE_1 order by 1 asc;
-- expected ERROR 42X05: Table/View 'INC_BACKUP_SCHEMA.WIDE_TABLE_1' does not exist.
select cl_1, cl_2, cl_3, cl_4, cl_5, cl_6, cl_7, cl_8, cl_9, cl_10, cl_11, cl_12, cl_13, cl_14, cl_15, cl_16, cl_17  from INC_BACKUP_SCHEMA.WIDE_TABLE_2 order by 1 asc;
-- ecpacted ERROR 42X05: Table/View 'INC_BACKUP_SCHEMA.WIDE_TABLE_2' does not exist.
select cl_1, cl_2, cl_3, cl_4, cl_5, cl_6, cl_7, cl_8, cl_9, cl_10, cl_11, cl_12, cl_13, cl_14, cl_15, cl_16, cl_17  from INC_BACKUP_SCHEMA.WIDE_TABLE_3 order by 1 asc;
-- ecpacted ERROR 42X05: Table/View 'INC_BACKUP_SCHEMA.WIDE_TABLE_3' does not exist.
