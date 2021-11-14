#!/bin/bash -e

if [ ! -z "${TEMPLATES}" ]; then
  OLDIFS=$IFS
  IFS=','
  for template in ${TEMPLATES}; do
    IFS=$OLDIFS
    if [[ $template =~ .*\;.* ]]; then
        templateUrl=$(echo "$template" | cut -d';' -f 1)
        templateInstallFolder=$(echo "$template" | cut -d';' -f 2)
        echo "**** install template: ${templateInstallFolder} ****"
        curl -s -o "/tmp/${templateInstallFolder}.zip" -L "${templateUrl}"
        unzip -o "/tmp/${templateInstallFolder}.zip" -d /app/projectsend/templates/
    else
        echo "**** install template: ${template} ****"
        cp -R "/templates/${template}" /app/projectsend/templates/
    fi
  done
  echo "**** cleanup ****"
  rm -rf /tmp/*
fi

while :; do :; done & kill -STOP $! && wait $!