jdbc:splice://[server1:port],[server2:port],[server3:port].../splicedb;[derbyConnectionOptions];[clusteredConnectionOptions]


connect 'jdbc:splice://stl-colo-srv122:1527/splicedb;user=Veronica;password=Veronica'; 

connect 'jdbc:splice://stl-colo-srv127:1527,stl-colo-srv127:1527/splicedb;user=splice;password=admin;clustered=true'; 
connect 'jdbc:splice://stl-colo-srv127:1527,stl-colo-srv128:1527/splicedb;user=splice;password=admin;clustered=true'; 


*** tests
1) CRUD (create, drop, alter) on tables/views(in default/custom schemas)
2) CRUD (insert, update, delete, truncate)in table (all data types)
3) Constraints on tabes(in default/custom schemas)
4) Indexes on tables(in default/custom schemas)
5) Import/Export (happy path with default parameters and several data types)
6) Statistics (basic simple test on table with all data types)
7) User privileges (grant, rewoke)
8) Backup/Restore (danger test case, better to run once) (happy path with default parameters and several data types)

create table pish_schema.f_keys(i int unique);
insert into pish_schema.f_keys(i) values (1)(2)(3)(4)(5);

create table pish_schema.crud_on_table(i int not null constraint pk primary key, j unique constraint fk references pish_schema.f_keys(i));
-- check creation
-- check constraints existence
-- check constraints work
alter table pish_schema.pish drop primary key;
-- check constraints
-- check constraints work
alter table pish_schema.pish drop constraint fk;
-- check constraints
-- check constraints work
alter table pish_schema.pish add column k int;
-- describe table
-- do select to check new column
alter table pish_schema.pish drop column k;
-- describe table
-- do select to check deleted column
alter table pish_schema.pish drop column j;
-- describe table
-- do select to check deleted column

*** options:

** clustered=False
