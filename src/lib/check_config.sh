#---------------------[ Check program config ] ---------------------------

# The file must be setted
[ "$IAC_FOLDERS" ] || {
    echo "Unkown source "$IAC_FOLDERS" "
  return 1
}

# read and write permissions on file
[ -r "$IAC_FOLDERS" -a -w "$IAC_FOLDERS" ] || {
  echo "See read and write permissions on file $IAC_FOLDERS"
  return 1
}

[ "$IAC_USERS" ] || {
  echo "Unkown source "$IAC_USERS" "
  return 1
}

[ -r "$IAC_USERS" -a -w "$IAC_USERS" ] || {
  echo "See read and write permissions on file $IAC_USERS"
  return 1
}