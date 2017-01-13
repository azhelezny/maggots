select BACKUP_ID, END_TIMESTAMP, STATUS, INCREMENTAL_BACKUP, INCREMENTAL_PARENT_BACKUP_ID, FILESYSTEM from sys.sysbackup order by end_timestamp desc;

call SYSCS_UTIL.SYSCS_BACKUP_DATABASE('hdfs:///automation/backup', 'full');
call SYSCS_UTIL.SYSCS_BACKUP_DATABASE('/automation/backup', 'full');
call SYSCS_UTIL.SYSCS_BACKUP_DATABASE('hdfs:///automation/backup', 'incremental');
call SYSCS_UTIL.SYSCS_RESTORE_DATABASE('hdfs:///automation/backup', 292);

call SYSCS_UTIL.SYSCS_DELETE_BACKUP(292);

SYSCS_SCHEDULE_DAILY_BACKUP
SYSCS_CANCEL_BACKUP 
SYSCS_CANCEL_DAILY_BACKUP 
SYSCS_DELETE_BACKUP
SYSCS_DELETE_OLD_BACKUPS


SYSCS_BACKUP_DATABASE  SYSCS_CANCEL_BACKUP SYSCS_CANCEL_DAILY_BACKUP SYSCS_DELETE_BACKUP     SYSCS_DELETE_OLD_BACKUPS  SYSCS_RESTORE_DATABASE SYSCS_SCHEDULE_DAILY_BACKUP


alias hfs='sudo -su hdfs hadoop fs'
hfs -rm -R -f /tmp/testdb/sandbox
hfs -mkdir /tmp/testdb/sandbox
hfs -mkdir /tmp/testdb/sandbox/0
hfs -chmod -R 777  /tmp/testdb/sandbox
hfs -rm -R -f /automation
hfs -mkdir /automation
hfs -mkdir /automation/backup
hfs -chmod -R 777  /automation


CREATE TABLE T(I INTEGER);
call SYSCS_UTIL.SYSCS_BACKUP_DATABASE('hdfs:///automation/backup', 'incremental');
select BACKUP_ID, END_TIMESTAMP, STATUS, INCREMENTAL_BACKUP, INCREMENTAL_PARENT_BACKUP_ID, FILESYSTEM from sys.sysbackup order by end_timestamp desc;

INSERT INTO T values (1),(2);
call SYSCS_UTIL.SYSCS_BACKUP_DATABASE('hdfs:///automation/backup', 'incremental');
select BACKUP_ID, END_TIMESTAMP, STATUS, INCREMENTAL_BACKUP, INCREMENTAL_PARENT_BACKUP_ID, FILESYSTEM from sys.sysbackup order by end_timestamp desc;

CREATE EXTERNAL TABLE EXT_ORC_0 (id INT) STORED AS ORC location '/tmp/testdb/sandbox/0';
call SYSCS_UTIL.SYSCS_BACKUP_DATABASE('hdfs:///automation/backup', 'incremental');
select BACKUP_ID, END_TIMESTAMP, STATUS, INCREMENTAL_BACKUP, INCREMENTAL_PARENT_BACKUP_ID, FILESYSTEM from sys.sysbackup order by end_timestamp desc;