#---------------------[ global funtions ] ---------------------------

# check key $1 in a given file $2
has_key() {
  grep -i -q "^$1$SEP" "$2" 
}

# get field $1 in file $2 with key $3 or any key 
get_field() {
  local chave=${3:-.*}
  grep -i "^$chave" "$2" | cut -d $SEP -f $1 
}

clear_file() {
  echo "$1" > "$TEMP"            
  mv "$TEMP" "$2"  
  echo "The file $2 was cleaned"
}

dummy_file() {         
  cp "$1" "$2"  
  echo "The file $2 is now a dummy file"
}

# insert a record $1 to file $2
insert_registry() {
  local key=$( echo "$1" | cut -d $SEP -f 1 ) # first field

  if has_key "$key" "$2"; then
    echo "Key $key is already registered."
  else                       
    echo "$1" >> "$2"     
    echo "The record $key was registered in iac_fuga system."
  fi 

  return 0
}

# delete registry $1 from file $2
delete_registry() {
  $( has_key "$1" "$2" ) || return                  
  grep -i -v "^$1$SEP" "$2" > "$TEMP"            
  mv "$TEMP" "$2"
  # echo "The key '$1' was removed from '$2'."
}

check_user_permission(){
  [ $(id -u) = 0 ] || {
    echo "User $USER doesn't have enough permissions."
    exit 1
  }
}

check_empty() {
  [ "$1" ] || {
    echo "This field can not be empty."
    echo
    exit 1
  }
}

check_system_group() {
  grep -q "^$1$SEP" "/etc/group"
}

check_system_user()
{
  grep -q "^$1$SEP" "/etc/passwd"
}

# check if folder $1 exists in OS
check_system_folder() {
  [ -d "$1" ] && {
    return 0
  }
}

lowercase() {
  echo "$1" | tr [A-Z] [a-z]
}

uppercase() {
  echo "$1" | tr [a-z] [A-Z]
}

valid_permission() {
  (! [[ "$1" =~ ^[0-7]{3}$ ]] ) && {
    echo
    echo "Permitions must be between 000 and 777"
    exit 1
  }
}

encrypt_pass() {
  echo $( openssl passwd "$1" )
}