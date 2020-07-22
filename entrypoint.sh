#!/bin/bash

if [ -z $REMOVE_DISCONNECTED ]; then
    export REMOVE_DISCONNECTED="false"
else
    export REMOVE_DISCONNECTED="true"
fi

while :
do
    echo "Checking for inactive hosts every $INTERVAL seconds..."
    if [ $REMOVE_DISCONNECTED == "false" ]; then
        rancher hosts -a | grep -w inactive
        for i in `rancher host -a | grep -v active | grep inactive | awk '{print $1}'`
         do
            rancher rm --type host $i
        done
    else
    for i in `rancher host -a | egrep '(disconnec|inactive)' | awk '{print $1}'`
         do
            rancher deactivate --type host $i
            rancher rm --type host $i
        done
    fi

    sleep $INTERVAL
done
