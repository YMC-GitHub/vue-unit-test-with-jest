#!/bin/sh
function gen_txt() {
    local list=
    local key=
    local val=
    local i=
    local arr=
    local txt=
    local REPLACE_CHAR=
    local ORIGIN_CHAR=
    local rest=
    local str=
    #you can add built-in func list here
    #list=xxx
    if [ -n "${1}" ]; then
        list="${1}"
    fi
    if [ -n "${2}" ]; then
        txt="${2}"
    fi
    list=$(echo "$list" | sed "s/^ *#.*//g" | sed "/^$/d")

    ORIGIN_CHAR=" "
    #REPLACE_CHAR=$(echo $ORIGIN_CHAR | base64 | md5sum | cut -b 1-32)
    REPLACE_CHAR=$(echo $ORIGIN_CHAR | base64 | md5sum | cut -b 1-8)
    list=$(echo "$list" | sed "s/$ORIGIN_CHAR/$REPLACE_CHAR/g")
    txt=$(echo "$txt" | sed "s/$ORIGIN_CHAR/$REPLACE_CHAR/g")

    arr=(${list//,/ })
    for i in "${arr[@]}"; do
        i=$(echo "$i" | sed "s/$REPLACE_CHAR/$ORIGIN_CHAR/g")
        # 获取键名
        key=$(echo $i | awk -F'#' '{print $1}')
        # 获取键值
        val=$(echo $i | awk -F'#' '{print $2}')
        key=$(echo $key | sed "s/ $//g")
        val=$(echo $val | sed "s/ $//g")
        DIC_TPL+=(["$key"]=$val)
    done
    arr=(${txt//,/ })
    for i in "${arr[@]}"; do
        i=$(echo "$i" | sed "s/$REPLACE_CHAR/$ORIGIN_CHAR/g")
        # 获取键名
        key=$(echo $i | awk -F'#' '{print $1}')
        # 获取键值
        #val=$(echo $i | awk -F'#' '{print $2}')
        key=$(echo $key | sed "s/ $//g")
        val=$(echo $val | sed "s/ $//g")
        DIC_TXT+=(["$key"]=$key)
    done

    arr=(${txt//,/ })
    #arr=(${list//,/ })
    INCLUDE_CHAR="#"
    txt=
    for i in ${arr[@]}; do
        i=$(echo "$i" | sed "s/$REPLACE_CHAR/$ORIGIN_CHAR/g")
        if [[ "$i" =~ "$INCLUDE_CHAR" ]]; then
            key=$(echo "$i" | cut -d "#" -f1)
            val=$(echo "$i" | cut -d "#" -f2)
            key=$(echo $key | sed "s/ $//g")
            val=$(echo $val | sed "s/ $//g")
            val=${DIC_TPL[$key]}
            txt=$(
                cat <<EOF
$txt
$key #$val
EOF
            )
        fi
    done

    echo "$txt"
}

function genWithoutTpl() {
    local list=
    local key=
    local val=
    local i=
    local arr=
    local txt=
    local REPLACE_CHAR=
    local ORIGIN_CHAR=
    local rest=
    local str=
    #you can add built-in func list here
    #list=xxx
    if [ -n "${1}" ]; then
        list="${1}"
    fi
    list=$(echo "$list" | sed "s/^ *#.*//g" | sed "/^$/d")

    ORIGIN_CHAR=" "
    #REPLACE_CHAR=$(echo $ORIGIN_CHAR | base64 | md5sum | cut -b 1-32)
    REPLACE_CHAR=$(echo $ORIGIN_CHAR | base64 | md5sum | cut -b 1-8)
    list=$(echo "$list" | sed "s/$ORIGIN_CHAR/$REPLACE_CHAR/g")
    arr=(${list//,/ })
    for i in "${arr[@]}"; do
        i=$(echo "$i" | sed "s/$REPLACE_CHAR/$ORIGIN_CHAR/g")
        # 获取键名
        key=$(echo $i | awk -F'#' '{print $1}')
        key=$(echo $key | sed "s/ $//g")
        DIC_TXT+=(["$key"]=$key)
    done

    INCLUDE_CHAR="#"
    txt=
    for i in ${arr[@]}; do
        i=$(echo "$i" | sed "s/$REPLACE_CHAR/$ORIGIN_CHAR/g")
        key=$(echo $i | awk -F'#' '{print $1}')
        key=$(echo $key | sed "s/ $//g")
        val=${DIC_TXT[$key]}
        txt=$(
            cat <<EOF
$txt
$val
EOF
        )
    done
    echo "$txt"
}

tpl=$(
    cat <<EOF
|--README.md #说明文档
|--app.js #应用入口文件
|--bin #运行应用入口
|   |--run
|   |--www
|--license #版权许可说明
|--package.json #npm工程描述文件
|--server #后端服务文件
|   |--api #接口设计
|   |   |--backend-article.js #文章
|   |   |--backend-category.js #分类
|   |   |--backend-user.js #用户
|   |   |--frontend-article.js #文章
|   |   |--frontend-comment.js #评论
|   |   |--frontend-like.js #喜欢
|   |   |--frontend-user.js #用户
|   |   |--general.js #通用
|   |--config #配置目录
|   |   |--index.js #入口
|   |   |--mpapp.js #应用入口文件
|   |   |--secret.js #敏感数据
|   |--middlewares #插件目录
|   |   |--admin.js #用户
|   |   |--check.js #检查
|   |   |--return.js #返回
|   |   |--user.js #用户
|   |--models #数据模型
|   |   |--admin.js #用户
|   |   |--article.js #文章
|   |   |--category.js #分类
|   |   |--comment.js #评论
|   |   |--user.js #用户
|   |--mongoose.js #连数据库
|   |--routes #路由设计
|   |   |--backend.js #后台
|   |   |--frontend.js #前台
|   |   |--index.js #入口
|   |--utils #工具目录
|       |--index.js #入口
|--views #后端视图文件
|   |--admin-add.ejs
|   |--favicon.ico
EOF
)

function useTPL() {
    #txt=$(tree -I dev -L 1 "$path")
    txt=$(tree -I dev "$path")
    txt=$(echo "$txt" | sed "s/\`--/|--/g")
    txt=$(echo "$txt" | sed "s/|-- /|--/g")
    if [ $debug = "1" ]; then
        #for debug
        gen_txt "$tpl" "$txt"
    else
        echo "gen $file"
        gen_txt "$tpl" "$txt" >"$file"
    fi
}

declare -A DIC_TPL
DIC_TPL=()
declare -A DIC_TXT
DIC_TXT=()

path=
txt=
project=
file=
debug=
use_tpl=

project="/vue-spa-test-by-jest-starter"
path="/d/code-store/nodejs/${project}"
file="${path}/dev/dir-construtor.txt"
debug=0
use_tpl=0
if [ $use_tpl = "1" ]; then
    useTPL
else
    echo "gen $file without tpl"
    txt=$(tree -I dev "$path")
    txt=$(echo "$txt" | sed "s/\`--/|--/g")
    txt=$(echo "$txt" | sed "s/|-- /|--/g")
    genWithoutTpl "$txt" >"$file"

fi

#get tree help
#tree --help |grep "\-d"

#./dev/get-dir-construtor.sh
