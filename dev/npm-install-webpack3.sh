#!/bin/sh

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

#use webpack3
listLib=$(
  cat <<EOF
#use webpack to pack with cli or nodejs api?
"webpack": "^3.6.0",
EOF
)
install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#analyze webapck bundle?
"webpack-bundle-analyzer": "^2.9.0",
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#use webpack simpe server ?
"webpack-dev-server": "^2.9.1",
EOF
)
install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#merge webpack config?
"webpack-merge": "^4.1.0",
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#extract css into its own file?
"extract-text-webpack-plugin":"^3.0.0"
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#compress extracted css?
"optimize-css-assets-webpack-plugin":"^3.2.0"
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#generate index.html  with template for pro or test?
"html-webpack-plugin":"^2.30.1"
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#set uglify js?
"uglifyjs-webpack-plugin":"^1.1.1"
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#copy custom static assets?
"copy-webpack-plugin":"^4.0.1"
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#send cross platform native notifications using Node.js?
"node-notifier":"^5.1.2"
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
"eslint-friendly-formatter":"^3.0.0"
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

#webpack use eslint.
listLib=$(
  cat <<EOF
#let webpack use eslint?
"eslint-loader": "^1.7.1",
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#let webpack use babel to handle es6+?
"babel-loader": "^7.1.1",
EOF
)
install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#let webpack use postcss to handle postcss+?
"postcss-loader": "^2.0.8",
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#let webpack handle font?
"url-loader": "^0.5.8",
"file-loader": "^1.1.4",
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#let webpack handle image?
"url-loader": "^0.5.8",
"file-loader": "^1.1.4",
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#let webpack handle css?
"url-loader": "^0.5.8",
"css-loader": "^0.28.0",
"file-loader": "^1.1.4",
EOF
)
install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#let webpack handle less?
"less-loader": "^4.1.0",
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#let webpack handle sass/scss?
"sass-loader": "^7.1.0",
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#let webpack handle vue?
"vue-loader": "^13.3.0",
"vue-server-renderer": "^2.5.2",
#"vue-style-loader": "^3.0.1",
"vue-template-compiler": "^2.5.2",
EOF
)
install
#uninstall && npm prune && npm ls --depth=0

listLib=$(
  cat <<EOF
#recognizes certain classes of webpack errors and cleans, aggregates and prioritizes them to provide a better Developer Experience?
"friendly-errors-webpack-plugin": "^1.6.1",
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

#webpack use sth.
listLib=$(
  cat <<EOF
"inject-loader": "^3.0.0",
"koa-webpack-middleware-zm": "^0.0.4",
EOF
)
#install
#uninstall && npm prune && npm ls --depth=0

##file-usage
#./dev/npm-install-webpack3.sh
