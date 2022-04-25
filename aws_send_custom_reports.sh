#!/bin/bash

## 元PG:https://www.magtranetwork.com/aws/amazon_cloudwatch_output_custom_metrics.html
## TODO: 
## - Log出力
## - インスタンスIDとホスト名の自動取得
## - 必要な情報をべた書きじゃなくて引数で取得できるように
## - エラーハンドリング

# CloudWatchに送信するカスタムレポート関数
output_custom_reports () {
    REGION=$1
    NAMESPACE=$2
    INSTANCE_ID=$3
    HOST_NAME=$4
    UNIT=$5
    METRIC_NAME=$6
    VALUE=$7

    if [ "${VALUE}" != "" ]; then
        echo "${METRIC_NAME}(${UNIT}): ${VALUE}"
        aws cloudwatch put-metric-data --metric-name "${METRIC_NAME}" --namespace "${NAMESPACE}" --dimensions "InstanceId=${INSTANCE_ID}, Hostname=${HOST_NAME}" --value "${VALUE}" --unit "${UNIT}" --region ${REGION}
    fi
}
 
# CloudWatchのリージョンを指定
# TODO: #1 デフォルトは東京リージョン、引数があれば変更する
REGION="REGION" # "ap-northeast-1"

#AWS CLIのaws cloudwatch put-metric-dataで使用するnamespace, instanceId, Hostnameを指定する
# TODO: #2 引数でNamespace, Instance_idを取得する。hostnameコマンドでホスト名を取得
NAMESPACE="NAMESPACE"
INSTANCE_ID="INSTANCE_ID"
HOST_NAME="HOST_NAME"

# Apacheプロセス数をpsコマンドで取得する。
NUMBER_OF_PROCESSES=$(( `ps -e | grep httpd | wc -l` - 1 ))
output_custom_reports "${REGION}" "${NAMESPACE}" "${INSTANCE_ID}" "${HOST_NAME}" "Count" "NumberOfApacheProcesses" "${NUMBER_OF_PROCESSES}"
 
# 80番ポート接続数と待ち受け状態をnetstatコマンドで取得する。
PORT_COUNT80=`netstat -an | grep :80 | grep "ESTABLISHED\|LISTEN" | wc -l`
output_custom_reports "${REGION}" "${NAMESPACE}" "${INSTANCE_ID}" "${HOST_NAME}" "Count" "PortCount80" "${PORT_COUNT80}"
 
# 443番ポート接続数と待ち受け状態をnetstatコマンドで取得する。
PORT_COUNT443=`netstat -an | grep :443 | grep "ESTABLISHED\|LISTEN" | wc -l`
output_custom_reports "${REGION}" "${NAMESPACE}" "${INSTANCE_ID}" "${HOST_NAME}" "Count" "PortCount443" "${PORT_COUNT443}"
