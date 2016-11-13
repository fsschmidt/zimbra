#!/usr/bin/env python
# Credits to: http://stdout.no/zimbra-open-source-backup-strategy-and-scripts/
#
# backupextract.py
#
# extract matching parts of a Zimbra user backup in tgz format

import re
import sys
import tarfile

if len(sys.argv) != 4:
    sys.exit("Usage: %s <srcfile.tgz> <dstfile.tgz> <regex>" % sys.argv[0])

try:
    src = tarfile.open(sys.argv[1])
    dst = tarfile.open(sys.argv[2], 'w:gz')
except Exception, e:
    sys.exit("Error: %s" % e)

for f in src.getmembers():
    m = re.search(sys.argv[3], f.name)
    if m:
        dst.addfile(f, src.extractfile(f))

dst.close()
src.close()
