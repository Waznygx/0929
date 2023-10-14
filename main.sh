#!/bin/bash
source /root/stu_sys/global.sh
source /root/stu_sys/add_del_find_modify_sort.sh
source /root/stu_sys/statistics.sh

sys_menu()
{
	echo "********************************************************"
        echo "********************************************************"
        echo "******      Students Grade Management System     *******"
        echo "******          What is your identity?           *******"
        echo "******        1.user/teacher    2.student        *******"
        echo "******        0.exit                             *******"
        echo "********************************************************"
        echo "********************************************************"

}
enter_menu()
{
	echo "*****************************"
	echo "*****   Enter Model   *******"
        echo "*****                 *******"
        echo "*****    1.log in     *******"
        echo "*****    2.register   *******"
	echo "*****    0.exit       *******"
        echo "*****************************"
}
#user_sys_menu
user_sys_menu(){
        echo "********************************************************"
        echo "********************************************************"
        echo "******      Students Grade Management System     *******"
        echo "******                                           *******"
        echo "******     1.add_message    2.delete_message     *******"
        echo "******     3.find_message   4.modify_message     *******"
        echo "******     5.statistics     6.sort_grade         *******"
        echo "******     7.print_message  0.exit               *******"
        echo "********************************************************"
        echo "********************************************************"
}
#stu_sys_menu
stu_sys_menu()
{
        echo "********************************************************"
        echo "********************************************************"
        echo "******      Students Grade Management System     *******"
        echo "******                                           *******"
        echo "******       1.print_message     0.exit          *******"
        echo "********************************************************"
        echo "********************************************************"
}
#clear screen
startUI()
{
        clear
	user_sys_menu
}
#user_main
usermain()
{
	startUI
	while [ true ]
	do
	read -p "please input your choose:" input
	case $input in
	1)
		add_message;;
	2)
	        delete_message;;
	3)
        	find_message;;
	4)
	        modify_message;;
	5)
        	statistics;;
	6)
        	sort_grade;;
	7)
		cat $stu_message;;
	0)
        	echo "exit";
		clear;
	        break;;
	*)
        	echo "Invalid option";;
	esac
	done
}

s_find_sno()
{
	read -p "please input your sid:" sno
	count=$(grep -c "^$sno" $s_account)
	stu_info=$(grep "^$sno[ \t]*" $stu_message)
	if [ "$count" -ne 0  ]
	then
		echo -ne "sno\tsname\t\tsex   English\tLinux\tJava\tMysql\tsum\tavg\n" 
		echo "$stu_info"
	else
		echo "this is not your sid"
        fi
}
#smain
s_main()
{
	clear
	while true
	do
		stu_sys_menu
		read -p "please input your choose:" choose
        	if [ "$choose" == "1" ]
	        then
        	       s_find_sno
		elif [ "$choose" == "0" ]
		then
			clear
			break
		else
			echo "error"
	fi
	done
}
s_register()
{
        while true
        do
                read -p "please input your sid:" sid
                count=$(grep -c "^$sid" $s_account)
                if [ "$count" -gt 0  ]
                then
                        echo "account exist!"
                        return
                else
                        break
                fi
        done
        read -sp "please input your spassword:" sp1
	echo ""
        read -sp "please input your spassword again:" sp2
        if [ "$sp1" != "$sp2" ]
        then
                echo "spassword different!"
        else
                echo -e "\nsuccessfully created!\n"
                echo -ne "$sid\t$sp1\n" >> $s_account
        fi
}
s_login()
{
        read -p "please input your sid:" sid
        read -sp "please input your spassword:" sp1
#如果第一个字段（$1）等于id且第二个字段（$2）等于p1，那么就设置变量found为1。在处理完所有行后，如果found不为1（即没有找到匹配的id和密码），那么退出状态为1，否则退出状态为0
#在没有找到匹配的id和密码时返回一个特殊的退出状态2
        if awk -v sid="$sid" -v sp1="$sp1" -F'\t' '$1 == sid && $2 == sp1 {found=1} END {if (found != 1) exit 2}' s_account.txt
        then
                echo -e "\nLogin successful!\n"
                s_main
        else
                echo -e "\nsid or spassword is incorrect!\n"
        fi
}
s_sys()
{
        clear
        while true
        do
        enter_menu
        read -p "please select your enter model:" enter
        if [ "$enter" == "1" ]
        then
                s_login
        elif [ "$enter" == "2" ]
        then
               s_register
        elif [ "$enter" == "0"  ]
        then
                clear
                break
        else
                echo "error"
        fi
        done
        sys_menu
}

register()
{
	while true
	do
        	read -p "please input your id:" id
	      	count=$(grep -c "^$id" $account)
        	if [ "$count" -gt 0  ]
	        then
        	        echo "account exist!"
                	return
		else
			break
	        fi
	done
        read -sp "please input your password:" p1
	echo ""
        read -sp "please input your password again:" p2
        if [ "$p1" != "$p2" ]
        then
                echo -e "\npassword different!\n"
        else
        	echo -e "\nsuccessfully created!\n"
	        echo -ne "$id\t$p1\n" >> $account
        fi
}
login()
{
        read -p "please input your id:" id
        read -sp "please input your password:" p1
#如果第一个字段（$1）等于id且第二个字段（$2）等于p1，那么就设置变量found为1
#在处理完所有行后，如果found不为1（即没有找到匹配的id和密码），那么退出状态为1，否则退出状态为0
#在没有找到匹配的id和密码时返回一个特殊的退出状态2
	if awk -v id="$id" -v p1="$p1" -F'\t' '$1 == id && $2 == p1 {found=1} END {if (found != 1) exit 2}' account.txt
	then
                echo -e "\nLogin successful!\n"
                usermain
        else
                echo -e "\nid or password is incorrect!\n"
        fi
}
user_sys()
{
	clear
	while true
	do
   		enter_menu
        	read -p "please select your enter model:" enter
	        if [ "$enter" == "1" ]
        	then
                	login
	        elif [ "$enter" == "2" ]
	        then
	                register
		elif [ "$enter" == "0"  ]
		then
			clear
			break
	        else
        	        echo "error"
        	fi
	done  
	sys_menu
}

#sys_menu
clear
sys_menu
while true
do
        read -p "please select your identity:" identity
        if [ "$identity" == "1" ]
        then
                user_sys
	elif [ "$identity" == "2" ]
        then
                s_sys
	elif [ "$identity" == "0"  ]
	then
		break
	else
		echo "error"
        fi  
done



