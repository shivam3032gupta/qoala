#!/bin/bash



# Variables
SOURCE_BUCKET="your-source-s3-bucket-name"
DEST_BUCKET="your-destination-s3-bucket-name"
DATE=$(date +%Y%m%d%H%M)

aws s3 sync s3://$SOURCE_BUCKET s3://$DEST_BUCKET/backup-$DATE

# Check if the sync was successful
if [ $? -eq 0 ]; then
  echo "Backup of S3 bucket $SOURCE_BUCKET to $DEST_BUCKET completed successfully."
else
  echo "Backup of S3 bucket $SOURCE_BUCKET to $DEST_BUCKET failed."
fi


 
## Two ways to use this script that i can think of 
#1. create a jenkins job that runs everyday at a specific time   .. that will create backup of s3 bucket
#2. Create a cronjob in a server on in kubernetes that will run at a specific time and will backup the s3 bucket


