FROM python:2.7-alpine
MAINTAINER Freeletics <operations@freeletics.com>

ARG JJB_URL=git+https://github.com/freeletics/jenkins-job-builder.git@stable/1.6#egg=jenkins-job-builder
ARG PYTHON_JENKINS_URL=git+https://github.com/freeletics/python-jenkins.git#egg=python-jenkins

RUN apk add -v --no-cache \
    curl \
    git

RUN pip install -e $PYTHON_JENKINS_URL -e $JJB_URL \
    && pip install jenkins-job-builder-addons

COPY start.sh /usr/local/bin/jenkins-jobs.sh

RUN chmod +x /usr/local/bin/jenkins-jobs.sh

ENTRYPOINT ["/usr/local/bin/jenkins-jobs.sh"]