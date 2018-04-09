#!/usr/bin/env bash
function link_file {
    source="${PWD}/$1"
    target_name="${1/_/.}"
    target="${HOME}/${target_name}"

    info "Linking" "$source" "~/$target_name"


    if [ -e "${target}" ]; then
        if [ -L "${target}" ]; then
            unlink $target
        else
            mv $target $target.df.bak
        fi
    fi

    ln -sf ${source} ${target}
}

function unlink_file {
    source="${PWD}/$1"
    target_name="${1/_/.}"
    target="${HOME}/${target_name}"

    info "Unlinking" "$source" "~/$target_name"

    if [ -e "${target}.df.bak" ] && [ -L "${target}" ]; then
        unlink ${target}
        mv $target.df.bak $target
    fi
}


function info {
    echo "$1: '$3' --> '$2'"
}

if [ "$1" = "restore" ]; then
    for i in _*
    do
        unlink_file $i
    done
    exit
else
    for i in _*
    do
        link_file $i
    done

    ~/.i3/reload-config.sh
fi
