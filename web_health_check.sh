#!/bin/bash

cd $(dirname "$0")
. aws_send_custom_reports.sh

# stdout: Send standard output 
# aws: Send aws cloudWatch
MODE="aws"

REGION=$1 # "ap-northeast-1"
NAMESPACE=$2 # "namespace"
INSTANCE_ID=$3 # "i-xxxxxxxxxxx"
HOST_NAME=$4 # "host_name"
TARGET_HOST=$5 # "localhost:8080/health.html"

# Health check of TARGET_HOST
http_code=$(curl ${TARGET_HOST} -s -w '%{http_code}\n' -o /dev/null)

if [ "${http_code}" = "200" ]; then
    HostIsHealthy=1
else 
    HostIsHealthy=0
fi

output_custom_reports \
    "${MODE}" \
    "${REGION}" \
    "${NAMESPACE}" \
    "${INSTANCE_ID}" \
    "${HOST_NAME}" \
    "Count" \
    "HostIsHealthy" \
    "${HostIsHealthy}"