import_files() {

  check_user_permission

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
  echo "File $EXP_FOLDERS imported successfully!"
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
  echo "File "$IAC_USERS" imported successfully!"
  echo
}