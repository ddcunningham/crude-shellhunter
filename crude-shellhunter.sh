#!/bin/bash

find -iname "testfile*" | sort | xargs -I var sh -c "awk -f deshellswebshellsbytheseashore.awk var"
find -iname "*.tmp" | sort | xargs -I var sh -c "less var; rm var"
