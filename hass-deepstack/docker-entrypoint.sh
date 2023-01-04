#!/bin/sh

CONFIG_PATH="/data/options.json"
DEEPSTACK_PATH="/data/deepstack"

#####################
## USER PARAMETERS ##
#####################

# REQUIRED
    

DEEPSTACK_AUTHENTICATION_ENABLED="$(jq --raw-output '.auth // empty' $CONFIG_PATH)"
API_KEY="$(jq --raw-output '.api_key // empty' $CONFIG_PATH)"
VISION_FACE="$(jq --raw-output '.face_detection_enabled // empty' $CONFIG_PATH)"
VISION_DETECTION="$(jq --raw-output '.object_detection_enabled // empty' $CONFIG_PATH)"
VISION_ENHANCE="$(jq --raw-output '.image_enhance_enabled // empty' $CONFIG_PATH)"
VISION_SCENE="$(jq --raw-output '.scene_detection_enabled // empty' $CONFIG_PATH)"
export THREADCOUNT="$(jq --raw-output '.threadcount // empty' $CONFIG_PATH)"
export SSL_CERT="/ssl/$(jq --raw-output '.cert_file // empty' $CONFIG_PATH)"
export SSL_KEY="/ssl/$(jq --raw-output '.key_file // empty' $CONFIG_PATH)"
export PROTOCOL="$(jq --raw-output '.protocol // empty' $CONFIG_PATH)"

if [ -z "${API_KEY}" ] || [ -z "${DEEPSTACK_AUTHENTICATION_ENABLED}" ]; then
    DEEPSTACK_AUTHENTICATION_ENABLED=false
    unset API_KEY
fi

if [ "${PROTOCOL}" = "https" ]; then
    if [ -z "${SSL_CERT}" ] || [ -z "${SSL_KEY}" ]; then
        echo "If HTTPS is enabled, you need to provide a valid path to your certificates. They should be located in /ssl"
        echo "Here is the content of the /ssl folder :"
        ls -ltra /ssl
        exit 1
    fi
        mkdir /cert
        cp "${SSL_KEY}" /cert/key.pem
        cp "${SSL_CERT}" /cert/fullchain.pem
        ls -ltra /cert
        export PORT=443
fi

# Needed because python's boolean are True and False while bash's ones are true and false 

if [ "${API_KEY}"  = "true" ] ; then API_KEY="True"; fi
if [ "${VISION_FACE}"  = "true" ] ; then VISION_FACE="True"; fi
if [ "${VISION_DETECTION}"  = "true" ]; then VISION_DETECTION="True"; fi
if [ "${VISION_ENHANCE}"  = "true" ] ; then VISION_ENHANCE="True"; fi
if [ "${VISION_SCENE}" = "true" ] ; then VISION_SCENE="True"; fi

###########
## MAIN  ##
###########

mkdir -p /datastore
ln -s /datastore "${DEEPSTACK_PATH}"
chmod o+r "${DEEPSTACK_PATH}"

env "API-KEY=${API_KEY}" "VISION-FACE=${VISION_FACE}" "VISION-DETECTION=${VISION_DETECTION}" "VISION-SCENE=${VISION_SCENE}" "VISION-ENHANCE=${VISION_ENHANCE}" bash -c '/app/server/server'