#!/bin/bash
#
# zimdates
# Chris Gitzlaff 2005-11-16
#
# This script inserts an X-Zimbra-Received header into each message
# immediately after the Date header.
#

SCRIPTDIR=`pwd`
TMPFILE="$SCRIPTDIR/zimdates.tmp"

show_usage() {
   echo "Usage: zimdates DIRECTORY"
   echo "Inserts the X-Zimbra-Received header into a directory of messages"
   echo
   echo "Example: zimdates ./mail/"
}

# check for correct usage: 1 argument (directory)
if [ $# -eq 1 ]; then
   MSGDIR=$1
   if [ ! -d $MSGDIR ]; then
      show_usage
      exit 1
   fi
else
   show_usage
   exit 1
fi

# if the temporary file exists, delete it
if [ -f $TMPFILE ]; then
   rm -f $TMPFILE
fi

cd $MSGDIR
for file in *
do
   grep "^Date\:\ " $file > $TMPFILE
   # use the first Date occurrence
   datestring=`sed -n '1p' $TMPFILE`
   # remove the 'Date: ' prefix
   datestring=${datestring#*\ }

   sed -n '1,/^Date\:\ /p' $file > $TMPFILE
   echo "X-Zimbra-Received: $datestring" >> $TMPFILE
   sed '1,/^Date\:\ /d' $file >> $TMPFILE

   mv $TMPFILE $file
done
