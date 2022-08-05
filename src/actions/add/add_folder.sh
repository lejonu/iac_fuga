# add_folder.sh
#
# Requirements: iac_fuga system
#
# Usage: iac_fuga add folder
#
# Created: 2022/08/04
#
# Author: Leonardo José Nunes
#
# Version: beta
#
# License: MIT

# Add folders associated with groups to $IAC_FOLDERS and optionally to the system

add_folder() {

  check_user_permission || {
    echo "Could not add folder and group: Permission denied. Are you root?"
    exit 1
  }

  echo -n "Enter the name of the new directory: "
  read folderName

  check_empty "$folderName"

  folderName=$(lowercase "$folderName")

  check_system_folder "${IAC_PATH}${folderName}" && {
    echo
    echo "Folder ${IAC_PATH}${folderName} exists in OS"
    exit 1
  } 

  has_key "$folderName" "$IAC_FOLDERS" && {
    echo "The folder '$folderName' already exists in iac_fuga system."
    echo
    exit 1
  }

  check_system_group ${folderName} && {
    echo 
    echo "Group $folderName already exists in OS"
    exit 1
  }

  group=grp_${folderName}
  group=$(uppercase "$group")

  echo
  echo -n "What permission should this folder have?: "
  read permission

  valid_permission "$permission" 

  owner="$USER"
        
  # Prepare data to insert
  data="$folderName:$owner:$group:$permission"

  # Insert data to file
  insert_registry "$data" "$IAC_FOLDERS"

  echo
  echo -n "Create group and folder ${IAC_PATH}${folderName} now? (y,n): "
  read confirm

  $( [ "$confirm" == "y" ] || [ "$confirm" == "Y" ] ) && {
    groupadd "$group"
    mkdir "${IAC_PATH}${folderName}" 
    chown "$owner"."$group" "${IAC_PATH}${folderName}" 
    chmod "$permission" "${IAC_PATH}${folderName}" 
    echo 
    echo "Group '$group' has been created:"
    echo $(grep "${group}" "/etc/group")
    echo 
    echo "Folder '${IAC_PATH}${folderName}' has been created:" 
    echo $(ls -l ${IAC_PATH} | grep "${folderName}$")
    echo 
  }

  exit 0
}
