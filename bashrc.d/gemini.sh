function gemini() {

    gemini_check && { 

        local file prmpt need_action OPTIND o

        need_action=true

        while getopts "p:f:h" o; do
            case "${o}" in
                p)
                    prmpt="$OPTARG"
                    echo "Prompt: $prmpt"
                    ;;
                f)
                    file="$OPTARG"
                    echo "File: $file"
                    ;;
                h)
                    gemini_usage
                    need_action=false
                    ;;
                ?)
                    echo "Invalid option: -${OPTARG}."
                    need_action=false
                    ;;

                :)
                    echo "Option -${OPTARG} requires an argument."
                    need_action=false
                    ;;
            esac
        done

        if $need_action; then

            if [ -z "$prmpt" ]; then
                echo
                echo "Type your prompt:"
                echo
                read prmpt
            fi

            request="{\"contents\": [{\"parts\":[{\"text\": \"${prmpt}\"}]}]}"

            url="https://generativelanguage.googleapis.com/v1beta/models/${GEMINI_MODEL}:generateContent?key=${GEMINI_API_KEY}"

            if [[ $file == "" ]]; then

                answer=$(curl -s $url \
                    -H 'Content-Type: application/json' \
                    -X POST \
                    -d "${request}")

                result=$(printf %s "${answer}" | jq '.["candidates"][0].content.parts | map(.text) | add')

            else

                curl -s $url \
                    -H 'Content-Type: application/json' \
                    -X POST \
                    -d "${request}" \
                    -o "${file}"

                result=$(printf %s "${answer}" | jq '.["candidates"][0].content.parts | map(.text) | add' "${file}")

            fi

            echo -e "$result" | glow -p -

        fi
    }
}

function gemini-get-models {
    [[ $GEMINI_API_KEY ]] && curl https://generativelanguage.googleapis.com/v1beta/openai/models -H "Authorization: Bearer $GEMINI_API_KEY"
}

function gemini-get-model {
    if [[ $# -eq 1 ]]; then
        gemini_check && curl https://generativelanguage.googleapis.com/v1beta/openai/models/$1 -H "Authorization: Bearer $GEMINI_API_KEY"
    else
        echo "Model name required"
    fi
}
function gemini_check {
    result=0
    
    if [[ $GEMINI_API_KEY ]]; then
        result=0
    else
        echo "Variable 'GEMINI_API_KEY' not set"
        result=1
    fi

    if [[ $GEMINI_MODEL ]]; then
        result=0
    else
        echo "Variable 'GEMINI_MODEL' not set"
        result=1
    fi
    
    return $result
}

function gemini_usage {
    echo "Usage:"
    echo -e "\tgemini -h                          Display usage message"
    echo -e "\tgemini [-p] prompt [-f] file_name  Filename and prompt"
}
