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

check_2_3()
{
   	log ""
   	id_2_3="2.3"
   	desc_2_3="是否存在空密码用户"
   	check_2_3="$id_2_3  $desc_2_3"
   	info "$check_2_3"
   	for i in $(awk -F: '($2==""){print}' /etc/shadow);do
		if [ -n "$i" ];then
   			warn "存在空密码 $i"
			let totalWarn+=1
		else
			pass "不存在空密码"
		fi
  	done

	let totalCheck+=1
}

check_2_3_1()
{
	log ""
	id_2_3_1="2.3.1"
	desc_2_3_1="是否存在test账号"
	check_2_3_1="$id_2_3_1 $desc_2_3_1"
	info "$check_2_3_1"

	for i in $(cat /etc/passwd | grep "test*");do
		if [ -n "$i" ];then
			warn "存在测试账号 $i"
			let totalWarn+=1
		else
			pass "不存在测试账号"
		fi
	done

	let totalCheck+=1
}


check_2_3_2()
{
	log ""
	id_2_3_2="2.3.2"
	desc_2_3_2="文件无用户无组织"
	check_2_3_2="$id_2_3_2 $desc_2_3_2"
	info "$check_2_3_2"

	for i in $(find / -xdev \( -nouser -o -nogroup \) -print);do
		if [ -n "$i" ];then
			warn "nouser or nogroup: $i"
			let totalWarn+=1
		else
			pass "not exists nouser and nogroup!"
		fi
	done

	let totalCheck+=1
}


check_2_3_3()
{
      	log ""
	id_2_3_3="2.3.3"
	desc_2_3_3="系统账号(root|sync|shutdown|halt)是否远程登录"
	check_2_3_3="$id_2_3_3 $desc_2_3_3"
	info "$check_2_3_3"

	#\+：匹配前面的字符至少1次
	for i in $(egrep -v "^\+" /etc/passwd | awk -F: '( $1 =="root" || $1=="sync" || $1=="shutdown" || $1=="halt" && $3<500 && $7!="/usr/sbin/nologin")');do
		if [ -n "$i" ];then
			warn "存在系统账号远程登录: $i"
			let totalWarn+=1
		else
			pass "不存在系统账号远程登录!"
		fi
	done

	let totalCheck+=1


}




check_2
check_2_1
check_2_2
check_2_3
check_2_3_1
check_2_3_2
check_2_3_3
