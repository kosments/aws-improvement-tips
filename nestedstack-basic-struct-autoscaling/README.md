# nestedstack-basic-struct-autoscaling

## Introduction

Build a 3-layer web autoscaling configuration extremely quickly using CloudFormation.

## Diagram

![img](./diagram/basic-struct.svg)

## How to run and clean up

### 1.cloudformation template bucket

create/update/delete

```sh
aws cloudformation create-stack --region ap-northeast-1 --stack-name test-cfn-template-bucket --template-body file://test-cfn-template-bucket.yml
aws cloudformation update-stack --region ap-northeast-1 --stack-name test-cfn-template-bucket --template-body file://test-cfn-template-bucket.yml
aws cloudformation delete-stack --region ap-northeast-1 --stack-name test-cfn-template-bucket
```

### 2.cloudformation create root stack

create/update/delete

```sh
aws cloudformation create-stack --region ap-northeast-1 --stack-name test-root-stack --template-body file://test-root-stack.yml --capabilities CAPABILITY_NAMED_IAM
aws cloudformation update-stack --region ap-northeast-1 --stack-name test-root-stack --template-body file://test-root-stack.yml
aws cloudformation delete-stack --region ap-northeast-1 --stack-name test-root-stack
```
