#!/bin/bash

cd $(dirname "$0")
. aws_send_custom_reports.sh

MODE="aws"

# Required arguments
INSTANCE_ID=${1:?"INSTANCE_ID must be specified"}
TARGET_PORT=${2:?"TARGET_PORT must be specified"}

# Optional arguments
NAMESPACE=${3:-"aws_send_custom_reports"}
REGION=${4:-"ap-northeast-1"}
HOST_NAME=${5:-"$(hostname)"}

# Check the number of connections and listening state of the port
PORT_COUNT=$(netstat -an | grep ":${TARGET_PORT}" | grep "ESTABLISHED\|LISTEN" | wc -l)
output_custom_reports \
    "${MODE}" \
    "${REGION}" \
    "${NAMESPACE}" \
    "${INSTANCE_ID}" \
    "${HOST_NAME}" \
    "Count" \
    "PortCount" \
    "${PORT_COUNT}"