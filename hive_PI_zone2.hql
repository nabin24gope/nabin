CREATE EXTERNAL TABLE if not exists ${hiveconf:TABLE_NAME}_PI (ID INT, name STRING, deg STRING, salary INT, dept STRING,updated_at STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' STORED AS SEQUENCEFILE LOCATION '/user/hive/warehouse/zone2/${hiveconf:TABLE_NAME}_pi';

add jar /home/training/workspace/Hive_column_masking_UDF.jar;

CREATE TEMPORARY FUNCTION colMask as 'udf.Column_Masking'; 

INSERT OVERWRITE TABLE employee_PI select colMask(id),name,deg,colMask(salary),dept,updated_at from employee;

select * from employee_PI;

