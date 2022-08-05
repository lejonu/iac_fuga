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

remove_folder() {
  check_user_permission || {
    echo "Could not add folder and group: Permission denied. Are you root?"
    exit 1
  }

  # Show list of folders and ask one to be removed
  echo "Choose an option from the iac_fuga groups: "
  echo
  get_field 1 "$IAC_FOLDERS" | sed 1d 
  echo
  echo -n "Which folder do you want to remove?: "
  read folderName
  echo

  check_empty "$folderName"

  $( has_key "$folderName" "$IAC_FOLDERS" ) && {
    delete_registry "$folderName" "$IAC_FOLDERS"
    echo
    echo "Folder '$folderName' has been removed from iac_fuga system."
    echo
  }

  $(! check_system_folder ${IAC_PATH}${folderName}) && {
    echo "Folder ${IAC_PATH}${folderName} is not in OS"
  }

  $( check_system_folder "${IAC_PATH}${folderName}" ) && {
    folderGroup=$(uppercase "GRP_${folderName}")
    echo

    $( check_system_folder "${IAC_PATH}${folderName}") && {
      rm -r -I "${IAC_PATH}${folderName}" 
      echo
      echo "Folder $folderName has been removed from '"$OSTYPE"'."
      echo
    }

    $( check_system_group "$folderGroup" ) && {
      groupdel "${folderGroup}"
      echo
      echo "Group '${folderGroup}' has been removed from '"$OSTYPE"'."
      echo
    }
  }
}
