show global variables like 'server_id';

stop slave ;
change master to
    master_host ='mmysql',
    master_port = 3306,
    master_user = 'replica',
    master_password = 'replica',
    master_log_file = 'mysql-bin.000001',
    master_log_pos = 0;
start slave;

show slave status ;
show slave hosts ;

show databases;

show global variables like 'server_id';

show global variables like '%relay_log_index%';