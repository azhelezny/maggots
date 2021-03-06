-- CHECK
-- SYNONYMS
SELECT * FROM SY_CUSTOM_1;
-- expected 1
SELECT * FROM SY_CUSTOM_5;
-- expected 1


SELECT * FROM SY_CUSTOM_0;
-- expected ERROR 42X05: Table/View 'SY_CUSTOM_2' does not exist.
SELECT * FROM SY_CUSTOM_2;
-- expected ERROR 42X05: Table/View 'SY_CUSTOM_2' does not exist.
SELECT * FROM SY_CUSTOM_3;
-- expected ERROR 42X05: Table/View 'SY_CUSTOM_2' does not exist.
SELECT * FROM SY_CUSTOM_4;
-- expected ERROR 42X05: Table/View 'SY_CUSTOM_2' does not exist.

SELECT * FROM SY_DEFAULT_1;
-- expected 2
SELECT * FROM SY_DEFAULT_5;
-- expected 2

SELECT * FROM SY_DEFAULT_0;
-- expected ERROR 42X05: Table/View 'SY_CUSTOM_2' does not exist.
SELECT * FROM SY_DEFAULT_2;
-- expected ERROR 42X05: Table/View 'SY_CUSTOM_2' does not exist.
SELECT * FROM SY_DEFAULT_3;
-- expected ERROR 42X05: Table/View 'SY_CUSTOM_2' does not exist.
SELECT * FROM SY_DEFAULT_4;
-- expected ERROR 42X05: Table/View 'SY_CUSTOM_2' does not exist.

-- SEQUENCES

SELECT count(*) from sys.SYSSEQUENCES where sequencename in ('SE_1', 'SE_5');
-- ecpected 2
SELECT count(*) from sys.SYSSEQUENCES where sequencename in ('SE_0', 'SE_2', 'SE_3', 'SE_4');
-- ecpected 0

VALUES (NEXT VALUE for SE_1);
-- expected 104
VALUES (NEXT VALUE for SE_5);
-- expected 500

/*
Disabled due to 
VALUES (NEXT VALUE for SE_0);
-- expected ERROR_SQEUENCE
VALUES (NEXT VALUE for SE_2);
-- expected ERROR_SQEUENCE
VALUES (NEXT VALUE for SE_4);
-- expected ERROR_SQEUENCE
VALUES (NEXT VALUE for SE_5);
-- expected ERROR_SQEUENCE
*/
-- USERS and ROLES

SELECT count(USERNAME) from sys.SYSUSERS where USERNAME in ('USER_0', 'USER_4');
-- expected 3
SELECT count(USERNAME) from sys.SYSUSERS where USERNAME in ('USER_1', 'USER_2', 'USER_3');
-- expected 0

SELECT count(*) from sys.SYSROLES where ROLEID in ('ROLE_0', 'ROLE_4') and GRANTEE != 'SPLICE';
-- expected 3
SELECT count(*) from sys.SYSROLES where ROLEID in ('ROLE_1', 'ROLE_2', 'ROLE_3');
-- expected 0

connect 'jdbc:splice://localhost:1527/splicedb;user=user_2;password=user_1';
-- expected ERROR 08004: Connection authentication failure occurred.  Reason: userid or password invalid.
connect 'jdbc:splice://localhost:1527/splicedb;user=user_2;password=user_2';
-- expected ERROR 08004: Connection authentication failure occurred.  Reason: userid or password invalid.
connect 'jdbc:splice://localhost:1527/splicedb;user=user_3;password=user_3';
-- expected ERROR 08004: Connection authentication failure occurred.  Reason: userid or password invalid.

connect 'jdbc:splice://localhost:1527/splicedb;user=user_0;password=user_0';

SELECT * FROM INC_BACKUP_SCHEMA.TUSERS_0;
--expected 0
SELECT * FROM INC_BACKUP_SCHEMA.TUSERS_1;
--expected 1
SELECT * FROM INC_BACKUP_SCHEMA.TUSERS_2;
--expected 2
SELECT * FROM INC_BACKUP_SCHEMA.TUSERS_3;
--expected 3
SELECT * FROM INC_BACKUP_SCHEMA.TUSERS_4;
--expected 4

SET ROLE role_0;

SELECT * FROM SPLICE.TROLES_0;
--expected 0
SELECT * FROM SPLICE.TROLES_1;
--expected 1
SELECT * FROM SPLICE.TROLES_2;
--expected 2
SELECT * FROM SPLICE.TROLES_3;
--expected 3
SELECT * FROM SPLICE.TROLES_4;
--expected 4

connect 'jdbc:splice://localhost:1527/splicedb;user=user_4;password=user_4';

SELECT * FROM INC_BACKUP_SCHEMA.TUSERS_4;
--expected 4
SELECT * FROM INC_BACKUP_SCHEMA.TUSERS_0;
--expected ERROR 42502: User 'USER_4' does not have SELECT permission on column 'I' of table 'INC_BACKUP_SCHEMA'.'TUSERS_0'.
SELECT * FROM INC_BACKUP_SCHEMA.TUSERS_1;
--expected ERROR 42502: User 'USER_4' does not have SELECT permission on column 'I' of table 'INC_BACKUP_SCHEMA'.'TUSERS_1'.
SELECT * FROM INC_BACKUP_SCHEMA.TUSERS_2;
--expected ERROR 42502: User 'USER_4' does not have SELECT permission on column 'I' of table 'INC_BACKUP_SCHEMA'.'TUSERS_2'.
SELECT * FROM INC_BACKUP_SCHEMA.TUSERS_3;
--expected ERROR 42502: User 'USER_4' does not have SELECT permission on column 'I' of table 'INC_BACKUP_SCHEMA'.'TUSERS_3'.

SET ROLE role_4;

SELECT * FROM SPLICE.TROLES_4;
--expected 4
SELECT * FROM SPLICE.TROLES_0;
--expected ERROR 42502: User 'USER_4' does not have SELECT permission on column 'I' of table 'SPLICE'.'TROLES_0'.
SELECT * FROM SPLICE.TROLES_1;
--expected ERROR 42502: User 'USER_4' does not have SELECT permission on column 'I' of table 'SPLICE'.'TROLES_1'.
SELECT * FROM SPLICE.TROLES_2;
--expected ERROR 42502: User 'USER_4' does not have SELECT permission on column 'I' of table 'SPLICE'.'TROLES_2'.
SELECT * FROM SPLICE.TROLES_3;
--expected ERROR 42502: User 'USER_4' does not have SELECT permission on column 'I' of table 'SPLICE'.'TROLES_3'.

SET ROLE role_0;
--expected ERROR 0P000: Invalid role specification, role not granted to current user or PUBLIC: 'ROLE_0'.
SET ROLE role_1;
--expected ERROR 0P000: Invalid role specification, role does not exist: 'ROLE_1'.
SET ROLE role_2;
--expected ERROR 0P000: Invalid role specification, role does not exist: 'ROLE_2'.
SET ROLE role_3;
--expected ERROR 0P000: Invalid role specification, role does not exist: 'ROLE_3'.

connect 'jdbc:splice://localhost:1527/splicedb;user=splice;password=admin';

-- TABLES

SELECT count(*) from INC_BACKUP_SCHEMA.FK_TABLE;
-- 7 expected
SELECT count(*) from INC_BACKUP_SCHEMA.AUDIT_TRIGGERS;
-- 0 expected

SELECT count(*) as TABLES from sys.SYSTABLES where tablename = 'TABLE_0' and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME IN ('INC_BACKUP_SCHEMA', 'SPLICE'));
-- 2 expected
SELECT count(*) as TABLES from sys.SYSTABLES where tablename = 'TABLE_1' and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME IN ('INC_BACKUP_SCHEMA', 'SPLICE'));
-- 2 expected
SELECT count(*) as TABLES from sys.SYSTABLES where tablename = 'TABLE_2' and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME IN ('INC_BACKUP_SCHEMA', 'SPLICE'));
-- 2 expected
SELECT count(*) as TABLES from sys.SYSTABLES where tablename = 'TABLE_3' and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME IN ('INC_BACKUP_SCHEMA', 'SPLICE'));
-- 2 expected
SELECT count(*) as TABLES from sys.SYSTABLES where tablename = 'TABLE_4' and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME IN ('INC_BACKUP_SCHEMA', 'SPLICE'));
-- 2 expected

SELECT * from INC_BACKUP_SCHEMA.TABLE_0 order by nun_col;
-- 7 rows expected
SELECT * from TABLE_0 order by nun_col;
-- 7 rows expected
SELECT * from INC_BACKUP_SCHEMA.TABLE_1 order by nun_col;
-- 6 rows expected
SELECT * from TABLE_1 order by nun_col;
-- 6 rows expected
SELECT * from INC_BACKUP_SCHEMA.TABLE_2 order by nun_col;
-- 5 rows expected
SELECT * from TABLE_2 order by nun_col;
-- 5 rows expected
SELECT * from INC_BACKUP_SCHEMA.TABLE_3 order by nun_col;
-- 4 rows expected
SELECT * from TABLE_3 order by nun_col;
-- 4 rows expected
SELECT * from INC_BACKUP_SCHEMA.TABLE_4 order by nun_col;
-- 3 rows expected
SELECT * from TABLE_4 order by nun_col;
-- 3 rows expected

-- VIEWS 

SELECT count(*) as VIEWS from sys.SYSTABLES where tablename = 'VIEW_0' and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME in ('INC_BACKUP_SCHEMA', 'SPLICE'));
-- 2 expected
SELECT count(*) as VIEWS from sys.SYSTABLES where tablename = 'VIEW_1' and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME in ('INC_BACKUP_SCHEMA', 'SPLICE'));
-- 2 expected
SELECT count(*) as VIEWS from sys.SYSTABLES where tablename = 'VIEW_2' and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME in ('INC_BACKUP_SCHEMA', 'SPLICE'));
-- 2 expected
SELECT count(*) as VIEWS from sys.SYSTABLES where tablename = 'VIEW_3' and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME in ('INC_BACKUP_SCHEMA', 'SPLICE'));
-- 2 expected
SELECT count(*) as VIEWS from sys.SYSTABLES where tablename = 'VIEW_4' and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME in ('INC_BACKUP_SCHEMA', 'SPLICE'));
-- 2 expected

SELECT * from INC_BACKUP_SCHEMA.VIEW_0;
-- 7 rows expected
SELECT * from VIEW_0;
-- 7 rows expected
SELECT * from INC_BACKUP_SCHEMA.VIEW_1;
-- 6 rows expected
SELECT * from VIEW_1;
-- 6 rows expected
SELECT * from INC_BACKUP_SCHEMA.VIEW_2;
-- 5 rows expected
SELECT * from VIEW_2;
-- 5 rows expected
SELECT * from INC_BACKUP_SCHEMA.VIEW_3;
-- 4 rows expected
SELECT * from VIEW_3;
-- 4 rows expected
SELECT * from INC_BACKUP_SCHEMA.VIEW_4;
-- 3 rows expected
SELECT * from VIEW_4;
-- 3 rows expected

-- INDEXES

SELECT count(*) as INDEXES from sys.SYSCONGLOMERATES where isindex=true and CONGLOMERATENAME in ('I_CUSTOM_4', 'I_DEFAULT_4') in (SELECT tableid from sys.SYSTABLES where tablename = 'TABLE_0') and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME in ('INC_BACKUP_SCHEMA', 'SPLICE'));
-- 2 expected
SELECT count(*) as INDEXES from sys.SYSCONGLOMERATES where isindex=true and CONGLOMERATENAME in ('I_CUSTOM_0', 'I_CUSTOM_1', 'I_CUSTOM_2', 'I_CUSTOM_3', 'I_DEFAULT_0', 'I_DEFAULT_1', 'I_DEFAULT_2', 'I_DEFAULT_3') in (SELECT tableid from sys.SYSTABLES where tablename = 'TABLE_0') and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME in ('INC_BACKUP_SCHEMA', 'SPLICE'));
-- 0 expected

-- CONSTRAINTS

SELECT count(*) from sys.SYSCONSTRAINTS where type in ('P', 'U', 'F') and tableid in (SELECT tableid from sys.SYSTABLES where tablename = 'TABLE_0') and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME = 'INC_BACKUP_SCHEMA');
-- 5 expected
INSERT INTO inc_backup_schema.TABLE_0(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES (NULL, 'a', 'a', '8', '8', '(');
-- expected ERROR 23502: Column 'PK_COL' cannot accept a NULL value.
INSERT INTO inc_backup_schema.TABLE_0(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '1', '8', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'UN_NULLS' defined on 'TABLE_0'.
INSERT INTO inc_backup_schema.TABLE_0(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '8', '1', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'SQL161213132957731' defined on 'TABLE_0'.
INSERT INTO inc_backup_schema.TABLE_0(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'w', 'a', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_0' caused a violation of foreign key constraint 'FK_EMPTY' for key (NFK_COL).  The statement has been rolled back.
INSERT INTO inc_backup_schema.TABLE_0(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'w', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_0' caused a violation of foreign key constraint 'SQL161213132940800' for key (UFK_COL).  The statement has been rolled back.


SELECT count(*) from sys.SYSCONSTRAINTS where type in ('P', 'U', 'F') and tableid in (SELECT tableid from sys.SYSTABLES where tablename = 'TABLE_0') and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME = 'SPLICE');
-- 5 expected
INSERT INTO TABLE_0(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES (NULL, 'a', 'a', '8', '8', '(');
-- expected ERROR 23502: Column 'PK_COL' cannot accept a NULL value.
INSERT INTO TABLE_0(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '1', '8', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'UN_NULLS' defined on 'TABLE_0'.
INSERT INTO TABLE_0(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '8', '1', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'SQL161213132957731' defined on 'TABLE_0'.
INSERT INTO TABLE_0(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'w', 'a', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_0' caused a violation of foreign key constraint 'FK_EMPTY' for key (NFK_COL).  The statement has been rolled back.
INSERT INTO TABLE_0(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'w', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_0' caused a violation of foreign key constraint 'SQL161213132940800' for key (UFK_COL).  The statement has been rolled back.

SELECT count(*) from sys.SYSCONSTRAINTS where type in ('P', 'U', 'F') and tableid in (SELECT tableid from sys.SYSTABLES where tablename = 'TABLE_1') and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME = 'INC_BACKUP_SCHEMA');
-- 5 expected
INSERT INTO inc_backup_schema.TABLE_1(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES (NULL, 'a', 'a', '8', '8', '(');
-- expected ERROR 23502: Column 'PK_COL' cannot accept a NULL value.
INSERT INTO inc_backup_schema.TABLE_1(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '1', '8', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'UN_NULLS' defined on 'TABLE_1'.
INSERT INTO inc_backup_schema.TABLE_1(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '8', '1', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'SQL161213132957731' defined on 'TABLE_1'.
INSERT INTO inc_backup_schema.TABLE_1(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'w', 'a', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_1' caused a violation of foreign key constraint 'FK_EMPTY' for key (NFK_COL).  The statement has been rolled back.
INSERT INTO inc_backup_schema.TABLE_1(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'w', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_1' caused a violation of foreign key constraint 'SQL161213132940800' for key (UFK_COL).  The statement has been rolled back.


SELECT count(*) from sys.SYSCONSTRAINTS where type in ('P', 'U', 'F') and tableid in (SELECT tableid from sys.SYSTABLES where tablename = 'TABLE_1') and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME = 'SPLICE');
-- 5 expected
INSERT INTO TABLE_1(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES (NULL, 'a', 'a', '8', '8', '(');
-- expected ERROR 23502: Column 'PK_COL' cannot accept a NULL value.
INSERT INTO TABLE_1(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '1', '8', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'UN_NULLS' defined on 'TABLE_1'.
INSERT INTO TABLE_1(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '8', '1', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'SQL161213132957731' defined on 'TABLE_1'.
INSERT INTO TABLE_1(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'w', 'a', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_1' caused a violation of foreign key constraint 'FK_EMPTY' for key (NFK_COL).  The statement has been rolled back.
INSERT INTO TABLE_1(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'w', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_1' caused a violation of foreign key constraint 'SQL161213132940800' for key (UFK_COL).  The statement has been rolled back.

SELECT count(*) from sys.SYSCONSTRAINTS where type in ('P', 'U', 'F') and tableid in (SELECT tableid from sys.SYSTABLES where tablename = 'TABLE_2') and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME = 'INC_BACKUP_SCHEMA');
-- 5 expected
INSERT INTO inc_backup_schema.TABLE_2(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES (NULL, 'a', 'a', '8', '8', '(');
-- expected ERROR 23502: Column 'PK_COL' cannot accept a NULL value.
INSERT INTO inc_backup_schema.TABLE_2(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '1', '8', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'UN_NULLS' defined on 'TABLE_2'.
INSERT INTO inc_backup_schema.TABLE_2(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '8', '1', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'SQL161213132957731' defined on 'TABLE_2'.
INSERT INTO inc_backup_schema.TABLE_2(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'w', 'a', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_2' caused a violation of foreign key constraint 'FK_EMPTY' for key (NFK_COL).  The statement has been rolled back.
INSERT INTO inc_backup_schema.TABLE_2(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'w', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_2' caused a violation of foreign key constraint 'SQL161213132940800' for key (UFK_COL).  The statement has been rolled back.


SELECT count(*) from sys.SYSCONSTRAINTS where type in ('P', 'U', 'F') and tableid in (SELECT tableid from sys.SYSTABLES where tablename = 'TABLE_2') and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME = 'SPLICE');
-- 5 expected
INSERT INTO TABLE_2(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES (NULL, 'a', 'a', '8', '8', '(');
-- expected ERROR 23502: Column 'PK_COL' cannot accept a NULL value.
INSERT INTO TABLE_2(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '1', '8', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'UN_NULLS' defined on 'TABLE_2'.
INSERT INTO TABLE_2(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '8', '1', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'SQL161213132957731' defined on 'TABLE_2'.
INSERT INTO TABLE_2(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'w', 'a', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_2' caused a violation of foreign key constraint 'FK_EMPTY' for key (NFK_COL).  The statement has been rolled back.
INSERT INTO TABLE_2(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'w', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_2' caused a violation of foreign key constraint 'SQL161213132940800' for key (UFK_COL).  The statement has been rolled back.

SELECT count(*) from sys.SYSCONSTRAINTS where type in ('P', 'U', 'F') and tableid in (SELECT tableid from sys.SYSTABLES where tablename = 'TABLE_3') and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME = 'INC_BACKUP_SCHEMA');
-- 5 expected
INSERT INTO inc_backup_schema.TABLE_3(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES (NULL, 'a', 'a', '8', '8', '(');
-- expected ERROR 23502: Column 'PK_COL' cannot accept a NULL value.
INSERT INTO inc_backup_schema.TABLE_3(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '1', '8', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'UN_NULLS' defined on 'TABLE_3'.
INSERT INTO inc_backup_schema.TABLE_3(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '8', '1', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'SQL161213132957731' defined on 'TABLE_3'.
INSERT INTO inc_backup_schema.TABLE_3(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'w', 'a', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_3' caused a violation of foreign key constraint 'FK_EMPTY' for key (NFK_COL).  The statement has been rolled back.
INSERT INTO inc_backup_schema.TABLE_3(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'w', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_3' caused a violation of foreign key constraint 'SQL161213132940800' for key (UFK_COL).  The statement has been rolled back.


SELECT count(*) from sys.SYSCONSTRAINTS where type in ('P', 'U', 'F') and tableid in (SELECT tableid from sys.SYSTABLES where tablename = 'TABLE_3') and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME = 'SPLICE');
-- 5 expected
INSERT INTO TABLE_3(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES (NULL, 'a', 'a', '8', '8', '(');
-- expected ERROR 23502: Column 'PK_COL' cannot accept a NULL value.
INSERT INTO TABLE_3(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '1', '8', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'UN_NULLS' defined on 'TABLE_3'.
INSERT INTO TABLE_3(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '8', '1', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'SQL161213132957731' defined on 'TABLE_3'.
INSERT INTO TABLE_3(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'w', 'a', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_3' caused a violation of foreign key constraint 'FK_EMPTY' for key (NFK_COL).  The statement has been rolled back.
INSERT INTO TABLE_3(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'w', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_3' caused a violation of foreign key constraint 'SQL161213132940800' for key (UFK_COL).  The statement has been rolled back.

SELECT count(*) from sys.SYSCONSTRAINTS where type in ('P', 'U', 'F') and tableid in (SELECT tableid from sys.SYSTABLES where tablename = 'TABLE_4') and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME = 'INC_BACKUP_SCHEMA');
-- 5 expected
INSERT INTO inc_backup_schema.TABLE_4(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES (NULL, 'a', 'a', '8', '8', '(');
-- expected ERROR 23502: Column 'PK_COL' cannot accept a NULL value.
INSERT INTO inc_backup_schema.TABLE_4(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '1', '8', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'UN_NULLS' defined on 'TABLE_4'.
INSERT INTO inc_backup_schema.TABLE_4(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '8', '1', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'SQL161213132957731' defined on 'TABLE_4'.
INSERT INTO inc_backup_schema.TABLE_4(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'w', 'a', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_4' caused a violation of foreign key constraint 'FK_EMPTY' for key (NFK_COL).  The statement has been rolled back.
INSERT INTO inc_backup_schema.TABLE_4(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'w', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_4' caused a violation of foreign key constraint 'SQL161213132940800' for key (UFK_COL).  The statement has been rolled back.


SELECT count(*) from sys.SYSCONSTRAINTS where type in ('P', 'U', 'F') and tableid in (SELECT tableid from sys.SYSTABLES where tablename = 'TABLE_4') and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME = 'SPLICE');
-- 5 expected
INSERT INTO TABLE_4(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES (NULL, 'a', 'a', '8', '8', '(');
-- expected ERROR 23502: Column 'PK_COL' cannot accept a NULL value.
INSERT INTO TABLE_4(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '1', '8', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'UN_NULLS' defined on 'TABLE_4'.
INSERT INTO TABLE_4(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'a', '8', '1', '(');
-- expected ERROR 23505: The statement was aborted because it would have caused a duplicate key value in a unique or primary key constraint or unique index identified by 'SQL161213132957731' defined on 'TABLE_4'.
INSERT INTO TABLE_4(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'w', 'a', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_4' caused a violation of foreign key constraint 'FK_EMPTY' for key (NFK_COL).  The statement has been rolled back.
INSERT INTO TABLE_4(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'a', 'w', '8', '8', '(');
-- expected ERROR 23503: Operation on table 'TABLE_4' caused a violation of foreign key constraint 'SQL161213132940800' for key (UFK_COL).  The statement has been rolled back.


-- TRIGGERS

SELECT triggername from sys.SYSTRIGGERS where tableid in (SELECT tableid from sys.SYSTABLES where tablename = 'TABLE_4') and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME in ('INC_BACKUP_SCHEMA', 'SPLICE'));
-- expected 
		--T_CUSTOM_4
		--T_DEFAULT_4

INSERT INTO INC_BACKUP_SCHEMA.TABLE_4(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'c', 'c', '5', '5', ')');
INSERT INTO TABLE_4(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col) VALUES ('T', 'c', 'c', '5', '5', ')');

SELECT * from INC_BACKUP_SCHEMA.AUDIT_TRIGGERS order by 1;
-- expected: 
		--T_CUSTOM_4
		--T_DEFAULT_4
DELETE FROM INC_BACKUP_SCHEMA.AUDIT_TRIGGERS;

DELETE FROM INC_BACKUP_SCHEMA.TABLE_4 WHERE pk_col ='T';
DELETE FROM TABLE_4 WHERE pk_col ='T';

-- PROCEDURES

SELECT count(*) from sys.SYSALIASES where alias = 'GET_ABS_4' and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME in ('INC_BACKUP_SCHEMA', 'SPLICE'));
-- expected 2
SELECT count(*) from sys.SYSALIASES where alias in ('GET_ABS_0', 'GET_ABS_1', 'GET_ABS_2', 'GET_ABS_3') and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME in ('INC_BACKUP_SCHEMA', 'SPLICE'));
-- expected 0


select INC_BACKUP_SCHEMA.GET_ABS_4(-1) from INC_BACKUP_SCHEMA.fk_table;
-- expected data

select INC_BACKUP_SCHEMA.GET_ABS_3(-1) from INC_BACKUP_SCHEMA.fk_table;
-- expected no function
select INC_BACKUP_SCHEMA.GET_ABS_2(-1) from INC_BACKUP_SCHEMA.fk_table;
-- expected no function
select INC_BACKUP_SCHEMA.GET_ABS_1(-1) from INC_BACKUP_SCHEMA.fk_table;
-- expected no function
select INC_BACKUP_SCHEMA.GET_ABS_0(-1) from INC_BACKUP_SCHEMA.fk_table;
-- expected no function


select GET_ABS_4(-1) from INC_BACKUP_SCHEMA.fk_table;
-- expected data

select GET_ABS_3(-1) from INC_BACKUP_SCHEMA.fk_table;
-- expected no function
select GET_ABS_2(-1) from INC_BACKUP_SCHEMA.fk_table;
-- expected no function
select GET_ABS_1(-1) from INC_BACKUP_SCHEMA.fk_table;
-- expected no function
select GET_ABS_0(-1) from INC_BACKUP_SCHEMA.fk_table;
-- expected no function

SELECT * FROM TABLE (READ_CUSTOM_MAIN_TYPES_4()) b order by it_c, vc_c, db_c, dc_c, dt_c desc;
-- expected some table with random data

SELECT * FROM TABLE (READ_CUSTOM_MAIN_TYPES_0()) b order by it_c, vc_c, db_c, dc_c, dt_c desc;
-- expected ERROR 42ZB4: 'SPLICE'.READ_CUSTOM_MAIN_TYPES_0' does not identify a table function.
SELECT * FROM TABLE (READ_CUSTOM_MAIN_TYPES_1()) b order by it_c, vc_c, db_c, dc_c, dt_c desc;
-- expected ERROR 42ZB4: 'SPLICE'.READ_CUSTOM_MAIN_TYPES_1' does not identify a table function.
SELECT * FROM TABLE (READ_CUSTOM_MAIN_TYPES_2()) b order by it_c, vc_c, db_c, dc_c, dt_c desc;
-- expected ERROR 42ZB4: 'SPLICE'.READ_CUSTOM_MAIN_TYPES_2' does not identify a table function.
SELECT * FROM TABLE (READ_CUSTOM_MAIN_TYPES_3()) b order by it_c, vc_c, db_c, dc_c, dt_c desc;
-- expected ERROR 42ZB4: 'SPLICE'.READ_CUSTOM_MAIN_TYPES_4' does not identify a table function.

/*Disabled due to DB-5715

-- EXTERNAL TABLE
SELECT * FROM EXT_ORC_0 order by 1;
-- expected: 7 rows
SELECT * FROM EXT_ORC_1 order by 1;
-- expected: 6 rows
SELECT * FROM EXT_ORC_2 order by 1;
-- expected: 5 rows
SELECT * FROM EXT_ORC_3 order by 1;
-- expected: 4 rows
SELECT * FROM EXT_ORC_4 order by 1;
-- expected: 3 rows
*/

;