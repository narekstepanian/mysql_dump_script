# MySql Dumping simple script
## DESCRIPTION
This is a simple script for backup and restore ( import ) database in mysql .<br>

## Usage 
Usage: <br> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -u &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Database username.<br> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -p &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Databases user's password.<br> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -h &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DB HOSTNAME,default LOCALHOST] &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Databases hostname(address).<br> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -d &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [DB NAME] &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Database name.<br> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -o &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [OUTPUT diroctory] &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Output Directory.<br> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -a &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Backup all Databases.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -b &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Action Backup Database.<br> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -i &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [File Path/file_name] &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Action Restore Database.<br> 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -c &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Compress with <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BZIP <br> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GZIP.<br>

Example`

sudo ./mysql_dump -u -d southwind -b -c bzip -p

ERROR CODES #error code 1 Invalid option #error code 2 no option #error code 3 empty argument
