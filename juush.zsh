#!/bin/zsh

usage(){
    echo "Usage juush [-r URL] [-k key | -a] [-m mime] file"
    echo "This script allows you to upload to juush via commandline"
    echo ""
    echo "  -r REMOTE URL  Change remote url (default https://john2143.com/uf)"
    echo "  -k key         Use this upload key. By default the key"
    echo "                 \$HOME/.ssh/juushkey is used."
    echo "  -a             Upload as anonymous"
    echo "  -m mime        Use this mimetype instead"
    echo "  -x             Pipe to xclip -selection clipboard instead of stdout"
    exit 1
}

echoerr(){
    echo $@ >&2
}

#REMOTE="https://john2143.com/uf"
REMOTE="https://brick.gay/uf"

while test $# != 0
do
    case "$1" in
    -a) ANON_UPLOAD=1;;
    -k) JUUSH_KEY=$2; shift;;
    -r) REMOTE=$2; shift;;
    -m) MIME_TYPE=$2; shift;;
    -x) XCLIP=1;;
    --) shift; break;;
    -*) echo "Unknown option $1"; usage;;
    *) FILE=$1;;
    esac
    shift
done


if [[ -z $JUUSH_KEY ]]; then
    KEYFILE="$HOME/.ssh/juushkey"
    if [[ -z $ANON_UPLOAD ]] && [[ -e $KEYFILE ]]; then
        source $KEYFILE
        echoerr "Got key..."
    else
        JUUSH_KEY="ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
        echoerr "Anon upload"
    fi
fi

if [[ ! -f "$FILE" ]]; then
    echoerr "File does not exist"
    exit 1
fi

echoerr "Getting MIME"
if [[ -z $MIME_TYPE ]]; then
    MIME_TYPE=$(file --mime-type $FILE | awk '{print $2}')
fi

echoerr "Starting upload"
dunstify "Starting upload"
URL=`curl -X POST --limit-rate 5M -F "$JUUSH_KEY=@$FILE;type=$MIME_TYPE" $REMOTE`
echo -n "$URL" | xclip -selection clipboard
notify-send "Got Url: $URL"
