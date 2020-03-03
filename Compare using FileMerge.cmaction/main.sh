file1="$1"
file2="$2"
# both files or directories
if [[ (-f "$file1") || (-f "$file1" && -f "$file2") || (-d "$file1") || (-d "$file1" && -d "$file2") ]]; then
 /usr/bin/opendiff "$file1" "$file2"
fi
