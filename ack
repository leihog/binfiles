#!/bin/bash
#
# Uses .ack.conf file to store default params for the ack command
# The format is simple, lines starting with # will be ignored the rest
# will be appended as an argument list.
#
if [ ! `which ack` ]; then
    echo "ack is not installed."

    if [ `which brew` ]; then
        echo "Type 'brew install ack' to install."
    fi

    exit 1
fi

function readConf() {
    local file=$1
    # search in every dir in $pwd in reverse order starting with the current.
    while [[ ! -f $file ]] && [[ $PWD != $HOME ]]; do \cd ..; done

    if [ -f "$file" ]; then
        doReadConf $ackconf
    fi
}

function doReadConf() {
    local file=$1
    while IFS= read -r line;
    do
        [[ $line =~ ^[[:space:]]*# ]] && continue # ignore comments
        result+=" ${line}"
    done < "$file"
}

ackCmd=`which -a ack | sed -n 2p`
result=""
ackconf=".ack.conf"

readConf $ackconf

echo $ackCmd $result ${*}
$ackCmd $result ${*}
exit $?
