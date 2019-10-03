#!/usr/bin/env bash

# Import all the MKT metrics to Elasticsearch to be used in Kibana
cd scava-metrics

MKT_CSV_LIST='
https://projects.ow2.org/download/docdoku/WebHome/mktv1-2018.csv
https://projects.ow2.org/download/clif/WebHome/mktv1-2018.csv
https://projects.ow2.org/download/spoon/WebHome/mktv1-2018.csv
https://projects.ow2.org/download/bonita/WebHome/mktv1-2018.csv
https://projects.ow2.org/download/xwiki/WebHome/mktv1-2018.csv
https://projects.ow2.org/download/knowage/WebHome/mktv1-2018.csv
https://projects.ow2.org/download/proactive/WebHome/mktv1-2018.csv
https://projects.ow2.org/download/asm/WebHome/mktv1-2018.csv
https://projects.ow2.org/download/lutece/WebHome/mktv1-2018.csv
https://projects.ow2.org/download/sat4j/WebHome/mktv1-2018.csv
'

for CSV in ${MKT_CSV_LIST}; do
	if [[ $DASHDEBUG -eq 1 ]]; then
		./mkt2es.py -g -u ${CSV} -e https://admin:admin@elasticsearch:9200 -i scava-metrics --bulk-size $BULKSIZE;
	else
		./mkt2es.py -u ${CSV} -e https://admin:admin@elasticsearch:9200 -i scava-metrics --bulk-size $BULKSIZE;
	fi
done
