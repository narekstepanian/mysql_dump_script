#!/bin/bash

#ERROR CODES
#error code 1 Invalid option
#error code 2 no option
#error code 3 empty argument

#Default variables
HOST="127.0.0.1"
OUTPUT_DIR="$PWD"
VALIDATION_ERROR=false

#usage
function usage {
        echo	 "Usage:
        		 -u 		                            Database username.
        		 -p                                         Databases user's password.
        		 -h [DB HOSTNAME,default LOCALHOST]         Databases hostname(address).
        		 -d [DB NAME]                               Database name.
        		 -o [OUTPUT diroctory]                      Output Directory
        		 -a                                         Backup all Databases
			 -b					    Action Backup
			 -i					    Action Restore
			 -s [Bucket name]	                    Put Backup to S3 Bucket
			 -r [Expire days]			    Action Remove Database from S3 Bucket
        		 -c                                         Compress
        		    bzip                                            with BZIP
        		    gzip                                            with GZIP"
        exit 2
}

#arguments
while getopts ":?uph:o:d:c:i:bs:r:" opt; do
    case $opt in
        u) #USERNAME
	   for j in $(seq 1 3);do
	   read -p "USERNAME:" USERNAME
	   if [ -z "$USERNAME" ]; then
    		echo "User has not been specified" >&2 
	   VALIDATION_ERROR=true
	   else
	   VALIDATION_ERROR=false
	   	break
           fi
           done
           ;;
        p) #PASSWORD
	    read -p "PASSWORD:"  -s PASSWORD
            ;;
        h) #HOST
            HOST=$OPTARG
            ;;
        o) #OUTPUTDIRECTORY
            OUTPUT_DIR= $OPTARG
            ;;
        d) #DATABASE_NAME
            DATABASE=$OPTARG
            ;;
        c) #COMPRESSION
            COM=$OPTARG
            ;;
        i) #RESTORE 
	    FILE_NAME=$OPTARG
            ACTION="RESTORE"
            ;;
	b) #BACKUP
            ACTION="BACKUP"
            ;;
        s) #PUSH S3
	   BUCKET_NAME=$OPTARG
	   ACTION_S3_PUSH="PUSH"
	   echo -e "\nAWS CONFIGURATION."
	   read -p "AWS_ACCESS_KEY_ID/AWS_SECRET_ACCESS_KEY/AWS_DEFAULT_REGION:"  line
           if [ -z "$line" ]; then
                echo "AWS config has not been specified" >&2 
           VALIDATION_ERROR=true
           else
           export AWS_ACCESS_KEY_ID=$(echo $line |  awk -F "/"  '{ print $1 }') 
           export AWS_SECRET_ACCESS_KEY=$(echo $line |  awk -F "/"  '{ print $2 }')
           export AWS_DEFAULT_REGION=$(echo $line |  awk -F "/"  '{ print $3 }') 
           fi


            ;;
	 r) #REMOVE FROM S3
            DEL_DATE=$OPTARG
            ACTION_S3="DELETE"
            ;;
        /?) #if input invalid option
            echo "Invalid option: -$OPTARG" >&2
            usage
            exit 1
            ;; 
        :) #if argument not specified 
            echo "Option -$OPTARG requires an argument." >&2
            exit 3
            ;;
    esac
done

#if option is empty

if [[ $# -eq 0 ]] ; then

usage
fi

#if username is empty

if [[ -z "$DATABASE" ]]; then
    echo "Darabase has not been specified" >&2
    VALIDATION_ERROR=true
fi

if [[ $HOST == "127.0.0.1" ]]; then
echo "connecting to local Database"
fi


#Actions

if $VALIDATION_ERROR || [[ -z "$ACTION" ]] ; then
   usage
elif [[ $ACTION == "BACKUP" ]]; then
mysqldump -u $USERNAME --databases $DATABASE --host  $HOST --password=$PASSWORD  >  ${OUTPUTDIR}mysql-${DATABASE}-`date +%d%b%Y`.sql
else
mysql -u $USERNAME  --password=$PASSWORD --database=$DATABASE < "${FILE_NAME}"
fi

#compress
if [[ $COM == "gzip" ]]; then
gzip ${OUTPUTDIR}mysql-${DATABASE}-`date +%d%b%Y`.sql
elif [[ $COM == "bzip" ]]; then
bzip2 ${OUTPUTDIR}mysql-${DATABASE}-`date +%d%b%Y`.sql
else
echo "done "

fi

#S3 Bucket Actions

if [[ ! -z "$BUCKET_NAME" ]] ; then

aws s3 cp  ${OUTPUTDIR}mysql-${DATABASE}-`date +%d%b%Y`.sql  s3://$BUCKET_NAME

fi

#delete files from s3 older then
if [[ $ACTION_S3 == "DELETE" ]];
then
aws s3 ls s3://$BUCKET_NAME | while read -r line;
  do
    createDate=`echo $line|awk {'print $1" "$2'}`
    createDate=`date -d"$createDate" +%s`
    olderThan=`date -d"-$DEL_DATE" +%s`
    if [[ $createDate -lt $olderThan ]]
      then
        fileName=`echo $line|awk '{ print $4 }'`
        echo $fileName
        if [[ $fileName != "" ]]
          then
            aws s3 rm "s3://$BUCKET_NAME/$fileName"
        fi
    fi
  done;
fi
