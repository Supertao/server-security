#!/bin/sh

check_4()
{
   log ""
   id_4="4"
   desc_4="证书中存在不安全的签名算法"
   check_4="$id_4  $desc_4"
   info "$check_4"
}

check_4_1()
{
   log ""
   id_4_1="4.1"
   desc_4_1="不安全的签名算法"
   check_4_1="$id_4_1  $desc_4_1"
   info "$check_4_1"
   
   for i in `find / -type f \( -name ".pem" \) 2>/dev/null`;do
   if [ -L $i ];then
   	echo "the file is softlink!"
	continue
   fi
   ##判断文件中是否含有md5
   ret=`openssl x509 -in  $i -text -noot |grep -i "md5WithRSAEncryption" 2>/dev/null`
   if [ -n "$ret" ];then
  	 #搜索
	 let totalWarned+=1
         warn "$i not encrypted!"
	
   fi   
   done
   let totalCheck+=1
}

check_4_1
