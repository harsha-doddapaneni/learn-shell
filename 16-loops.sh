#!/bin/bash

# tee -a $logs_file is used to write the output to both console and log file.
# mkdir -p $logs_folder is used to create the logs folder if it does not exist.

user_id=$(id -u)
logs_folder="/var/log/shell-practice"
logs_file="${logs_folder}/${0}.log"

if [ $user_id -ne 0 ]; then
    echo "Please run this script with sudo access.."
    exit 1
fi

mkdir -p $logs_folder

echo "script execution started at $(date +"%Y-%m-%d %H:%M:%S")" | tee -a $logs_file

for package in $@
do
    dnf list installed ${package} &>> $logs_file
    if [ $? -ne 0 ]; then
        echo "Going to install: ${package}"
        dnf install ${package} -y &>> $logs_file
        validate $? "${package} Installation"
    else
        echo "${package} is already installed"
    fi
done

validate(){
    if [ $1 -ne 0 ]; then
        echo "${2}..FAILED" | tee -a $logs_file
        exit 1
    else
        echo "${2}..SUCCESS" | tee -a $logs_file
    fi
}

echo "script execution completed at $(date +"%Y-%m-%d %H:%M:%S")" | tee -a $logs_file
