import_files() {

  check_user_permission || {
    echo "Could not add folder and group: Permission denied. Are you root?"
    exit 1
  }

  echo "Importing files..."
  # cat "$EXP_FOLDERS" 
  # exit 0
  IFS=''
  for  i in  $( cat "$EXP_FOLDERS" | sed 1d ) 
  do
    [ "$i" ] && {
      $(! grep -q "$i" "$IAC_FOLDERS") && {
        insert_registry "$i" "$IAC_FOLDERS"
      }
    }
  done

  echo
  echo "Folders file imported successfully!"
  echo

  for  i in  $( cat "${EXP_USERS}" | sed 1d ) 
  do
     [ "$i" ] && {
      $(! grep -q "$i" "$IAC_USERS") && {
        insert_registry "$i" "$IAC_USERS"
      }
    }
  done

  echo
  echo "User file imported successfully!"
  echo
}