Source:

alter database add supplemental log data;
alter system set enable_goldengate_replication=true scope=both;
create tablespace ggs_data datafile '/u01/app/oracle/oradata/orcl/ggssource_data01.dbf' size 1024m autoextend on;
create user ggadmin identified by ggadmin default tablespace ggs_data temporary tablespace temp;
grant connect,resource,create session, alter session to ggadmin;
grant select any dictionary, select any table,create table to ggadmin;
grant alter any table to ggadmin;
grant execute on utl_file to ggadmin;
grant flashback any table to ggadmin;
grant execute on dbms_flashback to ggadmin;
@marker_setup.sql
@ddl_setup.sql
@role_setup.sql
@ddl_enable.sql
@sequence.sql




Target

alter database add supplemental log data
alter system set enable_goldengate_replication=true scope=both;
create tablespace ggs_data datafile '/u01/app/oracle/oradata/orcl/ggstarget_data01.dbf' size 1024m autoextend on;
create user ggadmin identified by ggadmin default tablespace ggs_data temporary tablespace temp;
grant connect,resource,create session, alter session to ggadmin;
grant select any dictionary, select any table,create table to ggadmin;
grant alter any table to ggadmin;
grant execute on utl_file to ggadmin;
grant flashback any table to ggadmin;
grant execute on dbms_flashback to ggadmin;
@marker_setup.sql
@ddl_setup.sql
@role_setup.sql
@ddl_enable.sql
@sequence.sql

