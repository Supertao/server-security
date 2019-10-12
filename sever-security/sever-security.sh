#!/bin/sh
# ------------------------------------------------------------------------------
# Server  for Security
#
# Buglab. (c) 2019-
#
# Check for dozens of sever commons vul.
# ------------------------------------------------------------------------------
version='1.1.1'
filename=$(basename "$0")

#set var only read
readonly version
readonly filename


require_install='awk grep stat'

for q in $require_install;do
	command -v "$q" >/dev/null 2>&1 || { printf "%s command not found.\n" "$q"; exit 1; }
done

usage () {
	cat <<EOF
	usage:${filename} {options}

	-h      optional Print this help message
	-l FILE optional Log output in FILE

EOF
}

#add an option here,please remember to update usage() above.
while getopts hl: args;
do
	case $args in
	h) usage; exit 0 ;;
	l) output="$OPTARG" ;;
	*) usage; exit 1 ;;
        esac
done

if [ -z $output ];then
	output="${filename}".log
fi


. ./output_lib.sh

#必须是root来运行
ID=$(id -u)

if [ "x$ID"!="x0" ];then
	warn "Some opeate must root to do."
fi


