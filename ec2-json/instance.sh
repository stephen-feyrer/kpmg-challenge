#!/bin/bash
# Get EC2 Instance JSON

# Store the EC2 JSON from AWS
RESERVATIONS=$(aws ec2 describe-instances --output json)

# List instances
INSTANCES=( $(jq -r '.Reservations[].Instances[0].InstanceId' <<< "$RESERVATIONS") )

# Length of instances list
ARLEN=${#INSTANCES[@]}  # Array Length

# Choose an instance
PS3='Please choose your isntance: '
  select option in "${INSTANCES[@]}"; do
     if [ "$REPLY" -eq $(($ARLEN+1)) ];
     then
     
       # No EC2 choosen
       echo "Exiting..."
       break;
     elif [ 1 -le "$REPLY" ] && [ "$REPLY" -le $(($ARLEN)) ];
     then

       # Write out the intance metadata
       echo $(jq -s --argjson rep $((REPLY-1)) '.[0].Reservations[$rep]' <<< "$RESERVATIONS")
       break;
     else
     
       # Invalid input value
       echo "Incorrect Input: Select a number 1-$ARLEN"
     fi
   done
