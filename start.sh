#!/bin/sh

reset="\033[0m"
red="\033[31m"
green="\033[32m"
yellow="\033[33m"

if [[ -n $XDG_CACHE_HOME ]] && [[ ! -d $XDG_CACHE_HOME ]]; then
    printf "$yellow> Initializing jenkins job builder cache...$reset\n"
    mkdir -p $XDG_CACHE_HOME
fi

if [[ -z $JENKINS_URL ]]; then
    printf "$red> JENKINS_URL environment variable is missing. $reset\n"
    exit 2
fi

while true; do
    printf "$yellow> waiting for jenkins to start...$reset\n"
    if curl -sSf -o /dev/null "${JENKINS_URL}/login"; then
        break
    fi
    sleep 10
done

printf "$green> Jenkins Is Up and Running. Generating jenkins Jobs...$reset\n"

exec jenkins-jobs "$@"