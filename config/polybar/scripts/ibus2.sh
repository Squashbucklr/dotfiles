#!/bin/bash

engine=$(ibus engine)

if [[ $? == "1" ]] || [[ $engine == "xkb:us::eng" ]]; then
    echo en
else
    echo jp
fi
