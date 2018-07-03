FROM amazonlinux:2016.09

RUN yum -q -y install jq aws-cli && yum clean all

ADD config /root/.aws/
