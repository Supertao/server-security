#!/bin/sh


check_2(){
	log ""
	id_2="2"
	desc_2="主机端口、配置"
	check_2="$id_2  $desc_2"
	info "$check_2"
}

check_2_1(){

	log ""
	id_2_1="2.1"
	desc_2_1="全网监听"
	check_2_1="$id_2_1 $desc_2_1"
	info "$check_2_1"
	lsof -i -n -P|egrep 'COMMAND|LISTEN' |awk '//||/0.0.0.0/ {print}' |grep -v 127.0.0.1
	if [ $? ];then
		let totalWarn+=1
	fi
	let totalCheck+=1

}

check_2_2(){
        #useradd -u 0 -g 0 用户名
        log ""
	id_2_2="2.2"
	desc_2_2="禁止含有UID为0的非root账号"
	check_2_2="$id_2_2 $desc_2_2"
	info "$check_2_2"
	uid=$(awk -F: '($3==0){print}' /etc/passwd|wc -l)
	if [ $uid -lt 1 ];then
		pass "不存在uid为0的非root账号"
	fi
        
	if [ $uid -gt 1 ];then
	   for i in $(awk -F: '($1!="root"&&$3==0){print}' /etc/passwd);do
	   	warn "UID为0非root账号： $i"
		let totalWarn+=1
	   done
	fi

	let totalCheck+=1

}



check_2
check_2_1
check_2_2
