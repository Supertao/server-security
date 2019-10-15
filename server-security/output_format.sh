#!/bin/sh


bldred='\033[1;31m'
bldgrn='\033[1;32m'
bldblu='\033[1;34m'
bldylw='\033[1;33m' # Yellow
txtrst='\033[0m'

log()
{
	printf "%b\n" "${txtrst} $1"|tee -a "$output"
}

pass()
{
	printf "%b\n" "${bldgrn}[PASS]${txtrst} $1"|tee -a "$output"
}

info()
{
	printf "%b\n" "${bldblu}[INFO]${txtrst} $1" | tee -a "$output"
}

warn()
{
	printf "%b\n" "${bldred}[WARN]${txtrst} $1" | tee -a "$output"
}

note()
{
	printf "%b\n" "${bldylw}[note]${txtrst} $1"|tee -a "$output"
}
