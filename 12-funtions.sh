#!/bin/bash

USERID=$(id -u)
#echo "User ID is: $USERID"

if [ $USERID -ne 0 ]
then
    echo "Please run this script with root priveleges"
    exit 1
fi

validate(){
    if [ $1 -ne 0 ]
    then
        echo "${2}.. installation is failure..please check"
        if [ $1 -ne 0 ]
        then
            echo "${2}.. installation is not success...check it"
            exit 1
        else
            echo "${2}.. installation is success"
        fi
    else
        echo "${2}.. is already installed, nothing to do.."
    fi
}

dnf install git -y
validate $? "Git installation"

dnf install mysql -y
validate $? "MySQL installation"

dnf install nginx -y
validate $? "Nginx installation"