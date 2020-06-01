#!/bin/bash

set -ux

SRC_ID=$1
TABLE_NAME=$2
TARGET_DIR=$3


mask_col=$(mysql -N -utraining -ptraining -D training<<<  "select MASKING_COLUMN from COLUMN_DETAILS where TABLE_NAME ='$TABLE_NAME'")
colm_arr=(${mask_col// /})


for i in ${colm_arr[*]};
do
	if [ "$i" = "Y" ] 
	then
		echo "Masking Column"
		hive -f hive_PI_zone2.hql --hiveconf TABLE_NAME=$TABLE_NAME
		break
	else
		echo "No masking column"
		hive -f hive_nonPI_zone2.hql --hiveconf TABLE_NAME=$TABLE_NAME	
		break
	fi
done

echo "Process completed"
