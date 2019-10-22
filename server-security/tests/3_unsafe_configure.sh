#!/bin/sh


check_3(){
	log ""
	id_3="3"
	desc_3="不安全的配置"
	check_3="$id_3  $desc_3"
	info "$check_3"
}

check_3_1(){

	log ""
	id_3_1="3.1"
	desc_3_1="是否安装了不安全的程序"
	check_3_1="$id_3_1 $desc_3_1"
	info "$check_3_1"
	not_install='tcpdump gdb strace readelf gcc cpp mirror java'
	for p in $not_install;do
		retString=$(command -v "$p" 2>/dev/null)
		if [ "x" != "x$retString" ];then
			let totalWarn+=1
			warn "安装了：$p"
		else
			let totalPass+=1
			pass "没安装：$p"
		fi
		let totalWarn+=1
	done
	let totalCheck+=1

}
check_3
check_3_1
