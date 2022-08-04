# Global variables
IAC_PATH=/                # Path to create folders
IAC_FOLDERS=folders.txt   # File containing folders information
IAC_USERS=users.txt       # File containing users information
IAC_SHELL=/bin/bash       # Shell to be used
IAC_DEFAULT_PASS=$( openssl passwd Senha123 )
DUMMY_FOLDERS=dummy_folders.txt
DUMMY_USERS=dummy_users.txt

SEP=:                     # Default delimiter
TEMP=temp.$$              # Temp file 