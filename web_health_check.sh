#!/bin/bash

cd $(dirname "$0")
. aws_send_custom_reports.sh

MODE="aws"

# Required arguments
INSTANCE_ID=${1:?"INSTANCE_ID must be specified"}
TARGET_HOST=${2:?"TARGET_HOST must be specified"}

# Optional arguments
NAMESPACE=${3:-"aws_send_custom_reports"}
REGION=${4:-"ap-northeast-1"}
HOST_NAME=${5:-"$(hostname)"}


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