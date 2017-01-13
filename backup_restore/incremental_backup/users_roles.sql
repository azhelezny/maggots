-- SETUP
DROP TABLE INC_BACKUP_SCHEMA.TUSERS_0;
DROP TABLE INC_BACKUP_SCHEMA.TUSERS_1;
DROP TABLE INC_BACKUP_SCHEMA.TUSERS_2;
DROP TABLE INC_BACKUP_SCHEMA.TUSERS_3;
DROP TABLE INC_BACKUP_SCHEMA.TUSERS_4;
DROP TABLE TROLES_0;
DROP TABLE TROLES_1;
DROP TABLE TROLES_2;
DROP TABLE TROLES_3;
DROP TABLE TROLES_4;
DROP ROLE role_0;
DROP ROLE role_1;
DROP ROLE role_2;
DROP ROLE role_3;
DROP ROLE role_4;
CALL SYSCS_UTIL.SYSCS_DROP_USER('user_0');
CALL SYSCS_UTIL.SYSCS_DROP_USER('user_1');
CALL SYSCS_UTIL.SYSCS_DROP_USER('user_2');
CALL SYSCS_UTIL.SYSCS_DROP_USER('user_3');
CALL SYSCS_UTIL.SYSCS_DROP_USER('user_4');

CREATE TABLE INC_BACKUP_SCHEMA.TUSERS_0(i integer);
INSERT INTO INC_BACKUP_SCHEMA.TUSERS_0 values(0);
CREATE TABLE INC_BACKUP_SCHEMA.TUSERS_1(i integer);
INSERT INTO INC_BACKUP_SCHEMA.TUSERS_1 values(1);
CREATE TABLE INC_BACKUP_SCHEMA.TUSERS_2(i integer);
INSERT INTO INC_BACKUP_SCHEMA.TUSERS_2 values(2);
CREATE TABLE INC_BACKUP_SCHEMA.TUSERS_3(i integer);
INSERT INTO INC_BACKUP_SCHEMA.TUSERS_3 values(3);
CREATE TABLE INC_BACKUP_SCHEMA.TUSERS_4(i integer);
INSERT INTO INC_BACKUP_SCHEMA.TUSERS_4 values(4);

CREATE TABLE TROLES_0(i integer);
INSERT INTO TROLES_0 values(0);
CREATE TABLE TROLES_1(i integer);
INSERT INTO TROLES_1 values(1);
CREATE TABLE TROLES_2(i integer);
INSERT INTO TROLES_2 values(2);
CREATE TABLE TROLES_3(i integer);
INSERT INTO TROLES_3 values(3);
CREATE TABLE TROLES_4(i integer);
INSERT INTO TROLES_4 values(4);

-- USERS and ROLES

CALL SYSCS_UTIL.SYSCS_CREATE_USER('user_0', 'user_0');
CREATE ROLE role_0;
GRANT SELECT ON TABLE INC_BACKUP_SCHEMA.TUSERS_0 TO user_0;
GRANT SELECT ON TABLE TROLES_0 TO role_0;
GRANT role_0 to user_0;

CALL SYSCS_UTIL.SYSCS_CREATE_USER('user_4', 'user_4');
CREATE ROLE role_4;
GRANT SELECT ON TABLE INC_BACKUP_SCHEMA.TUSERS_0 TO user_4;
GRANT SELECT ON TABLE INC_BACKUP_SCHEMA.TUSERS_1 TO user_4;
GRANT SELECT ON TABLE INC_BACKUP_SCHEMA.TUSERS_2 TO user_4;
GRANT SELECT ON TABLE INC_BACKUP_SCHEMA.TUSERS_3 TO user_4;
GRANT SELECT ON TABLE INC_BACKUP_SCHEMA.TUSERS_4 TO user_4;
GRANT SELECT ON TABLE TROLES_0 TO role_4;
GRANT SELECT ON TABLE TROLES_1 TO role_4;
GRANT SELECT ON TABLE TROLES_2 TO role_4;
GRANT SELECT ON TABLE TROLES_3 TO role_4;
GRANT SELECT ON TABLE TROLES_4 TO role_4;
GRANT role_4 to user_4;

-- CHECK USERS and ROLES

SELECT count(USERNAME) from sys.SYSUSERS where USERNAME in ('USER_0', 'USER_4');
-- expected 2
SELECT count(USERNAME) from sys.SYSUSERS where USERNAME in ('USER_1', 'USER_2', 'USER_3');
-- expected 0

SELECT count(*) from sys.SYSROLES where ROLEID in ('ROLE_0', 'ROLE_4') and GRANTEE != 'SPLICE';
-- expected 2
SELECT count(*) from sys.SYSROLES where ROLEID in ('ROLE_1', 'ROLE_2', 'ROLE_3');
-- expected 0

connect 'jdbc:splice://localhost:1527/splicedb;user=user_1;password=user_1';
-- expected ERROR 08004: Connection authentication failure occurred.  Reason: userid or password invalid.
connect 'jdbc:splice://localhost:1527/splicedb;user=user_2;password=user_2';
-- expected ERROR 08004: Connection authentication failure occurred.  Reason: userid or password invalid.
connect 'jdbc:splice://localhost:1527/splicedb;user=user_3;password=user_3';
-- expected ERROR 08004: Connection authentication failure occurred.  Reason: userid or password invalid.

connect 'jdbc:splice://localhost:1527/splicedb;user=user_0;password=user_0';
SET ROLE role_0;

SELECT * FROM INC_BACKUP_SCHEMA.TUSERS_0;
--expected 0
SELECT * FROM INC_BACKUP_SCHEMA.TUSERS_1;
--expected ERROR 42502: User 'USER_0' does not have SELECT permission on column 'I' of table 'INC_BACKUP_SCHEMA'.'TUSERS_1'.
SELECT * FROM INC_BACKUP_SCHEMA.TUSERS_2;
--expected ERROR 42502: User 'USER_0' does not have SELECT permission on column 'I' of table 'INC_BACKUP_SCHEMA'.'TUSERS_2'.
SELECT * FROM INC_BACKUP_SCHEMA.TUSERS_3;
--expected ERROR 42502: User 'USER_0' does not have SELECT permission on column 'I' of table 'INC_BACKUP_SCHEMA'.'TUSERS_3'.
SELECT * FROM INC_BACKUP_SCHEMA.TUSERS_4;
--expected ERROR 42502: User 'USER_0' does not have SELECT permission on column 'I' of table 'INC_BACKUP_SCHEMA'.'TUSERS_4'.

SELECT * FROM SPLICE.TROLES_0;
--expected 0
SELECT * FROM SPLICE.TROLES_1;
--expected ERROR 42502: User 'USER_0' does not have SELECT permission on column 'I' of table 'SPLICE'.'TROLES_1'.
SELECT * FROM SPLICE.TROLES_2;
--expected ERROR 42502: User 'USER_0' does not have SELECT permission on column 'I' of table 'SPLICE'.'TROLES_2'.
SELECT * FROM SPLICE.TROLES_3;
--expected ERROR 42502: User 'USER_0' does not have SELECT permission on column 'I' of table 'SPLICE'.'TROLES_3'.
SELECT * FROM SPLICE.TROLES_4;
--expected ERROR 42502: User 'USER_0' does not have SELECT permission on column 'I' of table 'SPLICE'.'TROLES_4'.


connect 'jdbc:splice://localhost:1527/splicedb;user=user_4;password=user_4';
SET ROLE role_4;

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

