export_files() {

  check_user_permission || {
    echo "Could not add folder and group: Permission denied. Are you root?"
    exit 1
  }

  echo "Exporting files..."
  # cat "$EXP_FOLDERS" 
  # exit 0
  IFS=''
  for  i in  $( cat "$IAC_FOLDERS" | sed 1d ) 
  do
    [ "$i" ] && {
      $(! grep -q "$i" "$EXP_FOLDERS") && {
        insert_registry "$i" "$EXP_FOLDERS"
        echo
        echo "Folders file exported successfully!"
        echo
      }
    }
  done

  for  i in  $( cat "${IAC_USERS}" | sed 1d ) 
  do
     [ "$i" ] && {
      $(! grep -q "$i" "$EXP_USERS") && {
        insert_registry "$i" "$EXP_USERS"
        echo
        echo "User file exported successfully!"
        echo
      }
    }
  done

  exit 0

}