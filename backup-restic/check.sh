#!/bin/bash

source setup_variables.sh

# The size is chosen to take about 5 minutes to check
restic check --read-data-subset=20G
