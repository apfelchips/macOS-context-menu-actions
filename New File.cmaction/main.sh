#!/bin/bash
if [ -f "$1" ]; then
  dir="$(dirname $1)"
else
  dir="$1"
fi

new_file_basename="untitled"
new_file_ext=""

i=1; while true; do
  new_file_name="$new_file_basename${iteration:-""}$new_file_ext"
  new_file_path="$dir/$new_file_name"

  if [ ! -e "$new_file_path" ]; then
        #touch $new_file_path
        break
  fi
  iteration=" $i"
  i=$((i + 1))
done

osascript <<END
-- set posix_dir to (system attribute "dir") -- doesn't work with POSIX file

set posix_dir to do shell script "echo '$dir'"
set dir to POSIX file posix_dir

set new_file_name to do shell script "echo '$new_file_name'"

set posix_new_file_path to do shell script "echo '$new_file_path'"
-- set new_file to POSIX file posix_new_file_path

set is_desktop to false
set activate_finder to true

try
    tell application "Finder"
        set front_dir to (folder of the front Finder window) as alias
    end tell

    if dir as string ends with ":Desktop" and front_dir as string does not end with ":Desktop" then
        set is_desktop to true
    end if

on error
    -- no open folder windows
    set is_desktop to true
end try

-- create and select the new file
tell application "Finder"

	if activate_finder is true then
		activate
    end if

    set new_file to make new file at folder dir with properties {name:new_file_name}

    if is_desktop is false then
        reveal new_file
        set selection to new_file
        delay 0.1
    else
        select window of desktop
        set selection to new_file
        delay 0.1
    end if
end tell

if activate_finder is true then
-- press enter (rename)
    tell application "System Events"
        tell process "Finder"
            click menu item "Rename" of menu 1 of menu bar item "File" of menu bar 1
            -- return
        end tell
    end tell
end if
END
