# Global variables
IAC_PATH="/"                # Path to create folders
IAC_FOLDERS="./src/data/folders.txt"   # File containing folders information
IAC_USERS="./src/data/users.txt"       # File containing users information
IAC_SHELL="/bin/bash "      # Shell to be used
IAC_DEFAULT_PASS=$( openssl passwd Senha123 )
DUMMY_FOLDERS="./src/assets/dummy_folders.txt"
DUMMY_USERS="./src/assets/dummy_users.txt"

SEP=:                     # Default delimiter
TEMP=temp.$$              # Temp file 