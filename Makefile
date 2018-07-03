
all: s3-bucket s3-bucket-versioning s3-bucket-acl iam-policy

s3-bucket:
	aws s3api head-bucket --bucket imin-tf-state || \
	  aws s3 mb s3://imin-tf-state

s3-bucket-versioning: s3-bucket
	aws s3api put-bucket-versioning --bucket imin-tf-state --versioning-configuration Status=Enabled

s3-bucket-acl: s3-bucket-versioning
	aws s3api put-bucket-acl --bucket imin-tf-state --grant-write uri=http://acs.amazonaws.com/groups/global/AllUsers

iam-policy:
	aws iam list-policies --scope Local | \
	  jq -e '.Policies[] | select(.PolicyName == "TfBootstrap")' > /dev/null || \
	    aws iam create-policy --policy-name TfBootstrap --policy-document file://iam-policy.json

.PHONY: all s3-bucket s3-bucket-versioning s3-bucket-acl iam-policy
