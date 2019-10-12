#!/bin/sh


bldred='\033[1;31m'
bldgrn='\033[1;32m'
bldblu='\033[1;34m'
bldylw='\033[1;33m' # Yellow
txtrst='\033[0m'



warn()
{
	printf "%b\n" "${bldred}[WARN]${txtrst} $1" | tee -a "$output"
}
