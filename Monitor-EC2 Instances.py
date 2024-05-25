# pip install boto3
import boto3
from datetime import datetime, timezone

def get_ec2_instances():
    ec2 = boto3.client('ec2')
    response = ec2.describe_instances()
    instances = []

    for reservation in response['Reservations']:
        for instance in reservation['Instances']:
            instances.append(instance)
    return instances

def check_instance_status(instance):
    state = instance['State']['Name']
    launch_time = instance['LaunchTime']
    current_time = datetime.now(timezone.utc)
    running_time = current_time - launch_time

    status_indicator = "🟢" if state == 'running' else "🔴"

    return f"{status_indicator} Instance ID: {instance['InstanceId']}, State: {state}, Running Time: {running_time}"

def main():
    instances = get_ec2_instances()
    for instance in instances:
        status = check_instance_status(instance)
        print(status)

if __name__ == "__main__":
    main()
