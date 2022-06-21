output_custom_reports () {

    MODE=${1:?"MODE must be specified"}
    REGION=${2:?"REGION must be specified"}
    NAMESPACE=${3:?"NAMESPACE must be specified"}
    INSTANCE_ID=${4:?"INSTANCE_ID must be specified"}
    HOST_NAME=${5:?"HOST_NAME must be specified"}
    UNIT=${6:?"UNIT must be specified"}
    METRIC_NAME=${7:?"METRIC_NAME must be specified"}
    VALUE=${8:?"VALUE must be specified"}

    if [ "${MODE}" = "aws" ]; then
        # Send metrics to AWS Cloudwatch
        if [ "${MODE}" != "" ]; then
            aws cloudwatch put-metric-data \
            --metric-name "${METRIC_NAME}" \
            --namespace "${NAMESPACE}" \
            --dimensions "InstanceId=${INSTANCE_ID}, Hostname=${HOST_NAME}" \
            --value "${VALUE}" \
            --unit "${UNIT}" \
            --region ${REGION}
        fi
    else
        # Send metrics to stdout
        echo "${METRIC_NAME}(${UNIT}): ${VALUE}"    
    fi
}