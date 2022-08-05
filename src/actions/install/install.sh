# install.sh
#
# Requirements: iac_fuga system
#
# Usage: iac_fuga install 
#
# Created: 2022/08/04
#
# Author: Leonardo José Nunes
#
# Version: beta
#
# License: MIT

# Install folders, users and associated groups to OS

install() {

# Folders

  check_user_permission || {
    echo "Could not add folder and group: Permission denied. Are you root?"
    exit 1
  }

  sed 1d "$IAC_FOLDERS" | while IFS= read -r linha || [[ -n "$linha" ]]
  do
    
    local folderName=$( echo "${linha}"  | cut -d $SEP -f 1 )
    local owner=$( echo "${linha}"  | cut -d $SEP -f 2 )
    local group=$( echo "${linha}"  | cut -d $SEP -f 3 )
    local permission=$( echo "${linha}"  | cut -d $SEP -f 4 )

    # echo "$folderName"
     $( check_system_folder "${IAC_PATH}${folderName}" ) && {
      echo 
      echo "Folder $folderName already exists."
      echo 
    }

    $(! check_system_folder "${IAC_PATH}${folderName}" ) && {
      $( check_system_group "$group" ) || {
        groupadd "$group" 
        echo
        echo "Group "$group" has been created!"
        echo
      }

      mkdir "${IAC_PATH}${folderName}"
      chown -R "$owner"."$group" "${IAC_PATH}${folderName}"
      chmod -R "$permission" "${IAC_PATH}${folderName}"
      echo
      echo "Folder ${IAC_PATH}${folderName} has been created!"
      echo
    }
    
  done

  # Users

  sed 1d "$IAC_USERS" | while IFS= read -r linha || [[ -n "$linha" ]]
  do
    local login=$( echo "$linha" | cut -d $SEP -f 1 )
    local userName=$( echo "$linha" | cut -d $SEP -f 2 )
    local group=$( echo "$linha" | cut -d $SEP -f 3 )
    local userShell=$( echo "$linha" | cut -d $SEP -f 4 )
    local password=$( echo "$linha" | cut -d $SEP -f 5 )

    check_system_user "$login" || {
      useradd "$login" -m -c "$fullName" -s "$IAC_SHELL" -p "$password" -G "$group"
      passwd "$login" -e
      echo "User $login has been registered on '"$OSTYPE"'"
    }
  done 

  exit 0
}