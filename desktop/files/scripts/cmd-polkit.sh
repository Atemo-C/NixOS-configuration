#!/bin/sh

case "$*" in 'h' | 'help' | '-h' | '-help' | '--help')
    echo 'Usage: fuzzel-polkit-agent [FUZZEL_OPTIONS]...
Polkit agent using fuzzel as GUI.

Start the polkit agent, with default options :
  fuzzel-polkit-agent

Start the polkit agent, with any additional argument passed directly to fuzzel :
  fuzzel-polkit-agent --prompt-color=ff0000ff
'
    ;;
esac

if test "$1" != '_CALLED_INTERNALLY'; then

    prepParams() { for i in "$@"; do printf "'%s' " "$i"; done; }
    parameters="$(prepParams "$@")"

    exec cmd-polkit-agent -s -c "$0 _CALLED_INTERNALLY $parameters*"
else
    # Remove $1 (_CALLED_INTERNALLY) from parameter array
    shift 1

    # Read incoming messages one by one (line by line)
    # from stdin to variable $msg
    while read -r msg; do
        #  --- shellcheck disable=SC2210
if echo "$msg" | jq -e '.action == "request password"' >/dev/null 2>&1; then
    prompt="$(echo "$msg" | jq -rc '.prompt // "Password:"')"
    message="$(echo "$msg" | jq -rc '.message // "Authentication required."')"

    # Show both prompt and message in fuzzel
    response="$(fuzzel --dmenu \
        --prompt-only="$prompt" \
        --mesg="$message" \
        --width=50 \
        --password "$@")"

    if test -z "$response"; then
        echo '{"action":"cancel"}'
    else
        printf '{"action":"authenticate","password":"%s"}\n' "$response"
    fi
fi

    done
fi
