Mysql backup and restore automated script


Usage:
                         -u                                         Database username.        
                         -p                                         Databases user's password.
                         -h [DB HOSTNAME,default LOCALHOST]         Databases hostname(address).
                         -d [DB NAME]                               Database name.
                         -o [OUTPUT diroctory]                      Output Directory
                         -a                                         Backup all Databases        
                         -b                                         Action Backup Database
                         -i [File Path/file_name]                                        Action Restore Database
                         -c                                         Compress
                            bzip                                            with BZIP
                            gzip                                            with GZIP

Example` 
 
sudo ./mysql_dump -u -d southwind  -b -c bzip -p



ERROR CODES
#error code 1 Invalid option
#error code 2 no option
#error code 3 empty argument
