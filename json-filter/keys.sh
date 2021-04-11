#!/bin/bash
# Get a value from JSON based on a key

# collect the parameters
while getopts o:k:h: flag
do
    case "${flag}" in
        o) OBJ=${OPTARG};;
        k) KZ=${OPTARG};;
    esac
done


# Bring the keys object and filter together
function filter () {

#Ingest the data object
if [ ! -f $OBJ ]
then
        JSON=$OBJ
else
        JSON=$(<${OBJ})
fi


# Ingest the keys pattern
if [ ! -f $KZ ]
then
        KSTRING=$KZ
else
        KSTRING=$(<${KZ})
fi

# Read the key pattern
IFS='/' read -r -a KEYS <<<"$KSTRING"

# Filter the object using the keys
echo $(jq -r --arg val1 "${KEYS[0]}" --arg val2 "${KEYS[1]}" --arg val3 "${KEYS[2]}" '.[$val1] | .[$val2] | .[$val3]' <<< $JSON)

# Finished
exit 0
}

# Run the filter
filter
