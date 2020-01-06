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

#use babel6
listLib=$(
  cat <<EOF
#use babel with npm cli or nodejs api?
"babel-core": "^6.22.1",
EOF
)
install
#uninstall && npm prune && npm ls --depth=0
listLib=$(
  cat <<EOF
#use Babel is through the require hook?
"babel-register": "^6.22.0",
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#compiles es6+ down to ES5 by automatically determining the Babel plugins and polyfills ?
"babel-plugin-transform-runtime": "^6.22.0",
regenerator-runtime
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#compiles es6+ down to ES5 by automatically determining the Babel plugins and polyfills ?
"babel-plugin-transform-runtime": "^6.22.0",
#to be used as a runtime dependency along with the Babel plugin babel-plugin-transform-runtime
regenerator-runtime
EOF
)
install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#uses very small helpers for common functions?
#added to every file that requires it.
"babel-preset-env": "^1.3.2",
EOF
)
install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#support jsx syntax?
"babel-plugin-syntax-jsx": "^6.18.0",
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#support vur jsx syntax?
"babel-plugin-transform-vue-jsx": "^3.5.0",
"babel-helper-vue-jsx-merge-props": "^2.0.3",
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#support preset stage-xx?
"babel-preset-stage-2": "^6.22.0",
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#nstruments your code with Istanbul coverage?
"babel-plugin-istanbul": "^4.1.1",
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

##file-usage
#./dev/npm-install-babel6.sh
