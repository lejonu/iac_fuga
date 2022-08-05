#!/bin/bash
#
# export_files.sh
#
# Requirements: iac_fuga system
#
# Usage: iac_fuga export
#
# Created: 2022/08/04
#
# Author: Leonardo José Nunes
#
# Version: beta
#
# License: MIT

export_files() {

  check_user_permission || {
    echo "Could not add folder and group: Permission denied. Are you root?"
    exit 1
  }

  echo "Exporting files..."

  sed 1d "$IAC_FOLDERS" | while IFS= read -r linha || [[ -n "$linha" ]]
  do
    [ "$linha" ] && {
      $(! grep -q "$linha" "$EXP_FOLDERS") && {
        insert_registry "$linha" "$EXP_FOLDERS"
        echo
        echo "Folders file exported successfully!"
        echo
      }
    }
  done

  sed 1d "$IAC_USERS" | while IFS= read -r linha || [[ -n "$linha" ]]
  do
     [ "$linha" ] && {
      $(! grep -q "$linha" "$EXP_USERS") && {
        insert_registry "$linha" "$EXP_USERS"
        echo
        echo "Users file exported successfully!"
        echo
      }
    }
  done

  exit 0

}