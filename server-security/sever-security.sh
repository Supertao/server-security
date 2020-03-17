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


require_install='awk grep stat lsof'

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
while getopts hl:p: args;
do
	case $args in
	h) usage; exit 0 ;;
	l) output="$OPTARG" ;;
	p) product="$OPTARG" ;;
	*) usage; exit 1 ;;
        esac
done

if [ -z $output ];then
	output="${filename}".log
	if [ -f $output ];then
		rm -rf $output
	fi	
fi


. ./output_format.sh

#必须是root来运行
ID=$(id -u)

if [ "x$ID" != "x0" ];then
	warn "Some operate must require root to do."
fi

#Total Score
#Warn count, Pass counts
totalCheck=0
totalWarn=0
totalPass=0

log "Security Check $(date)\n"

#all check in the test directory
main(){

for test in tests/*.sh;do
	. ./"$test"
done	

printf "\n"

info "Total Checks:$totalCheck"
info "Warn Checks:$totalWarn"
info "Pass Checks:$totalPass"

}

main "$@"
