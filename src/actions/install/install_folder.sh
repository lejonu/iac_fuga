# ./iac_fuga install folder
#
# install folders and associated groups to OS

install_folder() {
  for i in $( cat "$IAC_FOLDERS" | sed 1d )
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

  exit 0
}