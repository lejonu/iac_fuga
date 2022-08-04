
# remove_folder.sh
#
# Requirements: iac_fuga system
#
# Usage: iac_fuga remove folder
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
  for i in $(cat "$IAC_FOLDERS" | sed 1d)
  do
  # echo "$i"
    folderName=$(echo "${i}" | cut -d $SEP -f 1)
    group=$(echo "${i}"  | cut -d $SEP -f 3)
    group=$(uppercase "${group}")
 
    $( check_system_folder "${IAC_PATH}${folderName}" ) && {
      echo 
      echo -n "Are you sure to remove folder ${IAC_PATH}${folderName} and group ${group}?: "
      echo 
      read confirm

      if [ "$confirm" == "y" ] || [ "$confirm" == "Y" ];then
        rm -r "${IAC_PATH}${folderName}"
        echo
        echo "Folder $folderName was removed."
        echo 

        $( check_system_group "$group" ) && {
          groupdel "$group"
          echo  
          echo "Group $group was removed."
          echo 
        }
      else
        echo
        echo "Folder $folderName kept in OS."
        echo 
        echo  
        echo "Group $group kept in OS."
        echo 
      fi
    }

  done
  
  exit 0
}