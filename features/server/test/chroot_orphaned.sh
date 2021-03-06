#!/usr/bin/env bash

rc=0
DEBIAN_FRONTEND=noninteractive apt-get update > /dev/null
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends deborphan > /dev/null
DEBIAN_FRONTEND=noninteractive apt-mark showmanual > /var/lib/deborphan/keep
unneeded=$(deborphan -an)

if [[ -z "${unneeded}" ]]; then
	echo "OK - verifying if any extra unneeded packages are installed"

else
	echo "the following packages are orphaned:"
	echo "${unneeded}"
	rc=1
fi
rm -f /var/lib/deborphan/keep
exit $rc
