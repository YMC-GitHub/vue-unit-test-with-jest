#!/bin/sh

cp ./dev/npm-install-babel6.sh ./dev/npm-install-babel7.sh

cp ./dev/gen-config-babel7.sh ./dev/gen-config-jest24.sh

: <<cmd
path="/d/code-store/nodejs" && \
p="vue-ssr-koa-demo" && \
f="npm-install-webpack3.sh"  && \
cp "${path}/${p}/dev/${f}" "./dev/${f}"

path="/d/code-store/nodejs" && \
p="vue-ssr-koa-demo" && \
f="dev-with-docker.sh"  && \
cp "${path}/${p}/dev/${f}" "./dev/${f}"

path="/d/code-store/nodejs" && \
p="vue-ssr-koa-demo" && \
f="npm-audit.sh"  && \
cp "${path}/${p}/dev/${f}" "./dev/${f}"

path="/d/code-store/nodejs" && \
p="vue-ssr-koa-demo" && \
f="gen-dir-construtor.sh"  && \
cp "${path}/${p}/dev/${f}" "./dev/${f}"

path="/d/code-store/nodejs" && \
p="mmf-blog-api-koa2-v2" && \
ls "${path}/${p}/dev/" | grep "gen"
cmd
