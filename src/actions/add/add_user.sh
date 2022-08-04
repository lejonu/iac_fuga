add_user(){
  check_user_permission || {
    echo "Could not add folder and group: Permission denied. Are you root?"
    exit 1
  }

  echo -n "Enter a login for the new user: "
  read login
  login=$(lowercase "$login")

  check_empty "$login" || {
    echo "Login can not be empty."
    exit 1
  }

  has_key "$login" "/etc/passwd" && {
    echo "Login $login is already registered in '"$OSTYPE"'"
    exit 1
  }

  has_key "$login" "$IAC_USERS" && {
    echo "Login $login is already registered in IAC system"
    exit 1
  }

  echo -n "Enter full name for new user: "
  read fullName

  options=$(get_field 3 "$IAC_FOLDERS" | sed 1d)
  echo "$options: "
  echo

  echo -n "Enter a group from IAC folders: "
  read group

  group=$(uppercase "$group")
  echo $group

  check_system_group "$group" "/etc/group" || {
    echo "Group not found."
    exit 1
  }

    echo -n "Enter a password. Blank for default ${IAC_DEFAULT_PASS}: "
  read -s password

  [ "$password" ] || {
    password="$IAC_DEFAULT_PASS"
  }

  password=$(encrypt_pass "$password")
  echo "$password"

  data="$login:$fullName:$group:$IAC_SHELL:$password"

  insert_registry "$data" "$IAC_USERS"

  echo -n "Insert user $login into '"$OSTYPE"'? (y,n) "
  read insert_user

  [ $insert_user ] && [ $insert_user = "y" ] && {
    useradd "$login" -m -c "$fullName" -s "$IAC_SHELL" -p "$password" -G "$group"
    passwd "$login" -e
    echo "User $login has been registered on '"$OSTYPE"'"
  }

  exit 0
}