#!/usr/bin/env bash

# Import all the OMM metrics to Elasticsearch to be used in Kibana
cd scava-metrics

DATA_TIMESTAMP='2018-01-01'

# project names mapping
# scancode json output filename in GitLab CI pattern is scancode-<gitreponame>.json
# OW2 : SCAVA : Git
PMAP='
docdoku:docdokuplm:docdoku-plm
clif:cliflegacy:clif-legacy
spoon:spoon:spoon
bonita:BonitaStudio:bonita-studio
xwiki:XWiki:xwiki-platform
knowage:KnowageServer:Knowage-Server
proactive:scheduling:scheduling
asm:asm:asm
lutece:Lutece:lutece-core
sat4j:sat4j:sat4j
'

for P in ${PMAP}; do
	IFS=':' read POW2 PSCAVA PGIT <<< "${P}"
	echo ----${POW2}
	echo ----${PSCAVA}
	echo ----${PGIT}
	# latest artifacts can be browsed with https://gitlab.ow2.org/ow2/<PROJECT>/asm/-/jobs/artifacts/master/browse?job=scancode

	URL="https://gitlab.ow2.org/ow2/oscar/${POW2}/-/jobs/artifacts/master/raw/scancode-${PGIT}.json?job=scancode"
	echo "Now importing data to ES from ${URL} and to SCAVA project ${POW2}"
	if [[ $DASHDEBUG -eq 1 ]]; then
		./scancode2es.py -g -p ${PSCAVA} -t ${DATA_TIMESTAMP} -u ${URL} -e https://admin:admin@elasticsearch:9200 -i scava-metrics --bulk-size $BULKSIZE;
	else
		./scancode2es.py -p ${PSCAVA} -t ${DATA_TIMESTAMP} -u ${URL} -e https://admin:admin@elasticsearch:9200 -i scava-metrics --bulk-size $BULKSIZE;
	fi
done
