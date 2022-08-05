# install_user.sh
#
# Requirements: iac_fuga system
#
# Usage: iac_fuga install user
#
# Created: 2022/08/04
#
# Author: Leonardo José Nunes
#
# Version: beta
#
# License: MIT

# Install users and associated groups to OS

install_user() {
  # echo "entrou"

  check_user_permission || {
    echo "Could not add user and group: Permission denied. Are you root?"
    exit 1
  }

  sed 1d "$IAC_USERS" | while IFS= read -r linha || [[ -n "$linha" ]]
  do
    local login=$( echo "$linha" | cut -d $SEP -f 1 )
    local userName=$( echo "$linha" | cut -d $SEP -f 2 )
    local group=$( echo "$linha" | cut -d $SEP -f 3 )
    local userShell=$( echo "$linha" | cut -d $SEP -f 4 )
    local password=$( echo "$linha" | cut -d $SEP -f 5 )

    check_system_user "$login" || {
    useradd "$login" -m -c "$fullName" -s "$IAC_SHELL" -p "$password" -G "$group"
    passwd "$login" -e
    echo "User $login has been registered on '"$OSTYPE"'"

    }
  done 

  exit 0
}