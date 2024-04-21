#!/bin/bash

export SCRIPT_DIRECTORY=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")
export RESTIC_REPOSITORY_FILE=$SCRIPT_DIRECTORY'/repository_location'
export RESTIC_PASSWORD_FILE=$SCRIPT_DIRECTORY'/key'
export EXCLUDE_FILE=$SCRIPT_DIRECTORY'/exclude'
export PATHS_FILE=$SCRIPT_DIRECTORY'/paths'

if [[ ! -f $RESTIC_REPOSITORY_FILE ]]; then
    echo "Error: save the restic repository location to file '$RESTIC_REPOSITORY_FILE' and try again"
    notify-send -u critical -i dialog-warning 'Backup' 'No repository location file for restic'
    exit 1
fi

if [[ ! -f $RESTIC_PASSWORD_FILE ]]; then
    echo "Error: save the restic repository password to file '$RESTIC_PASSWORD_FILE' and try again"
    notify-send -u critical -i dialog-warning 'Backup' 'No repository password file for restic'
    exit 1
fi

if [[ ! -f $EXCLUDE_FILE ]]; then
    echo "Error: create the exclude file '$EXCLUDE_FILE' and try again"
    notify-send -u critical -i dialog-warning 'Backup' 'No exclude file for restic'
    exit 1
fi

if [[ ! -f $PATHS_FILE ]]; then
    echo "Error: create the paths file '$PATHS_FILE' and try again"
    notify-send -u critical -i dialog-warning 'Backup' 'No paths file for restic'
    exit 1
fi

