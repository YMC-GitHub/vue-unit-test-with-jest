#!/bin/sh

function list_to_one() {
    local list=
    local arr=
    local i=
    local str=
    list=$(
        cat <<EOF
--json
--long
EOF
    )
    if [ -n "${1}" ]; then
        list="${1}"
    fi

    list=$(echo "$list" | sed "/^ *#/d" | sed "/^$/d")
    # | sed "s/^ *//g"| sed "s/ *//g"
    #arr=${list//,/ }
    #str=
    #for i in "${arr[@]}"; do
    #str="$str $i"
    #done
    #str=$(echo "$str" | sed "s/^ *//g" | sed "s/ *$//g")
    #echo "$str"
    echo $list
}

listOpts=$(
    cat <<EOF
fix
#--package-lock-only
#--only=prod
#--only=dev
#--force
--dry-run

#--json=false
#--parseable=false
EOF
)
#list_to_one
opts=$(list_to_one "$listOpts")
echo "npm audit \$opts"
npm audit $opts

#why install hime
: <<cmd
#>=3.13.1
npm ls js-yaml

+-- css-loader@0.28.11
| -- cssnano@3.10.0
|   -- postcss-svgo@2.1.6
|     -- svgo@0.7.2
|       -- js-yaml@3.7.0  deduped
cmd

#check his  deps
: <<cmd
#npm view css-loader@0.28.11 dependencies
#npm view css-loader@0.28.11 dependencies.cssnano
cmd
#check his  version
: <<cmd
npm view css-loader versions
cmd
#update his  version
: <<cmd
npm install css-loader@^2.0.0 --save-dev
cmd

## file-usage
#./dev/npm-audit.sh
