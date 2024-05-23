#!/bin/bash

mkdir -p ./surveyking/mysql
mkdir ./surveyking/sql

cd ./surveyking

wget https://raw.githubusercontent.com/xianyu-one/surveyking-docker/main/sqls/init-mysql.sql -O sqls/init-mysql.sql
wget https://raw.githubusercontent.com/xianyu-one/surveyking-docker/main/docker-compose.yml.example -O docker-compose.yml

docker-compose up -d