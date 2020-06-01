#!/bin/bash

set -ux

SRC_ID=$1
TABLE_NAME=$2
TARGET_DIR=$3
#TABLE_DETAILS=$(mysql -N -utraining -ptraining -D training<<<  "select * from TABLE_DETAILS where SRC_ID=$SRC_ID and $TABLE_NAME")

hive -f hive_zone1_project.hql --hiveconf TABLE_NAME=$TABLE_NAME --hiveconf TARGET_DIR=$TARGET_DIR/$TABLE_NAME;

#hive_table="CREATE EXTERNAL TABLE if not exists $TABLE_NAME (ID INT, name STRING, deg STRING, salary INT, dept STRING,updated_at STRING) ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LOCATION '$TARGET_DIR';"

#echo "$hive_table" > project_hive.hql
# Zone 2 SelECtion

sudo chmod +x /home/training/hive_zone2_project.sh
sudo /home/training/hive_zone2_project.sh $SRC_ID $TABLE_NAME $TARGET_DIR

