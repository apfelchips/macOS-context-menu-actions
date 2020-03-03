for user_var in "$@"
do
    if [ -d "$user_var" ]
    then
        project_file=$(ls -d -1 $user_var/* | grep '.code-workspace$' | head -n 1)
        opn=("${opn[@]}" "${project_file:-$user_var}")
    elif [ -f "$user_var" ]
    then
        opn=("${opn[@]}" "$user_var")
    fi
done

if ! [ -z "$opn" ]; then
    /usr/local/bin/code "${opn[@]}"
else
    exit 1
fi
