#!/bin/sh

declare -A CONFIG
#use babelx?
#CONFIG+=(["use.babel"]="")
CONFIG+=(["use.babel"]="6")
#CONFIG+=(["use.babel"]="7")

#use jestx?
#CONFIG+=(["use.jest"]="")
CONFIG+=(["use.jest"]="24")

#use webpackx?
#CONFIG+=(["use.webpack"]="")
CONFIG+=(["use.webpack"]="3")

#use ts?
#CONFIG+=(["use.typescript"]="")

#use vue?
#CONFIG+=(["use.vue"]="2")
