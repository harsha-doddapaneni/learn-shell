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
        dnf install git -y
        dnf install mysql -y
        dnf install nginx -y
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

dnf list installed git
validate $? "Git installation"

dnf list installed mysql
validate $? "MySQL installation"

dnf list installed nginx
validate $? "Nginx installation"