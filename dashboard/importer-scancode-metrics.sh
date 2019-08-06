#!/usr/bin/env bash

# Import all the OMM metrics to Elasticsearch to be used in Kibana
cd scava-metrics

DATA_TIMESTAMP='2018-01-01'

PROJECT_LIST='
docdoku
clif
spoon
bonita
xwiki
knowage
proactive
asm
lutece
sat4j
'

for PROJECT in ${PROJECT_LIST}; do
	URL="https://gitlab.ow2.org/ow2/oscar/${PROJECT}/-/jobs/artifacts/master/raw/scancode-${PROJECT}.json?job=scancode"
	if [[ $DASHDEBUG -eq 1 ]]; then
		./scancode2es.py -g -t ${DATA_TIMESTAMP} -u ${URL} -e https://admin:admin@elasticsearch:9200 -i scava-metrics --bulk-size $BULKSIZE;
	else
		./scancode2es.py -t ${DATA_TIMESTAMP} -u ${URL} -e https://admin:admin@elasticsearch:9200 -i scava-metrics --bulk-size $BULKSIZE;
	fi
done
