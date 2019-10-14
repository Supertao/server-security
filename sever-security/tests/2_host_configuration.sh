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
	losf -i -n -P|egrep 'COMMAND|LISTEN' |awk '//||/0.0.0.0/ {print}' |grep -v 127.0.0.1


}
