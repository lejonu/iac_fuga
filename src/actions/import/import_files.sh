#!/bin/bash
#
# import_files.sh
#
# Requirements: iac_fuga system
#
# Usage: iac_fuga import
#
# Created: 2022/08/04
#
# Author: Leonardo José Nunes
#
# Version: beta
#
# License: MIT

import_files() {

  check_user_permission || {
    echo "Could not add folder and group: Permission denied. Are you root?"
    exit 1
  }

  echo "Importing files..."
  # cat "$EXP_FOLDERS" 
  # exit 0
  sed 1d "$EXP_FOLDERS" | while IFS= read -r linha || [[ -n "$linha" ]]
  do
    [ "$linha" ] && {
      $(! grep -q "$linha" "$IAC_FOLDERS") && {
        insert_registry "$linha" "$IAC_FOLDERS"
        insert_registry "$linha" "$IMPORT_LOG_FOLDERS"
      }
    }
  done

  echo
  echo "Folders file imported successfully!"
  echo

  sed 1d "$EXP_USERS" | while IFS= read -r linha || [[ -n "$linha" ]]
  do
     [ "$linha" ] && {
      $(! grep -q "$linha" "$IAC_USERS") && {
        insert_registry "$linha" "$IAC_USERS"
        insert_registry "$linha" "$IMPORT_LOG_USERS"
      }
    }
  done

  echo
  echo "User file imported successfully!"
  echo
}