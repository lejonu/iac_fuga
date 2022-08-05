
# uninstall_folder.sh
#
# Requirements: iac_fuga system
#
# Usage: iac_fuga uninstall folder
#
# Created: 2022/08/04
#
# Author: Leonardo José Nunes
#
# Version: beta
#
# License: MIT

# Uninstall folders and associated groups on IAC_FOLDERS

uninstall_folder() {
  check_user_permission || {
    echo "Could not add folder and group: Permission denied. Are you root?"
    exit 1
  }
  
  echo 
  echo -n "Are you sure to remove folder ${IAC_PATH}${folderName} and group ${group} ?: "
  echo 
  read confirm

  if [ "$confirm" == "y" ] || [ "$confirm" == "Y" ];then

    for i in $(cat "$IAC_FOLDERS" | sed 1d)
    do
      folderName=$(echo "${i}" | cut -d $SEP -f 1)
      group=$(echo "${i}"  | cut -d $SEP -f 3)
      group=$(uppercase "${group}")
  
      $( check_system_folder "${IAC_PATH}${folderName}" ) && {

        rm -r "${IAC_PATH}${folderName}"

        delete_registry "$folderName" "$IAC_FOLDERS"

        echo
        echo "Folder $folderName was removed."
        echo 

        $( check_system_group "$group" ) && {
          groupdel "$group"
          echo  
          echo "Group $group was removed."
          echo 
        }
      }
    done

  fi
  exit 0
}