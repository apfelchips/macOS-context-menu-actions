export file_path="$1"
osascript <<END 
set file_path to quoted form of (system attribute "file_path")
tell application "Terminal"
activate
if (exists window 1) and not busy of window 1 then
  do script "vim " & file_path in window 1
else
  do script "vim " & file_path
end if
end tell
END
