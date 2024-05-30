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