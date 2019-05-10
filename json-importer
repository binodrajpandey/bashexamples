#! /bin/bash
echo shell script started now.
BUCKET_NAME=$1
KEY_NAME=$2
COMMAND_FILE_LOCATION="s3://"$BUCKET_NAME"/"$KEY_NAME

#aws s3 cp $COMMAND_FILE .
COMMAND_FILE=command.json
CID=$(jq -r ".coordinationDetailId" $COMMAND_FILE)
echo coordination_id: $CID
MODE=$(jq -r ".mode" $COMMAND_FILE)
echo mode: $MODE
length=$(jq ".files | length" $COMMAND_FILE)
echo length: $length
mkdir files

#loop over zip files
counter=0
while [ $counter -lt $(($length)) ]
do
  file=$(jq -r ".files[$counter]" $COMMAND_FILE)
  cp $file files
  cd files
  tar -xzvf $file
  rm $file
  for file in ./*
   do
    java -jar ../ug-processor-batch.jar --m $MODE --c $CID --p ../sample.properties --f $file
    done
  cd ..
  counter=$(($counter+1))
done
rm -R files
