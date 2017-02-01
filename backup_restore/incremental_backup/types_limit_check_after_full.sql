select count(*) from sys.systables where tablename in ('MAX_MIN_VALUES_0') and schemaid in (select schemaid from sys.sysschemas where schemaname = 'INC_BACKUP_SCHEMA');
-- expected 1 
select count(*) from sys.systables where tablename in ('MAX_MIN_VALUES_1', 'MAX_MIN_VALUES_2', 'MAX_MIN_VALUES_3' ) and schemaid in (select schemaid from sys.sysschemas where schemaname = 'INC_BACKUP_SCHEMA');
-- expected 0

select * from INC_BACKUP_SCHEMA.MAX_MIN_VALUES_0 order by 1 asc;
-- expected:
-- ID    |DT_COL    |TM_COL  |TS_COL                       |SI_COL|IN_COL     |BI_COL              |RE_COL       |DB_COL                
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 0     |0001-01-01|00:00:00|1678-01-01 00:00:00.0        |-32768|-2147483648|-9223372036854775808|-3.402E38    |-1.79769E308          
-- 1     |9999-12-31|00:00:00|2262-01-01 00:00:00.0        |32767 |2147483647 |9223372036854775807 |3.402E38     |1.79769E308           
-- 2     |2017-02-02|12:30:30|2017-07-31 12:30:30.0        |12345 |1234567890 |1234567891011121314 |3.40199997E10|1.79769E100  

select * from INC_BACKUP_SCHEMA.MAX_MIN_VALUES_1 order by 1 asc;
-- expected ERROR 42X05: Table/View 'INC_BACKUP_SCHEMA.MAX_MIN_VALUES_1' does not exist.

select * from INC_BACKUP_SCHEMA.MAX_MIN_VALUES_2 order by 1 asc;
-- expected ERROR 42X05: Table/View 'INC_BACKUP_SCHEMA.MAX_MIN_VALUES_2' does not exist.

select * from INC_BACKUP_SCHEMA.MAX_MIN_VALUES_3 order by 1 asc;
-- expected ERROR 42X05: Table/View 'INC_BACKUP_SCHEMA.MAX_MIN_VALUES_3' does not exist.
