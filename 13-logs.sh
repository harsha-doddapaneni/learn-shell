#!/bin/bash

user_id=$(id -u)
logs_folder="/var/log/shell-practice"
logs_file="${logs_folder}/${0}.log"

if [ $user_id -ne 0 ]; then
    echo "Please run this script with sudo access.."
    exit 1
fi

mkdir -p $logs_folder

echo "script execution started at $(date +"%Y-%m-%d %H:%M:%S")" | tee -a $logs_file

validate(){
    if [ $1 -ne 0 ]; then
        echo "${2}..FAILED" | tee -a $logs_file
        exit 1
    else
        echo "${2}..SUCCESS" | tee -a $logs_file
    fi
}

dnf install git -y &>> $logs_file
validate $? "Git Installation"

dnf install nginx -y &>> $logs_file
validate $? "Nginx Installation"

dnf install mysql -y &>> $logs_file
validate $? "Mysql Installation"

dnf install postgresql -y &>> $logs_file
validate $? "PostgreSQL Installation"

echo "script execution completed at $(date +"%Y-%m-%d %H:%M:%S")" | tee -a $logs_file

# tee -a $logs_file is used to write the output to both console and log file.
# mkdir -p $logs_folder is used to create the logs folder if it does not exist.