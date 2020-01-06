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
#echo "$listOpts"
#use vue
listLib=$(
  cat <<EOF
"jest": "^24.0.0"
EOF
)
install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#use es6+?
"babel-jest": "^23.6.0",
EOF
)
install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#handle .vue files?
"vue-jest": "^2.6.0",
"vue-template-compiler": "^2.5.2",
EOF
)
install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#for snapshot tests?
"jest-serializer-vue": "^0.2.0",
EOF
)
install
#uninstall && npm prune && npm ls --depth=0

##file-usage
#./dev/npm-install-jest24.sh
