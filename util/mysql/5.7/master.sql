drop user if exists 'replica';
create user 'replica'@'%' identified by 'replica';
grant replication slave on *.* to 'replica'@'%';
flush privileges;


flush tables;


show master status;




show global variables like 'server_id';
show global variables like 'binlog_ignore_db';
show global variables like 'binlog_do_db';


