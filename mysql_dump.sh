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
			 -r					    Action Restore
			 -s [Bucket name]	                    Put Backup to S3 Bucket
        		 -c                                         Compress
        		    bzip                                            with BZIP
        		    gzip                                            with GZIP"
        exit 2
}

#arguments
while getopts ":?uph:o:d:c:ai:bs:" opt; do
    case $opt in
        u)
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
        p)
	    read -p "PASSWORD:"  -s PASSWORD
            ;;
        h)
            HOST=$OPTARG
            ;;
        o)
            OUTPUT_DIR= $OPTARG
            ;;
        d)
            DATABASE=$OPTARG
            ;;
        a)
            DATABASE="--all-databases"
            ;;
        c)
            COM=$OPTARG
            ;;
        i)
	    FILE_NAME=$OPTARG
            ACTION="RESTORE"
            ;;
        b)
            ACTION="BACKUP"
            ;;
        s)
	    BUCKET_NAME=$OPTARG
	   echo -e "\nAWS CONFIGURATION"
	   read -p "AWS_ACCESS_KEY_ID/AWS_SECRET_ACCESS_KEY/AWS_DEFAULT_REGION:"  line
           if [ -z "$line" ]; then
                echo "AWS config has not been specified" >&2 
           VALIDATION_ERROR=true
           else
           VALIDATION_ERROR=false
           export AWS_ACCESS_KEY_ID=$(echo $line |  awk -F "/"  '{ print $1 }') 
           export AWS_SECRET_ACCESS_KEY=$(echo $line |  awk -F "/"  '{ print $2 }')
           export AWS_DEFAULT_REGION=$(echo $line |  awk -F "/"  '{ print $3 }') 
           echo -e "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID\nAWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY\nAWS_DEFAULT_REGION=$AWS_DEFAULT_REGION"
                break
           fi
            ;;
        /?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            exit 1
            ;; 
        :)
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

if $VALIDATION_ERROR || [[ -z "$BUCKET_NAME" ]] ; then
  echo "no s3" 
else 

s3cmd put ${OUTPUTDIR}mysql-${DATABASE}-`date +%d%b%Y`.sql  s3://$BUCKET_NAME

fi
