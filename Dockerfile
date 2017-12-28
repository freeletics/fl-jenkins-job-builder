FROM python:2.7-alpine
LABEL maintainer="Freeletics <operations@freeletics.com>"

RUN apk add -v --no-cache \
    curl \
    git

RUN pip install \
        git+https://github.com/freeletics/jenkins-job-builder@stable/1.6#egg=jenkins-job-builder \
        git+https://github.com/freeletics/python-jenkins@master#egg=python-jenkins \
        jenkins-job-builder-addons==1.0.5 \
        jenkins-job-builder-naginator==0.0.1

COPY start.sh /usr/local/bin/jenkins-jobs.sh

RUN chmod +x /usr/local/bin/jenkins-jobs.sh

ENTRYPOINT ["/usr/local/bin/jenkins-jobs.sh"]
