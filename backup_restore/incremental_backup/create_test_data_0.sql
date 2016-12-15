DROP TABLE EXT_ORC_0;
DROP TABLE EXT_ORC_1;
DROP TABLE EXT_ORC_2;
DROP TABLE EXT_ORC_3;
DROP TABLE EXT_ORC_4;
-- need to clean /tmp/testdb/sandbox dir

DROP FUNCTION INC_BACKUP_SCHEMA.GET_ABS_0;
DROP FUNCTION INC_BACKUP_SCHEMA.GET_ABS_1;
DROP FUNCTION INC_BACKUP_SCHEMA.GET_ABS_2;
DROP FUNCTION INC_BACKUP_SCHEMA.GET_ABS_3;
DROP FUNCTION INC_BACKUP_SCHEMA.GET_ABS_4;
DROP FUNCTION GET_ABS_0;
DROP FUNCTION GET_ABS_1;
DROP FUNCTION GET_ABS_2;
DROP FUNCTION GET_ABS_3;
DROP FUNCTION GET_ABS_4;
DROP FUNCTION READ_CUSTOM_MAIN_TYPES_0;
DROP FUNCTION READ_CUSTOM_MAIN_TYPES_1;
DROP FUNCTION READ_CUSTOM_MAIN_TYPES_2;
DROP FUNCTION READ_CUSTOM_MAIN_TYPES_3;
DROP FUNCTION READ_CUSTOM_MAIN_TYPES_4;

DROP INDEX INC_BACKUP_SCHEMA.I_CUSTOM_0;
DROP INDEX INC_BACKUP_SCHEMA.I_CUSTOM_1;
DROP INDEX INC_BACKUP_SCHEMA.I_CUSTOM_2;
DROP INDEX INC_BACKUP_SCHEMA.I_CUSTOM_3;
DROP INDEX INC_BACKUP_SCHEMA.I_CUSTOM_4;
DROP INDEX I_DEFAULT_0;
DROP INDEX I_DEFAULT_1;
DROP INDEX I_DEFAULT_2;
DROP INDEX I_DEFAULT_3;
DROP INDEX I_DEFAULT_4;


DROP VIEW INC_BACKUP_SCHEMA.VIEW_0;
DROP VIEW INC_BACKUP_SCHEMA.VIEW_1;
DROP VIEW INC_BACKUP_SCHEMA.VIEW_2;
DROP VIEW INC_BACKUP_SCHEMA.VIEW_3;
DROP VIEW INC_BACKUP_SCHEMA.VIEW_4;
DROP VIEW VIEW_0;
DROP VIEW VIEW_1;
DROP VIEW VIEW_2;
DROP VIEW VIEW_3;
DROP VIEW VIEW_4;

DROP TABLE INC_BACKUP_SCHEMA.TABLE_0;
DROP TABLE INC_BACKUP_SCHEMA.TABLE_1;
DROP TABLE INC_BACKUP_SCHEMA.TABLE_2;
DROP TABLE INC_BACKUP_SCHEMA.TABLE_3;
DROP TABLE INC_BACKUP_SCHEMA.TABLE_4;
DROP TABLE TABLE_0;
DROP TABLE TABLE_1;
DROP TABLE TABLE_2;
DROP TABLE TABLE_3;
DROP TABLE TABLE_4;

DROP TABLE INC_BACKUP_SCHEMA.audit_triggers;
DROP TABLE INC_BACKUP_SCHEMA.fk_table;

DROP SCHEMA INC_BACKUP_SCHEMA RESTRICT;
CREATE SCHEMA INC_BACKUP_SCHEMA;

-- ADDITIONAL TABLES

CREATE TABLE INC_BACKUP_SCHEMA.fk_table(c char unique);
INSERT INTO INC_BACKUP_SCHEMA.fk_table values ('a'),('b'),('c'),('d'),('e'),('f'),('g');

CREATE TABLE INC_BACKUP_SCHEMA.audit_triggers(message VARCHAR(50));

-- TABLES

CREATE TABLE INC_BACKUP_SCHEMA.TABLE_0 (pk_col CHAR constraint pk_values_0 primary key, nfk_col CHAR constraint fk_values_0 references INC_BACKUP_SCHEMA.fk_table(c), ufk_col CHAR, foreign key (ufk_col) references INC_BACKUP_SCHEMA.fk_table(c), nun_col CHAR constraint un_values_0 unique, uun_col CHAR unique, inx_col CHAR, ch_col CHAR (8), lv_col CHAR (8), vc_col VARCHAR (8), dt_col DATE, ti_col TIME, ts_col TIMESTAMP, bl_col BLOB (8), cl_col CLOB (8), bi_col BIGINT, dc_col DECIMAL (5,2), do_col DOUBLE, fl_col FLOAT (24), in_col INTEGER, nu_col NUMERIC (5,2), re_col REAL, si_col SMALLINT, bo_col BOOLEAN);
INSERT INTO INC_BACKUP_SCHEMA.TABLE_0(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col, ch_col, lv_col, vc_col, dt_col, ti_col, ts_col, bl_col, cl_col, bi_col, dc_col, do_col, fl_col, in_col, nu_col, re_col, si_col, bo_col) VALUES ('{', 'a', 'a', '1', '1', '(', 'W+ ?vD:W', 'jYj)mz#f', 'mKJ}G ,;', '4527-03-22', '20:32:58', '1970-01-22 14:33:48.788', CAST(X'62' AS BLOB), '40', 458263475691428698, 58.05, 0.8541313654300117, 0.46841645, -14957700, 65.96, 0.27229637, 11479, true);
INSERT INTO INC_BACKUP_SCHEMA.TABLE_0(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col, ch_col, lv_col, vc_col, dt_col, ti_col, ts_col, bl_col, cl_col, bi_col, dc_col, do_col, fl_col, in_col, nu_col, re_col, si_col, bo_col) VALUES ('.', 'b', 'b', '2', '2', '.', 'M $/z|YZ', '"1Y_]g97', 'W2a*ON^=', '8631-04-16', '05:49:03', '1970-01-10 05:34:47.954', CAST(X'D6' AS BLOB), 'DF', -1080917291095583110, 735.58, 0.9354065844745091, 0.1154476, 1817800869, 453.34, 0.50601053, -16978, false);
INSERT INTO INC_BACKUP_SCHEMA.TABLE_0(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col, ch_col, lv_col, vc_col, dt_col, ti_col, ts_col, bl_col, cl_col, bi_col, dc_col, do_col, fl_col, in_col, nu_col, re_col, si_col, bo_col) VALUES ('}', 'c', 'c', '3', '3', ')', 'jW03}KTt', 'Kc0BO=Pw', '#&W-U(CP', '2353-05-17', '05:22:11', '1970-01-05 15:28:02.58', CAST(X'B1' AS BLOB), '00', -3049620103001785849, 654.20, 0.061076714637138596, 0.5274542, -1661096678, 142.40, 0.7517547, -15988, true);

CREATE TABLE TABLE_0 (pk_col CHAR constraint pk_values_0 primary key, nfk_col CHAR constraint fk_values_0 references INC_BACKUP_SCHEMA.fk_table(c), ufk_col CHAR, foreign key (ufk_col) references INC_BACKUP_SCHEMA.fk_table(c), nun_col CHAR constraint un_values_0 unique, uun_col CHAR unique, inx_col CHAR, ch_col CHAR (8), lv_col CHAR (8), vc_col VARCHAR (8), dt_col DATE, ti_col TIME, ts_col TIMESTAMP, bl_col BLOB (8), cl_col CLOB (8), bi_col BIGINT, dc_col DECIMAL (5,2), do_col DOUBLE, fl_col FLOAT (24), in_col INTEGER, nu_col NUMERIC (5,2), re_col REAL, si_col SMALLINT, bo_col BOOLEAN);
INSERT INTO TABLE_0(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col, ch_col, lv_col, vc_col, dt_col, ti_col, ts_col, bl_col, cl_col, bi_col, dc_col, do_col, fl_col, in_col, nu_col, re_col, si_col, bo_col) VALUES ('{', 'a', 'a', '1', '1', '(', 'ERrhNx]1', 'ba1~|~aM', 'o53nrs<0', '4399-07-20', '07:55:13', '1970-01-03 13:08:04.573', CAST(X'B4' AS BLOB), '64', -2376371414848017599, 133.34, 0.7550526083794682, 0.3900976, 740421337, 467.60, 0.64515483, 16025, true);
INSERT INTO TABLE_0(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col, ch_col, lv_col, vc_col, dt_col, ti_col, ts_col, bl_col, cl_col, bi_col, dc_col, do_col, fl_col, in_col, nu_col, re_col, si_col, bo_col) VALUES ('.', 'b', 'b', '2', '2', '.', 'QR*wk$*$', '`>h`2;`A', 'SGR]0}qy', '5656-06-26', '19:39:35', '1970-01-13 07:43:53.842', CAST(X'7C' AS BLOB), '00', -4929780295422599560, 175.09, 0.8801496057884667, 0.6941312, -682989669, 173.98, 0.26502955, 16882, true);
INSERT INTO TABLE_0(pk_col, nfk_col, ufk_col, nun_col, uun_col, inx_col, ch_col, lv_col, vc_col, dt_col, ti_col, ts_col, bl_col, cl_col, bi_col, dc_col, do_col, fl_col, in_col, nu_col, re_col, si_col, bo_col) VALUES ('}', 'c', 'c', '3', '3', ')', 'MsaSMtfM', 'H^muWa#5', 'uYn>_[ e', '5034-04-29', '12:33:37', '1970-01-20 13:36:08.736', CAST(X'F3' AS BLOB), '18', -3437648090213364791, 109.80, 0.6623078520150635, 0.64419204, -96295862, 15.90, 0.81527704, -25759, true);

-- INDEXES

CREATE INDEX INC_BACKUP_SCHEMA.I_CUSTOM_0 ON INC_BACKUP_SCHEMA.TABLE_0(inx_col);
CREATE INDEX I_DEFAULT_0 ON TABLE_0(inx_col);

-- VIEWS

CREATE VIEW INC_BACKUP_SCHEMA.VIEW_0 as select * from INC_BACKUP_SCHEMA.TABLE_0 order by nun_col;
CREATE VIEW VIEW_0 as select * from TABLE_0 order by nun_col;

-- TRIGGERS

CREATE TRIGGER INC_BACKUP_SCHEMA.T_CUSTOM_0 AFTER INSERT ON INC_BACKUP_SCHEMA.TABLE_0
FOR EACH ROW
INSERT INTO INC_BACKUP_SCHEMA.audit_triggers values ('T_CUSTOM_0');

CREATE TRIGGER T_DEFAULT_0 AFTER INSERT ON TABLE_0
FOR EACH ROW
INSERT INTO INC_BACKUP_SCHEMA.audit_triggers values ('T_DEFAULT_0');

-- FUNCTIONS

CREATE FUNCTION INC_BACKUP_SCHEMA.GET_ABS_0(NUM INTEGER)
RETURNS INTEGER
PARAMETER STYLE JAVA
NO SQL LANGUAGE JAVA
EXTERNAL NAME 'java.lang.Math.abs';

CREATE FUNCTION GET_ABS_0(NUM INTEGER)
RETURNS INTEGER
PARAMETER STYLE JAVA
NO SQL LANGUAGE JAVA
EXTERNAL NAME 'java.lang.Math.abs';

-- berore that:
-- copy2cluster /Users/azhelezny/projects/my/tableFunctionSelect/target/tfSelect-2.0.1.18.jar -host srv126
-- clusterRestart -host srv126

CREATE FUNCTION READ_CUSTOM_MAIN_TYPES_0()
  RETURNS TABLE(it_c INTEGER, vc_c VARCHAR(200), db_c DOUBLE, dc_c DECIMAL, dt_c DATE)
LANGUAGE JAVA
PARAMETER STYLE SPLICE_JDBC_RESULT_SET
READS SQL DATA
EXTERNAL NAME 'main.MainTypesVTI.getMainTypesVTI';

-- to check SELECT * FROM TABLE (READ_CUSTOM_MAIN_TYPES_0()) b order by it_c, vc_c, db_c, dc_c, dt_c desc;
--EXTERNAL TABLE

CREATE EXTERNAL TABLE EXT_ORC_0 (id INT) STORED AS ORC location '/tmp/testdb/sandbox/0';
INSERT INTO EXT_ORC_0 values (1),(2),(3);