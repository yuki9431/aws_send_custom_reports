#!/bin/bash

. aws_send_custom_reports.sh

# stdout: Send standard output 
# aws: Send aws cloudWatch
MODE="aws"

REGION=$1 # "ap-northeast-1"
NAMESPACE=$2 # "namespace"
INSTANCE_ID=$3 # "i-xxxxxxxxxxx"
HOST_NAME=$4 # "host_name"
TARGET_PORT=$5 # "443"

# Check the number of connections and listening state of the port。
PORT_COUNT=$(netstat -an | grep ":${TARGET_PORT}" | grep "ESTABLISHED\|LISTEN" | wc -l)
output_custom_reports "${MODE}" "${REGION}" "${NAMESPACE}" "${INSTANCE_ID}" "${HOST_NAME}" "Count" "PortCount" "${PORT_COUNT}"

exit 0
