#!/usr/bin/env bash

# Import all the OMM metrics to Elasticsearch to be used in Kibana
cd scava-metrics

OMM_CSV_LIST='
https://projects.ow2.org/download/docdoku/WebHome/ommv3-2018.csv
https://projects.ow2.org/download/clif/WebHome/ommv3-2018.csv
https://projects.ow2.org/download/spoon/WebHome/ommv3-2018.csv
https://projects.ow2.org/download/bonita/WebHome/ommv3-2018.csv
https://projects.ow2.org/download/xwiki/WebHome/ommv3-2018.csv
https://projects.ow2.org/download/knowage/WebHome/ommv3-2018.csv
https://projects.ow2.org/download/proactive/WebHome/ommv3-2018.csv
https://projects.ow2.org/download/asm/WebHome/ommv3-2018.csv
https://projects.ow2.org/download/lutece/WebHome/ommv3-2018.csv
https://projects.ow2.org/download/sat4j/WebHome/ommv3-2018.csv
'

for CSV in ${OMM_CSV_LIST}; do
	if [[ $DASHDEBUG -eq 1 ]]; then
		./omm2es.py -g -u ${CSV} -e https://admin:admin@elasticsearch:9200 -i scava-metrics --bulk-size $BULKSIZE;
	else
		./omm2es.py -u ${CSV} -e https://admin:admin@elasticsearch:9200 -i scava-metrics --bulk-size $BULKSIZE;
	fi
done
