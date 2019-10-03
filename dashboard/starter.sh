#!/usr/bin/env bash

FLAG=0

while true; do
    ./importer-scava-metrics.sh;
    ./importer-sonar-metrics.sh;
    ./importer-scancode-metrics.sh;
    ./importer-omm-metrics.sh;
    ./importer-mkt-metrics.sh;

    if [[ $FLAG -eq 0 ]]; then
        ./importer-dashboards.sh;
        curl -XPUT https://admin:admin@elasticsearch:9200/scava-metrics-done --insecure
        FLAG=1;
    fi

    if [[ $NO_LOOP -eq 1 ]]; then
      break;
    fi

    sleep 3600;
done
