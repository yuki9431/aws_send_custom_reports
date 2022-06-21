# aws_send_custom_reports
Send information to AWS Cloudwatch.

## Requirement
You have aws-cli installed on your server.
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

## How to Use

```sh
# Web Health Check
./web_health_check.sh "INSTANCE_ID" "TARGET_HOST" "NAMESPACE" "REGION" "HOST_NAME"

# Port Monitoring
./port_monitoring.sh "INSTANCE_ID" "TARGET_PORT" "NAMESPACE" "REGION" "HOST_NAME"

```

## Required arguments
- INSTANCE_ID
- TARGET_HOST or TARGET_PORT

## Optional arguments
- NAMESPACE
- REGION
- HOST_NAME

## Debug Mode
Change the MODE to "stdout" if you need to debug mode.

## Author
[Dillen H. Tomida](https://twitter.com/t0mihir0)

## License
This software is licensed under the MIT license, see [LICENSE](./LICENSE) for more information.
