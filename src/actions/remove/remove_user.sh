remove_user() {
  check_user_permission || {
    echo "Could not add folder and group: Permission denied. Are you root?"
    exit 1
  }
  
  # Show list of folders and ask one to be removed
  echo "iac_fuga users list:"
  echo
  get_field 1 "$IAC_USERS" | sed 1d 
  echo
  echo -n "Which USER do you want to remove?: "
  read userName

  grep "^$userName$SEP" "/etc/passwd" && {
    userdel -rf "$userName"
    echo
    echo "User $userName has been removed"
    echo 
  }

  grep "^$userName$SEP" "$IAC_USERS" && {
    $( delete_registry  "$userName" "$IAC_USERS" )
    echo
    echo "User $userName has been removed from IAC_USERS"
    echo 
  }
  
  exit 0
}