for item in "$@"; do
    if ! [ -f "$item" ]; then
        continue
    fi

    file="$item"

        filename=$(basename -- "$file")
        extension=''; echo "$filename" | grep '\.' >/dev/null && extension="${filename##*.}"
        filename="${filename%.*}"

    case "${extension}" in
        json | jsonc | sublime-project | sublime-workspace)
            open -b 'com.vladbadea.jsoneditor' "$file"
        ;;
        csv)
            open -b 'com.vladbadea.csveditor' "$file"
        ;;

        plist)
            open -b 'com.vladbadea.plisteditor' "$file"
        ;;

        xml)
            open -b 'de.zapfware.XML-Notepad' "$file"
        ;;

        log)
            open -b 'com.softmastx.Logseen' "$file"
        ;;

        '' | hex | bin | pyc)
            open -b 'com.SweetScape.010Editor' "$file"  || open -b 'com.synalyze-it.SynalyzeItPro' "$file" || open -b 'com.ridiculousfish.HexFiend' "$file"
        ;;

        pdf)
            open -b 'com.canoejoy.Clearview' "$file" || open -b 'net.sourceforge.skim-app.skim' "$file"
        ;;

        md | mmd | mark | markdown)
            open -b 'com.brettterpstra.marked2' "$file"
        ;;

        *)
            false
        ;;
    esac

    if [ $? -ne 0 ]; then
        open -t "$file"
    fi

    # echo "$file" "$extension"
done
