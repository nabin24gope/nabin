#!/bin/bash
set -ux

TARGET_DIR=$1
MAPPER_NO=$2
SRC_ID=$3
DB_DETAILS=$(mysql -N -utraining -ptraining -D training<<<  "select * from DB_DETAILS where SRC_ID=$SRC_ID")
TABLE_DETAILS=$(mysql -N -utraining -ptraining -D training<<<  "select TABLE_NAME from TABLE_DETAILS where SRC_ID=$SRC_ID")

db_arr=(${DB_DETAILS// /})
tb_arr=(${TABLE_DETAILS// /})


HOST_NAME=${db_arr[1]}
USERNAME=${db_arr[2]}
EN_PASSWORD=${db_arr[3]}
DATABESE_TYPE=${db_arr[4]}
APPLICATION_NAME=${db_arr[5]}
CONNECTION_STRING=${db_arr[6]}
HIVE_DATABASE_NAME=${db_arr[7]}

TABLE_NAME=${tb_arr[1]}

echo "$MAPPER_NO"
echo "$TARGET_DIR"

echo "$TABLE_NAME"
#exit 0

#Password decryption for sqooop
pass_path=`cat /home/training/proj_pass.text| head -1`

DE_PASSWORD=$(echo "$EN_PASSWORD"| openssl enc -aes-256-cbc -a -d -salt -pass pass:wtf -k $pass_path)

echo "$DE_PASSWORD"

sudo chmod +x /home/training/sqoop_project.sh
for i in "${tb_arr[@]}"
do
sudo /home/training/sqoop_project.sh "$CONNECTION_STRING" "$USERNAME" "$DE_PASSWORD" "$i" "$TARGET_DIR" "$MAPPER_NO" "$SRC_ID"
done
#sqoop import  --connect "$CONNECTION_STRING" --username $USERNAME --password $EN_PASSWORD --table $TABLE_NAME --target-dir $TARGET_DIR


#sqoop import --connect "$CONNECTION_STRING" --username $USERNAME --password $PASSWORD --table $TABLE_NAME --target-dir $TARGET_DIR
			  
#user_name=$(grep -i 'USERNAME' $x  | cut -f2 -d' ')
#table_name=$(grep -i 'tableName' $FILE  | cut -f2 -d'=')

