-- CONSTRAINTS

--  DISABLED :
-- 1 UNABLE TO DROP PRIMARY KEY
-- 2 UNIQUE CONSTAINT VALIDATES VALUES AFTER DROP

-- INDEXES

DROP INDEX INC_BACKUP_SCHEMA.I_CUSTOM_1;
DROP INDEX I_DEFAULT_1;

SELECT count(*) as INDEXES from sys.SYSCONGLOMERATES where isindex=true and CONGLOMERATENAME in ('I_CUSTOM_1', 'I_DEFAULT_1') and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME in ('INC_BACKUP_SCHEMA', 'SPLICE'));
-- expected 0

-- TRIGGERS/TABLES/VIEWS

DROP TRIGGER INC_BACKUP_SCHEMA.T_CUSTOM_1;
DROP TRIGGER T_DEFAULT_1;

SELECT triggername from sys.SYSTRIGGERS where schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME in ('INC_BACKUP_SCHEMA', 'SPLICE'));
-- expected no results

DELETE FROM INC_BACKUP_SCHEMA.AUDIT_TRIGGERS;

INSERT INTO INC_BACKUP_SCHEMA.TABLE_0(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col, ch_col, lv_col, vc_col, dt_col, ti_col, ts_col, bl_col, cl_col, bi_col, dc_col, do_col, fl_col, in_col, nu_col, re_col, si_col, bo_col) VALUES ('X', 'e', 'e', '5', '5', ')', 'jW03}KTt', 'Kc0BO=Pw', '#&W-U(CP', '2353-05-17', '05:22:11', '1970-01-05 15:28:02.58', CAST(X'B1' AS BLOB), '00', -3049620103001785849, 654.20, 0.061076714637138596, 0.5274542, -1661096678, 142.40, 0.7517547, -15988, true);
INSERT INTO TABLE_0(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col, ch_col, lv_col, vc_col, dt_col, ti_col, ts_col, bl_col, cl_col, bi_col, dc_col, do_col, fl_col, in_col, nu_col, re_col, si_col, bo_col) VALUES ('X', 'e', 'e', '5', '5', ')', 'jW03}KTt', 'Kc0BO=Pw', '#&W-U(CP', '2353-05-17', '05:22:11', '1970-01-05 15:28:02.58', CAST(X'B1' AS BLOB), '00', -3049620103001785849, 654.20, 0.061076714637138596, 0.5274542, -1661096678, 142.40, 0.7517547, -15988, true);
INSERT INTO INC_BACKUP_SCHEMA.TABLE_1(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col, ch_col, lv_col, vc_col, dt_col, ti_col, ts_col, bl_col, cl_col, bi_col, dc_col, do_col, fl_col, in_col, nu_col, re_col, si_col, bo_col) VALUES ('W', 'd', 'd', '4', '4', ')', 'jW03}KTt', 'Kc0BO=Pw', '#&W-U(CP', '2353-05-17', '05:22:11', '1970-01-05 15:28:02.58', CAST(X'B1' AS BLOB), '00', -3049620103001785849, 654.20, 0.061076714637138596, 0.5274542, -1661096678, 142.40, 0.7517547, -15988, true);
INSERT INTO TABLE_1(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col, ch_col, lv_col, vc_col, dt_col, ti_col, ts_col, bl_col, cl_col, bi_col, dc_col, do_col, fl_col, in_col, nu_col, re_col, si_col, bo_col) VALUES ('W', 'd', 'd', '4', '4', ')', 'jW03}KTt', 'Kc0BO=Pw', '#&W-U(CP', '2353-05-17', '05:22:11', '1970-01-05 15:28:02.58', CAST(X'B1' AS BLOB), '00', -3049620103001785849, 654.20, 0.061076714637138596, 0.5274542, -1661096678, 142.40, 0.7517547, -15988, true);

SELECT * from INC_BACKUP_SCHEMA.AUDIT_TRIGGERS order by 1;
-- expected: no results

SELECT * from INC_BACKUP_SCHEMA.TABLE_1 order by nun_col;
-- expected 4 rows
SELECT * from TABLE_1 order by nun_col;
-- expected 4 rows

-- STORED FUNCTIONS

DROP FUNCTION INC_BACKUP_SCHEMA.GET_ABS_1;
DROP FUNCTION GET_ABS_1;

SELECT count(*) from sys.SYSALIASES where alias = 'GET_ABS_1' and schemaid in (SELECT SCHEMAID from sys.SYSSCHEMAS WHERE SCHEMANAME in ('INC_BACKUP_SCHEMA', 'SPLICE'));
-- expected 0

select INC_BACKUP_SCHEMA.GET_ABS_1(-1) from INC_BACKUP_SCHEMA.fk_table;
-- expected no function
select GET_ABS_1(-1) from INC_BACKUP_SCHEMA.fk_table;
-- expected no function


-- TABLE FUNCTION

DROP FUNCTION READ_CUSTOM_MAIN_TYPES_1;

SELECT * FROM TABLE (READ_CUSTOM_MAIN_TYPES_1()) b order by it_c, vc_c, db_c, dc_c, dt_c desc;
-- expected no function

-- EXTERNAL TABLE
INSERT INTO EXT_ORC_0 values (5);
INSERT INTO EXT_ORC_1 values (4);

SELECT * FROM EXT_ORC_0 order by 1;
-- expected 5 rows
SELECT * FROM EXT_ORC_1 order by 1;
-- expected 4 rows

-- STEP-SPECIFIC ENTRIES CREATION

-- TABLES

CREATE TABLE INC_BACKUP_SCHEMA.TABLE_2 (pk_col CHAR constraint pk_values_2 primary key, nfk_col CHAR constraint fk_values_2 references INC_BACKUP_SCHEMA.fk_table(c), ufk_col CHAR, foreign key (ufk_col) references INC_BACKUP_SCHEMA.fk_table(c), nun_col CHAR constraint un_values_2 unique, uun_col CHAR unique, inx_col CHAR, ch_col CHAR (8), lv_col CHAR (8), vc_col VARCHAR (8), dt_col DATE, ti_col TIME, ts_col TIMESTAMP, bl_col BLOB (8), cl_col CLOB (8), bi_col BIGINT, dc_col DECIMAL (5,2), do_col DOUBLE, fl_col FLOAT (24), in_col INTEGER, nu_col NUMERIC (5,2), re_col REAL, si_col SMALLINT, bo_col BOOLEAN);
INSERT INTO INC_BACKUP_SCHEMA.TABLE_2(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col, ch_col, lv_col, vc_col, dt_col, ti_col, ts_col, bl_col, cl_col, bi_col, dc_col, do_col, fl_col, in_col, nu_col, re_col, si_col, bo_col) VALUES ('{', 'a', 'a', '1', '1', '(', 'W+ ?vD:W', 'jYj)mz#f', 'mKJ}G ,;', '4527-03-22', '20:32:58', '1970-01-22 14:33:48.788', CAST(X'62' AS BLOB), '40', 458263475691428698, 58.05, 0.8541313654300117, 0.46841645, -14957700, 65.96, 0.27229637, 11479, true);
INSERT INTO INC_BACKUP_SCHEMA.TABLE_2(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col, ch_col, lv_col, vc_col, dt_col, ti_col, ts_col, bl_col, cl_col, bi_col, dc_col, do_col, fl_col, in_col, nu_col, re_col, si_col, bo_col) VALUES ('.', 'b', 'b', '2', '2', '.', 'M $/z|YZ', '"1Y_]g97', 'W2a*ON^=', '8631-04-16', '05:49:03', '1970-01-10 05:34:47.954', CAST(X'D6' AS BLOB), 'DF', -1080917291095583110, 735.58, 0.9354065844745091, 0.1154476, 1817800869, 453.34, 0.50601053, -16978, false);
INSERT INTO INC_BACKUP_SCHEMA.TABLE_2(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col, ch_col, lv_col, vc_col, dt_col, ti_col, ts_col, bl_col, cl_col, bi_col, dc_col, do_col, fl_col, in_col, nu_col, re_col, si_col, bo_col) VALUES ('}', 'c', 'c', '3', '3', ')', 'jW03}KTt', 'Kc0BO=Pw', '#&W-U(CP', '2353-05-17', '05:22:11', '1970-01-05 15:28:02.58', CAST(X'B1' AS BLOB), '00', -3049620103001785849, 654.20, 0.061076714637138596, 0.5274542, -1661096678, 142.40, 0.7517547, -15988, true);

CREATE TABLE TABLE_2 (pk_col CHAR constraint pk_values_2 primary key, nfk_col CHAR constraint fk_values_2 references INC_BACKUP_SCHEMA.fk_table(c), ufk_col CHAR, foreign key (ufk_col) references INC_BACKUP_SCHEMA.fk_table(c), nun_col CHAR constraint un_values_2 unique, uun_col CHAR unique, inx_col CHAR, ch_col CHAR (8), lv_col CHAR (8), vc_col VARCHAR (8), dt_col DATE, ti_col TIME, ts_col TIMESTAMP, bl_col BLOB (8), cl_col CLOB (8), bi_col BIGINT, dc_col DECIMAL (5,2), do_col DOUBLE, fl_col FLOAT (24), in_col INTEGER, nu_col NUMERIC (5,2), re_col REAL, si_col SMALLINT, bo_col BOOLEAN);
INSERT INTO TABLE_2(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col, ch_col, lv_col, vc_col, dt_col, ti_col, ts_col, bl_col, cl_col, bi_col, dc_col, do_col, fl_col, in_col, nu_col, re_col, si_col, bo_col) VALUES ('{', 'a', 'a', '1', '1', '(', 'ERrhNx]1', 'ba1~|~aM', 'o53nrs<0', '4399-07-20', '07:55:13', '1970-01-03 13:08:04.573', CAST(X'B4' AS BLOB), '64', -2376371414848017599, 133.34, 0.7550526083794682, 0.3900976, 740421337, 467.60, 0.64515483, 16025, true);
INSERT INTO TABLE_2(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col, ch_col, lv_col, vc_col, dt_col, ti_col, ts_col, bl_col, cl_col, bi_col, dc_col, do_col, fl_col, in_col, nu_col, re_col, si_col, bo_col) VALUES ('.', 'b', 'b', '2', '2', '.', 'QR*wk$*$', '`>h`2;`A', 'SGR]0}qy', '5656-06-26', '19:39:35', '1970-01-13 07:43:53.842', CAST(X'7C' AS BLOB), '00', -4929780295422599560, 175.09, 0.8801496057884667, 0.6941312, -682989669, 173.98, 0.26502955, 16882, true);
INSERT INTO TABLE_2(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col, ch_col, lv_col, vc_col, dt_col, ti_col, ts_col, bl_col, cl_col, bi_col, dc_col, do_col, fl_col, in_col, nu_col, re_col, si_col, bo_col) VALUES ('}', 'c', 'c', '3', '3', ')', 'MsaSMtfM', 'H^muWa#5', 'uYn>_[ e', '5034-04-29', '12:33:37', '1970-01-20 13:36:08.736', CAST(X'F3' AS BLOB), '18', -3437648090213364791, 109.80, 0.6623078520150635, 0.64419204, -96295862, 15.90, 0.81527704, -25759, true);

-- INDEXES

CREATE INDEX INC_BACKUP_SCHEMA.I_CUSTOM_2 ON INC_BACKUP_SCHEMA.TABLE_2(inx_col);
CREATE INDEX I_DEFAULT_2 ON TABLE_2(inx_col);

-- VIEWS

CREATE VIEW INC_BACKUP_SCHEMA.VIEW_2 as select * from INC_BACKUP_SCHEMA.TABLE_2 order by nun_col;
CREATE VIEW VIEW_2 as select * from TABLE_2 order by nun_col;

-- TRIGGERS

CREATE TRIGGER INC_BACKUP_SCHEMA.T_CUSTOM_2 AFTER INSERT ON INC_BACKUP_SCHEMA.TABLE_2
FOR EACH ROW
INSERT INTO INC_BACKUP_SCHEMA.audit_triggers values ('T_CUSTOM_2');

CREATE TRIGGER T_DEFAULT_2 AFTER INSERT ON TABLE_2
FOR EACH ROW
INSERT INTO INC_BACKUP_SCHEMA.audit_triggers values ('T_DEFAULT_2');

-- FUNCTIONS

CREATE FUNCTION INC_BACKUP_SCHEMA.GET_ABS_2(NUM INTEGER)
RETURNS INTEGER
PARAMETER STYLE JAVA
NO SQL LANGUAGE JAVA
EXTERNAL NAME 'java.lang.Math.abs';

CREATE FUNCTION GET_ABS_2(NUM INTEGER)
RETURNS INTEGER
PARAMETER STYLE JAVA
NO SQL LANGUAGE JAVA
EXTERNAL NAME 'java.lang.Math.abs';

-- berore that:
-- copy2cluster /Users/azhelezny/projects/my/tableFunctionSelect/target/tfSelect-2.0.1.18.jar -host srv126
-- clusterRestart -host srv126

CREATE FUNCTION READ_CUSTOM_MAIN_TYPES_2()
  RETURNS TABLE(it_c INTEGER, vc_c VARCHAR(200), db_c DOUBLE, dc_c DECIMAL, dt_c DATE)
LANGUAGE JAVA
PARAMETER STYLE SPLICE_JDBC_RESULT_SET
READS SQL DATA
EXTERNAL NAME 'main.MainTypesVTI.getMainTypesVTI';

-- to check SELECT * FROM TABLE (READ_CUSTOM_MAIN_TYPES_2()) b order by it_c, vc_c, db_c, dc_c, dt_c desc;
--EXTERNAL TABLE

CREATE EXTERNAL TABLE EXT_ORC_2 (id INT) STORED AS ORC location '/tmp/testdb/sandbox/2';
INSERT INTO EXT_ORC_2 values (1),(2),(3);