#!/bin/bash

###############################################################
#   Author: Ameen
#   Version: 0.0.1v
#
# Script to check the running service on aws automatically by giving the service and region name in argument 
# Below are the service list:
# 1. EC2
# 2. RDS
# 3. S3
# 4. CloudFront
# 5. VPC
# 6. IAM
# 7. Route53
# 8. CloudWatch
# 9. CloudFormation
# 10. Lambda
# 11. SNS
# 12. SQS
# 13. DynamoDB
# 14. VPC
# 15. EBS
#
#
# Usage :  ./aws_resource_list.sh <region> <service_name>
# Example:  /aws_resource_list.sh us-east-1 EC2
###############################################################

#validate if argument are proepr or not 
if [$# -ne 2];                     # this tell if no.of arguments ($#)  is not equal ( -ne) to 2 , then echo below statement 
then 
    echo "Incomplete Arguments"
    echo "Usage :  ./aws_resource_list.sh <region> <service_name>"
    echo "Example:  /aws_resource_list.sh us-east-1 EC2"
    exit 1    #exit with non 0 status , showing error 
fi 


#check if aws cli is install or not 
if [! command -v aws &> /dev/null]; then     # here (command -v) will check if aws path is present or not and send output path # &> redirecting output to /dev/null which discard and error or output silently 
    echo " aws cli not installed, please install aws cli and try again"
    exit 1
fi

#check if aws cli is configured or not 
if [! -d ~/.aws];then
    echo " please configure the aws cli using 'aws configure' and try again "
    exit 1
fi

#List the resources list using case 
aws_region=$1                         #1 represnt first argument i.e aws region , $0 reperstn 0th argument i.e ./aws_resource_list.sh
aws_service=$(echo "$2" | tr '[:upper:]' '[:lower:]')    #converting upper case of given argument to lower case, using tr ( translate command)

case $aws_service in       #switch case
    ec2)
        echo "Listing EC2 Instances in $aws_region"
        aws ec2 describe-instances --region $aws_region
        ;;
    rds)
        echo "Listing RDS Instances in $aws_region"
        aws rds describe-db-instances --region $aws_region
        ;;
    s3)
        echo "Listing S3 Buckets in $aws_region"
        aws s3api list-buckets --region $aws_region
        ;;
    cloudfront)
        echo "Listing CloudFront Distributions in $aws_region"
        aws cloudfront list-distributions --region $aws_region
        ;;
    vpc)
        echo "Listing VPCs in $aws_region"
        aws ec2 describe-vpcs --region $aws_region
        ;;
    iam)
        echo "Listing IAM Users in $aws_region"
        aws iam list-users --region $aws_region
        ;;
    route5)
        echo "Listing Route53 Hosted Zones in $aws_region"
        aws route53 list-hosted-zones --region $aws_region
        ;;
    cloudwatch)
        echo "Listing CloudWatch Alarms in $aws_region"
        aws cloudwatch describe-alarms --region $aws_region
        ;;
    cloudformation)
        echo "Listing CloudFormation Stacks in $aws_region"
        aws cloudformation describe-stacks --region $aws_region
        ;;
    lambda)
        echo "Listing Lambda Functions in $aws_region"
        aws lambda list-functions --region $aws_region
        ;;
    sns)
        echo "Listing SNS Topics in $aws_region"
        aws sns list-topics --region $aws_region
        ;;
    sqs)
        echo "Listing SQS Queues in $aws_region"
        aws sqs list-queues --region $aws_region
        ;;
    dynamodb)
        echo "Listing DynamoDB Tables in $aws_region"
        aws dynamodb list-tables --region $aws_region
        ;;
    ebs)
        echo "Listing EBS Volumes in $aws_region"
        aws ec2 describe-volumes --region $aws_region
        ;;
    *)
        echo "Invalid service. Please enter a valid service."
        exit 1
        ;;
esac
        





