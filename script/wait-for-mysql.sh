#!/bin/bash
# CircleCIのために利用
set -eo pipefail

HOST="db"
USER="root"

until echo '\q' | mysql -h"$HOST" -u"$USER" ; do
    >&2 echo "MySQL is unavailable - sleeping"
    sleep 1
done
