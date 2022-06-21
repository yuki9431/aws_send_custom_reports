
output_custom_reports () {

    # 引数の整合性確認

    MODE=$1
    REGION=$2
    NAMESPACE=$3
    INSTANCE_ID=$4
    HOST_NAME=$5
    UNIT=$6
    METRIC_NAME=$7
    VALUE=$8

    if [ "${MODE}" = "aws" ]; then
        # CloudWatchにカスタムメトリクスを送信する。
        if [ "${MODE}" != "" ]; then
            aws cloudwatch put-metric-data --metric-name "${METRIC_NAME}" --namespace "${NAMESPACE}" --dimensions "InstanceId=${INSTANCE_ID}, Hostname=${HOST_NAME}" --value "${VALUE}" --unit "${UNIT}" --region ${REGION}
        fi
    else
        # 標準出力にメトリクスの内容を表示する。
        echo "${METRIC_NAME}(${UNIT}): ${VALUE}"    
    fi
}