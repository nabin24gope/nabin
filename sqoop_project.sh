#!/bin/bash
CONNECTION_STRING=$1
USERNAME=$2
EN_PASSWORD=$3
TABLE_NAME=$4
TARGET_DIR=$5
MAPPER_NO=$6
SRC_ID=$7
set -ux

#IF the file already exist it will delete it and overwrite it

	hadoop fs -ls $TARGET_DIR/$TABLE_NAME/
	
	if [ $? -eq 0 ];
	then
	hadoop fs -rmr $TARGET_DIR/$TABLE_NAME
	sqoop import  --connect "$CONNECTION_STRING" --username $USERNAME --password $EN_PASSWORD --table $TABLE_NAME --target-dir $TARGET_DIR/$TABLE_NAME -m $MAPPER_NO
	else
	sqoop import  --connect "$CONNECTION_STRING" --username $USERNAME --password $EN_PASSWORD --table $TABLE_NAME --target-dir $TARGET_DIR/$TABLE_NAME -m $MAPPER_NO
	fi

#hive -f hive_zone1_project.hql --hiveconf TABLE_NAME=$TABLE_NAME --hiveconf TARGET_DIR=$TARGET_DIR;

sudo chmod +x /home/training/hive_project.sh

sudo /home/training/hive_project.sh $SRC_ID $TABLE_NAME $TARGET_DIR





