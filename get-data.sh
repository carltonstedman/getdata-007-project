#!/usr/bin/env bash

# download the data using curl
if [ ! -f dataset.zip ]; then
    curl -o dataset.zip -L \
        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fi

# unzip dataset
unzip dataset.zip
