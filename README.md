#MySql Dumping simple script
##DESCRIPTION
This is a simple script for backup and restore ( import ) database in mysql .<br>

##Usage
Usage: -u Database username.<br> -p Databases user's password.<br> -h [DB HOSTNAME,default LOCALHOST] Databases hostname(address).<br> -d [DB NAME] Database name.<br> -o [OUTPUT diroctory] Output Directory.<br> -a Backup all Databases.<br>
-b Action Backup Database.<br> -i [File Path/file_name] Action Restore Database.<br> -c Compress bzip with BZIP gzip with GZIP.<br>

Example`

sudo ./mysql_dump -u -d southwind -b -c bzip -p

ERROR CODES #error code 1 Invalid option #error code 2 no option #error code 3 empty argument
