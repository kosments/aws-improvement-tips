#!/bin/bash
EXEC_DATE=$(date '+%Y%m%d%H%M%S')
EXEC_DATE_LOG=$(date '+%Y-%m-%d %H:%M:%S')
LOG_FILE_NAME=/home/ec2-user/test/test_${EXEC_DATE}.log
echo "${EXEC_DATE_LOG}:HelloWorld!" >> ${LOG_FILE_NAME}