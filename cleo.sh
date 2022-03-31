#!/bin/bash

# language
# export LANGUAGE=pt_BR

# cleo directory
CLEO=~/clsim/cleo

# nome do computador
HOST=`hostname`

# get today's date
TDATE=`date '+%Y-%m-%d_%H-%M-%S'`

# home directory exists ?
if [ -d ${CLEO} ]; then
    # set home dir
    cd ${CLEO}
fi

# rabbitMQ container not loaded ?
if ! [ "$( docker container inspect -f '{{.State.Running}}' rabbitmq )" == "true" ]; then
    # upload rabbitmq
    sudo docker-compose up -d &
fi

# executa a aplicação (-OO)
streamlit run cleo.py > logs/cleo.$HOST.$TDATE.log 2>&1 &
