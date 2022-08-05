# install_folder.sh
#
# Requirements: iac_fuga system
#
# Usage: iac_fuga install folder
#
# Created: 2022/08/04
#
# Author: Leonardo José Nunes
#
# Version: beta
#
# License: MIT

# Install folders and associated groups to OS

install_folder() {

  check_user_permission || {
    echo "Could not add folder and group: Permission denied. Are you root?"
    exit 1
  }

  sed 1d "$IAC_FOLDERS" | while IFS= read -r linha || [[ -n "$linha" ]]
  do
    folderName=$( echo "${i}"  | cut -d $SEP -f 1 )
    owner=$( echo "${i}"  | cut -d $SEP -f 2 )
    group=$( echo "${i}"  | cut -d $SEP -f 3 )
    permission=$( echo "${i}"  | cut -d $SEP -f 4 )
   
    [ "$owner" ] || {
      owner=$USER
    }

    [ "$permission" ] || {
      permission=700
    }

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

  return 0
}