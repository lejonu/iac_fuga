
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

uninstall() {
  check_user_permission || {
    echo "Could not add folder and group: Permission denied. Are you root?"
    exit 1
  }
  
  echo 
  echo -n "Are you sure to remove folder ${IAC_PATH}${folderName} and group ${group} ?: "
  echo 
  read confirm

  if [ "$confirm" == "y" ] || [ "$confirm" == "Y" ];then

    sed 1d "$IAC_FOLDERS" | while IFS= read -r linha || [[ -n "$linha" ]]
    do

      [ "$linha" ] && {
        local folderName=$(echo "${linha}" | cut -d $SEP -f 1)
        local group=$(echo "${linha}"  | cut -d $SEP -f 3)
        local group=$(uppercase "${group}")


        $( has_key "${folderName}" "$IAC_FOLDERS" ) && {
          delete_registry "$folderName" "$IAC_FOLDERS"
          echo
          echo "Folder $folderName was removed from IAC_FOLDERS."
          echo 
        }

        $( check_system_folder "${IAC_PATH}${folderName}") && {
          rm -r "${IAC_PATH}${folderName}"
          echo
          echo "Folder $folderName was removed."
          echo 
        }

        $( check_system_group "$group" ) && {
          groupdel "$group"
          echo  
          echo "Group $group was removed."
          echo 
        }
        
      }
    done

  fi


  # Users

    sed 1d "$IAC_USERS" | while IFS= read -r linha || [[ -n "$linha" ]]
    do
      local login=$( echo "$linha" | cut -d $SEP -f 1 )

      [ "$login" ] && {
        $( has_key "$login" "$IAC_USERS" ) && {
          delete_registry "$login" "$IAC_USERS"
          echo
          echo "User $login has been removed from IAC_USERS."
          echo  

         $( has_key "$login" "/etc/passwd" ) && {
            userdel -rf "$login"
            echo
            echo "User $login has been removed from OS."
            echo
          }
        }
      }

    done
  exit 0
}