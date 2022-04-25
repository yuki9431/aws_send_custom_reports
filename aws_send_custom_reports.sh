#!/bin/bash

## 元PG:https://www.magtranetwork.com/aws/amazon_cloudwatch_output_custom_metrics.html
## TODO: 
## - Log出力
## - インスタンスIDとホスト名の自動取得
## - 必要な情報をべた書きじゃなくて引数で取得できるように
## - エラーハンドリング

# CloudWatchに送信するカスタムレポート関数
output_custom_reports () {
    REGION=$2
    NAMESPACE=$3
    INSTANCE_ID=$4
    HOST_NAME=$5
    UNIT=$6
    METRIC_NAME=$7
    VALUE=$8

    if [ "${VALUE}" != "" ]; then
        echo "${METRIC_NAME}(${UNIT}): ${VALUE}"
        aws cloudwatch put-metric-data --metric-name "${METRIC_NAME}" --namespace "${NAMESPACE}" --dimensions "InstanceId=${INSTANCE_ID}, Hostname=${HOST_NAME}" --value "${VALUE}" --unit "${UNIT}" --region ${REGION}
    fi
}
 
# CloudWatchのリージョンを指定
REGION="REGION" # "ap-northeast-1"

#AWS CLIのaws cloudwatch put-metric-dataで使用するnamespace, instanceId, Hostnameを指定する。
NAMESPACE="NAMESPACE"
INSTANCE_ID="INSTANCE_ID"
HOST_NAME="HOST_NAME"
 
# シェルスクリプトの引数を取得する。
MODE=$1
# 取得した引数を全て小文字にする。
MODE=`echo "${MODE}" | tr 'A-Z' 'a-z'`

IS_AWS=0
# 引数がawsであればIS_AWS=1にする。
if [ "${MODE}" = "aws" ]; then
  IS_AWS=1
fi

# Apacheプロセス数をpsコマンドで取得する。
NUMBER_OF_PROCESSES=$(( `ps -e | grep httpd | wc -l` - 1 ))
output_custom_reports "${IS_AWS}" "${REGION}" "${NAMESPACE}" "${INSTANCE_ID}" "${HOST_NAME}" "Count" "NumberOfApacheProcesses" "${NUMBER_OF_PROCESSES}"
 
# 80番ポート接続数と待ち受け状態をnetstatコマンドで取得する。
PORT_COUNT80=`netstat -an | grep :80 | grep "ESTABLISHED\|LISTEN" | wc -l`
output_custom_reports "${IS_AWS}" "${REGION}" "${NAMESPACE}" "${INSTANCE_ID}" "${HOST_NAME}" "Count" "PortCount80" "${PORT_COUNT80}"
 
# 443番ポート接続数と待ち受け状態をnetstatコマンドで取得する。
PORT_COUNT443=`netstat -an | grep :443 | grep "ESTABLISHED\|LISTEN" | wc -l`
output_custom_reports "${IS_AWS}" "${REGION}" "${NAMESPACE}" "${INSTANCE_ID}" "${HOST_NAME}" "Count" "PortCount443" "${PORT_COUNT443}"
