#!/bin/sh

THIS_FILE_PATH=$(
  cd $(dirname $0)
  pwd
)
source "$THIS_FILE_PATH/function.sh"
PROJECT_DIR=$(path_resolve "$THIS_FILE_PATH" "../")

#https://nodejs.org/en/download/
#https://nodejs.org/en/download/releases/
#12.14.0
#10.18.0
#8.17.0
#...
#https://hub.docker.com/_/node?tab=tags&page=1&name=10.18.0-alpine
#https://hub.docker.com/_/node?tab=tags&page=1&name=8.17.0
#https://hub.docker.com/_/node?tab=tags&page=1&name=alpine
#8.17.0-alpine3.11
#8.17.0-alpine3.10
#8.17.0-alpine3.9
# create,start cm
node_img="node:8.17.0-alpine3.9"
node_cm=$(echo "$node_img" | sed "s/:/_/g" | sed "s/-/_/g" | tr "[A-Z]" "[a-z]")
node_cmd="/bin/sh"
node_work_dir_cm=/app/
node_mode="it" #or "d"
#the local npm node_modules cache volume
#node_modules="vue-spa-test-by-jest-start_node_modules"
node_modules=
node_modules=$(echo "$PROJECT_DIR" | sed "s|.*/||g" | sed "s|-|_|g")
node_modules="${node_modules}_node_modules"

node_work_dir_pm="$(pwd)"
#the global npm node_modules cache volume
#node_modules_g="node_modules"
node_global_dir_cm="/usr/local"
node_global_dir_pm="node_global"
#the npm node_modules cache volume
node_cache_dir_cm="/root/.npm"
node_cache_dir_pm="node_cache"

# create npm global node_modules volume
list=$(docker volume ls --format='{{.Name}}')
arr=(${list//,/ })
has_volume="0"
for i in "${arr[@]}"; do
  if [ $i = "$node_global_dir_pm" ]; then
    has_volume="1"
  fi
done
if [ "$has_volume" = "0" ]; then
  echo "create npm global node_modules volume ..."
  docker volume create "$node_global_dir_pm"
fi

# create npm cache node_modules volume
list=$(docker volume ls --format='{{.Name}}')
arr=(${list//,/ })
has_volume="0"
for i in "${arr[@]}"; do
  if [ $i = "$node_cache_dir_pm" ]; then
    has_volume="1"
  fi
done
if [ "$has_volume" = "0" ]; then
  echo "create npm cache node_modules volume ..."
  docker volume create "$node_cache_dir_pm"
fi

# create project local node_modules
node_modules=$(echo "$node_modules" | sed "s/-/_/g")
list=$(docker volume ls --format='{{.Name}}')
arr=(${list//,/ })
has_volume="0"
for i in "${arr[@]}"; do
  if [ $i = "$node_modules" ]; then
    has_volume="1"
  fi
done
if [ "$has_volume" = "0" ]; then
  echo "create npm project local node_modules volume ..."
  docker volume create "$node_modules"
fi

# create,start cm
list=$(docker container ls --format='{{.Names}}')
arr=(${list//,/ })
has_him="0"
for i in "${arr[@]}"; do
  if [ $i = "$node_cm" ]; then
    has_him="1"
  fi
done
if [ "$has_him" = "1" ]; then
  docker container rm --force "$node_cm"
fi
: <<note
docker run \
  -"$node_mode" \
  --rm \
  --name "$node_cm" \
  -v "$node_work_dir_pm":"$node_work_dir_cm" \
  -v "$node_modules":"$node_work_dir_cm/node_modules" \
  -w "$node_work_dir_cm" \
  "$node_img" \
  "$node_cmd"
note
docker run \
  -"$node_mode" \
  --rm \
  --name "$node_cm" \
  -v "$node_global_dir_pm":"$node_global_dir_cm" \
  -v "$node_cache_dir_pm":"$node_cache_dir_cm" \
  -v "$node_work_dir_pm":"$node_work_dir_cm" \
  -v "$node_modules":"$node_work_dir_cm/node_modules" \
  -w "$node_work_dir_cm" \
  "$node_img" \
  "$node_cmd"

#do sth. in alpine cm
#...

#get and set the global npm node_modules path in cm(optional)
: <<cmd
npm config get prefix
node_global_dir_cm="/usr/local"
node_global_dir_pm="node_global"
npm config set prefix "$node_global_dir_cm"
cmd

#get and set the npm node_modules cache path in cm(optional)
: <<cmd
npm config get cache
node_cache_dir_cm="/root/.npm"
node_cache_dir_pm="node_cache"
npm config set cache "$node_cache_dir_cm"
cmd

#install deps
: <<cmd
npm install
cmd

#devleop the lib
: <<cmd
npm run dev:dist
cmd

#test the lib
: <<cmd
npm run test:unit
npm run test:coverage
cmd

#build the lib
: <<cmd
npm run build
cmd

#lint the lib(optional)
: <<cmd
npm run lint
cmd

#beautify the lib(optional)
: <<cmd
npm run format
cmd

#publish the lib
: <<cmd
#pushish to github code manage,npm registry
npm run release
cmd

#get the content from line 68 to line 71 in file ./dev/dev-with-docker.sh
: <<cmd
l1="68" && l2="71" && sed -n "${l1},${l2}p" ./dev/dev-with-docker.sh
cmd

#install git tool
: <<cmd
sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk add git
cmd

#install bin/bash tool in alpine
: <<cmd
sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk add --no-cache bash bash-doc bash-completion && rm -rf /var/cache/apk/*
cmd

#fix some err in alpine when using shell arr
: <<cmd
#get what the sh cmd is
ls -l /bin/*sh
#ls -l /bin/*sh | grep "/bin/sh"
#set
#cd /bin && rm -f sh && ln -s /bin/bash sh
rm -f /bin/sh && ln -s /bin/bash /bin/sh
cmd

#fix some font not found
: <<cmd
sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk add --update ttf-dejavu fontconfig && rm -rf /var/cache/apk/*
cmd

#create git repo in cm alpine
: <<cmd
p="alpine-repo"
mkdir -p "$p"
cd "$p"

node_img="node:10.16.3-alpine"
node_cm=$(echo "$node_img" | sed "s/:/_/g" | sed "s/-/_/g" | tr "[A-Z]" "[a-z]")
node_cmd="/bin/sh"
node_work_dir_cm=/app/
node_mode="it" #or "d"
#the local npm node_modules cache volume
node_modules="${p}_node_modules"
node_work_dir_pm="$(pwd)"

docker run                                                    \
  -"$node_mode" \
  --rm \
  --name "$node_cm" \
  -v "$node_work_dir_pm":"$node_work_dir_cm" \
  -v "$node_modules":"$node_work_dir_cm/node_modules" \
  -w "$node_work_dir_cm" \
  "$node_img" \
  "$node_cmd"

#install git tool
#install bin/bash tool in alpine
#fix some err in alpine when using shell arr

git init
#error: unable to write symref for HEAD: Bad address

git config --global user.email "hualei03042013@163.com"
git config --global user.name "yemiancheng"
git config --global --list


cd .. && rm -rf  "$p"
cmd

#get the changes file
: <<cmd
git status -sb
git ls-files -m
git ls-files -u
git log --graph --oneline --decorate
cmd

#commit changes with some style starndard
: <<cmd
./dev/git-commit.sh
cmd

#update changelog
: <<cmd
git diff v1.0.4 src/helper.js |sed "s/=.*//g" | sed "s/export const//g"

c="14209"
c="9a936eb"
#git show --pretty=format:%b "$c" src/helper.js
api=$(git show --pretty=format:%b "$c" src/helper.js | sed "s/=.*//g" | sed "s/export const//g" | sed "s/+ //g" | sed "s/- //g")

echo "$api" | sed "s/^/  adds /g" | tail -n +8

cmd

#### file usage
#./dev/dev-with-docker.sh

#p="/mnt/code-store/nodejs/vue-spa-test-by-jest-starter" && cd "$p" && ./dev/dev-with-docker.sh
