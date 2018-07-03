# tf-bootstrap

This project will setup the S3 and DynamoDB pre-requisites for using [Terragrunt](https://github.com/gruntwork-io/terragrunt) with [Terraform](https://www.terraform.io/).

## Dependencies
- git
- [docker-build](https://github.com/alzadude/docker-build) (and all of its **host** dependencies)
- AWS account
- IAM user named `admin`, with policy `arn:aws:iam::aws:policy/AdministratorAccess` attached (or membership of an IAM group with this policy attached)

### Additional Dependencies (if Downloading docker-build Instead of Cloning)
- bash (for process substitution)
- curl

## Install

### Using Git
```
git clone https://github.com/alzadude/docker-build.git
git clone https://github.com/alzadude/tf-bootstrap.git
cd tf-bootstrap
```

## Configure

The `admin` IAM user should be used explicitly, since the 'admin role' isn't available until the corresponding Terraform plan and resources have been applied.

Therefore, because this may not have been done yet, the AWS CLI must be configured to include credentials for the `admin` IAM user.

### AWS Credentials
Add credentials for the `admin` IAM user to `~/.aws/credentials`, e.g.
```
[default]
...

[admin]
aws_access_key_id = <your-credentials>
aws_secret_access_key = <your-credentials>
region = eu-west-1
```

## Usage

### With docker-build Cloned Locally
```
AWS_DEFAULT_PROFILE=admin make -f ../docker-build/docker.mk
```
### With docker-build Cloned Locally, and Local Modifications
```
AWS_DEFAULT_PROFILE=admin ARCHIVE="tar -c --exclude docker-result ." make -f ../docker-build/docker.mk
```
### With docker-build Downloaded Instead of Cloned Locally
```
AWS_DEFAULT_PROFILE=admin make -f <(curl -s -L https://raw.githubusercontent.com/alzadude/docker-build/master/docker.mk)
```

## License

Copyright © 2017 Alex Coyle

Released under the MIT license.