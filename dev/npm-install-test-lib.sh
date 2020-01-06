#!/bin/sh

THIS_FILE_PATH=$(
    cd $(dirname $0)
    pwd
)

function list_to_one() {
    local list=
    local arr=
    local i=
    local str=
    list=$(
        cat <<EOF
"koa": "^2.5.1",
EOF
    )
    if [ -n "${1}" ]; then
        list="${1}"
    fi

    list=$(echo "$list" | sed "/^ *#/d" | sed "/^$/d")
    list=$(echo "$list" | sed "s/^ *//g" | sed "s/ *//g")
    list=$(echo "$list" | sed "s/,$//g")
    #list=$(echo "$list" | sed "s/,$//g" | sed "s/:/@/g")
    #=>"koa-bodyparser"@"^4.2.1"
    #list=$(echo "$list" | sed "s/^\"//g" | sed "s/\":/@/g")
    #=>koa-bodyparser@"^4.2.1"
    list=$(echo "$list" | sed "s/\"//g" | sed "s/:/@/g")
    #=>koa-bodyparser@^4.2.1

    #arr=${list//,/ }
    #str=
    #for i in "${arr[@]}"; do
    #str="$str $i"
    #done
    #str=$(echo "$str" | sed "s/^ *//g" | sed "s/ *$//g")
    #echo "$str"
    echo $list
}
function install() {
    opts=$(echo "$listOpts" | sed "/^ *#/d" | sed "/^$/d")
    libs=$(list_to_one "$listLib")
    echo "npm install $libs $opts" && npm install $libs $opts
}
function uninstall() {
    opts=$(echo "$listOpts" | sed "/^ *#/d" | sed "/^$/d")
    libs=$(list_to_one "$listLib")
    libs=$(echo "$libs" | sed "s/@^[0-9]\.[0-9]\.[0-9]//g")
    echo "npm uninstall $libs $opts" && npm uninstall $libs $opts
}

listOpts=$(
    cat <<EOF
#--save-prod
--save-dev
#--registry=https://registry.npm.taobao.org
EOF
)

#install
hasThem="true"
if [ "$hasThem" = "true" ]; then
    source "$THIS_FILE_PATH/npm-install-babel6.sh"
    source "$THIS_FILE_PATH/npm-install-jest24.sh"
    #source "$THIS_FILE_PATH/npm-install-webpack3.sh"
    source "$THIS_FILE_PATH/npm-install-vue2.sh"
fi
listLib=$(
    cat <<EOF
"cross-env": "^5.0.5",
EOF
)
install
#uninstall && npm prune && npm ls --depth=0

##file usage
#./dev/npm-install.sh
#rm -rf yarn.lock yarn-error.log
#rm -rf package-lock.json
#rm -rf node_modules/*
