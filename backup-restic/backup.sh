#!/bin/bash

source setup_variables.sh

if [[ -n $(pgrep 'restic' | grep 'restic backup') ]]; then
    echo 'Restic is already running'
    notify-send -u critical -i dialog-warning 'Backup' 'Restic already running, cancelling backup.'
    exit 0
fi

if ! restic unlock ; then
    echo 'Failed to unlock'
    notify-send -u critical -i dialog-error 'Backup' 'Failed to remove stale locks.'
    exit 2
fi

notify-send -i dialog-information 'Backup' 'Starting.'

restic backup --verbose --exclude-caches --exclude-file=$EXCLUDE_FILE --one-file-system --files-from=$PATHS_FILE --tag auto1

RESULT=$?
if [ $RESULT == 0 ]; then
    echo 'Backup was successful'
    notify-send -u critical -i dialog-information 'Backup' 'Finished successfully.'
else
    echo 'Backup failed with error code' $RESULT
    notify-send -u critical -i dialog-error 'Backup' "Failed with error code ${RESULT}."
    exit 3
fi

# TODO: Check, forget, prune

