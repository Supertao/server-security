#!/bin/sh

check_1()
{
   log ""
   id_1="1"
   desc_1="敏感词、敏感文件"
   check_1="$id_1  $desc_1"
   info "$check_1"
}

check_1_1()
{
   log ""
   id_1_1="1.1"
   desc_1_1="明文存储"
   check_1_1="$id_1_1  $desc_1_1"
   info "$check_1_1"
   
   for i in `find / -type f \( -name "*.key" -o  -name "*.log" -o -name ".pem" \) 2>/dev/null`;do
   if [ -L $i ];then
   	echo "the file is softlink!"
	continue
   fi
   ##判断文件中是否含有BEGIN RSA PRIVATE KEY
   ##再判断文件中是否含有ENCRYPTED
   ret=`cat $i |grep -i "\-BEGIN RSA PRIVATE KEY\-"`
   if [ -n "$ret" ];then
  	 #搜索到并再次判断
         encrypted=`cat $i|grep -i "ENCRYPTED"`
         if [ ! -n "$encrypted" ];then
	 	let totalWarn+=1
         	warn "$i not encrypted!"
	 fi
   fi   
   done
   let totalCheck+=1
}

check_1_2()
{
	log ""
   	id_1_2="1.2"
   	desc_1_2="/etc/shadow 是否存在MD5|SHA256"
   	check_1_2="$id_1_2  $desc_1_2"
   	info "$check_1_2"
	shadow=$(cat /etc/shadow|awk -F: '{print $1,$2}' | awk -F$$ '{if($2==1||$2==5||$2==6)print}')
	for i in $shadow;do
		let totalWarn+=1
		warn "/etc/shadow $i"
	done
        #搜索结果很man
	for i in $(find / -name "*.sh" -print0|xargs -0 grep "\$[156]\\$" 2>/dev/null);do
		let totalWarn+=1
		warn "file exists MD5|SHA256 $i"
	done
        
	let totalCheck+=1		
}

check_1_3()
{
        log ""
        id_1_3="1.3"
        desc_1_3="是否存在敏感密码"
        check_1_3="$id_1_3  $desc_1_3"
        info "$check_1_3"
        
	        



}

check_1
check_1_1
check_1_2
check_1_3