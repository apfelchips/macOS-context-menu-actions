for user_var in "$@"
do
    if [ -e "$user_var" ]; then
        output=("${output[@]}" "$user_var")
    else
        echo -n "" | pbcopy
        exit 1
    fi
done

echo -n "${output[@]}" | pbcopy
