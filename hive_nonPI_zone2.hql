CREATE EXTERNAL TABLE if not exists employee_nonPI (ID INT, name STRING, deg STRING, salary INT, dept STRING,updated_at STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS SEQUENCEFILE LOCATION '/user/hive/warehouse/zone2/nonPI';


INSERT OVERWRITE TABLE employee_nonPI SELECT * FROM employee;

select * from employee_nonPI;
