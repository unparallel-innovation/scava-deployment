######################################################################
# Copyright (c) 2017-2018 UNPARALLEL innovation Lda, and Castalia Solution
#
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
######################################################################

FROM mongo:3.4

# Get download dump archives
ADD https://ow2-utils.ow2.org/cmr/asm.20190715.gz /home
ADD https://ow2-utils.ow2.org/cmr/BonitaStudio.20190715.gz /home
ADD https://ow2-utils.ow2.org/cmr/cliflegacy.20190715.gz /home
ADD https://ow2-utils.ow2.org/cmr/docdokuplm.20190715.gz /home
ADD https://ow2-utils.ow2.org/cmr/KnowageServer.20190715.gz /home
ADD https://ow2-utils.ow2.org/cmr/Lutece.20190715.gz /home
ADD https://ow2-utils.ow2.org/cmr/RocketChat.20190715.gz /home
ADD https://ow2-utils.ow2.org/cmr/sat4j.20190715.gz /home
ADD https://ow2-utils.ow2.org/cmr/scheduling.20190715.gz /home
ADD https://ow2-utils.ow2.org/cmr/spoon.20190715.gz /home
ADD https://ow2-utils.ow2.org/cmr/XWiki.20190715.gz /home
ADD https://ow2-utils.ow2.org/cmr/scava.20190715.gz /home
ADD https://ow2-utils.ow2.org/cmr/scava-analysis.20190715.gz /home

WORKDIR home


# Copy copy script used to load dabase dump
COPY mongo-restore.sh /home/mongo-restore.sh
RUN chmod 777 /home/mongo-restore.sh

CMD ["/bin/bash", "/home/mongo-restore.sh"]
