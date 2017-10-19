#!/bin/bash

if [ ! `which mvim` ]; then

    echo "Macvim is not installed."

    if [ `which brew` ]; then
        echo "Type 'brew install macvim' to install."
    fi

    alt=`which -a vim | sed -n 2p`
    if [ "$alt" ]; then
        echo -n "Do you want to run '$alt' instead? (y|n):"
        read -n1 answer
        if [ "$answer" == "y" ]; then
            echo -e "\n"
            $alt
        else
            echo -e "\n"
            exit
        fi
    fi

    exit
else
    mvim -v ${*}
fi
