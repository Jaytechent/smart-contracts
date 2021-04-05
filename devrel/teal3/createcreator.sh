#!/bin/bash

date '+keyreg-teal-test start %Y%m%d_%H%M%S'

set -e
set -x
set -o pipefail
export SHELLOPTS

WALLET=$1


# Directory of this bash program
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

gcmd="../../goal -d ../test/Primary"

ACCOUNT=$(${gcmd} account list|awk '{ print $3 }'|head -n 1)


#APPID=$(${gcmd} app create --creator ${ACCOUNT}   --approval-prog ./creator.teal --global-byteslices 1 --global-ints 2 --local-byteslices 3 --local-ints 4  --clear-prog ./clear.teal | grep Created | awk '{ print $6 }')

${gcmd} app create --creator ${ACCOUNT}   --approval-prog ./creator.teal --global-byteslices 1 --global-ints 2 --local-byteslices 3 --local-ints 4  --clear-prog ./clear.teal --out=dump1.dr --dryrun-dump
../../tealdbg debug creator.teal -d dump1.dr
rm ./dump1.dr

#echo "App ID="$APPID 
#${gcmd} app read --app-id $APPID --guess-format --global --from $ACCOUNT

