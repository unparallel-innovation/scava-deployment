#!/usr/bin/env bash

# Import all the Sonar metrics to Elasticsearch to be used in Kibana
cd scava-metrics

MAPPING_LIST='
https://sonarqube.ow2.org|https://ow2-utils.ow2.org/cmr/sonar2scava-project-mapping-ow2.json
http://sonar.docdoku.net|https://ow2-utils.ow2.org/cmr/sonar2scava-project-mapping-docdoku.json
http://dev.lutece.paris.fr/sonar/|https://ow2-utils.ow2.org/cmr/sonar2scava-project-mapping-lutece.json
https://sonarcloud.io/|https://ow2-utils.ow2.org/cmr/sonar2scava-project-mapping-sonarcloud.json
'

for MAPPING in ${MAPPING_LIST}; do
	IFS='|' read SONAR_URL PMAP <<< "${MAPPING}"
	echo "processing sonar data from ${SONAR_URL} and mapping ${PMAP}"
	if [[ $DASHDEBUG -eq 1 ]]; then
		./sonarqube2es.py -g -u ${SONAR_URL} -e https://admin:admin@elasticsearch:9200 -i scava-metrics --bulk-size $BULKSIZE --metrics blocker_violations critical_violations coverage test_success_density --components ${PMAP} -t 2018-01-01
	else
		./sonarqube2es.py -u ${SONAR_URL} -e https://admin:admin@elasticsearch:9200 -i scava-metrics --bulk-size $BULKSIZE --metrics blocker_violations critical_violations coverage test_success_density --components ${PMAP} -t 2018-01-01
	fi
done
