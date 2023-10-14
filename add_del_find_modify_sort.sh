#!/bin/bash
source /root/stu_sys/global.sh

add_message()
{
	startUI
        read -p "please input sno you want to add:" sno
        count=$(grep "^$sno[ \t]*" $stu_message | wc -l)
        if [ "$count" == 1 ]
      	then
        	 echo "sno already repeat!"
        else
        	read -p "please input sname:" sname
	        read -p "please input sex:" sex
	        read -p "please input English_grade:" English
        	read -p "please input Linux_grade:" Linux
	        read -p "please input Java_grade:" Java
		read -p "please input Mysql_grade:" Mysql
		sum=$((English + Linux + Java + Mysql))
	        avg=$(echo "scale=2; $sum / 4" | bc)
		echo ""	
		echo "successfully added!"
		echo -ne "$sno\t$sname\t\t$sex\t$English\t$Linux\t$Java\t$Mysql\t$sum\t$avg\n" >> $stu_message
	fi
}

delete_message()
{
	startUI
	read -p "please input sno you want to delect:" sno
        stu_info=$(grep "^$sno[ \t]*" $stu_message)
        if [ -z "$stu_info" ]
        then
                echo "sno not found"
        else
                sed -i "/^$sno/d" $stu_message
		echo "successfully deleted!"
        fi	
	
}

find_sno()
{
	read -p "please input sno you want to find:" sno
        stu_info=$(grep "^$sno[ \t]*" $stu_message)
        if [ -z "$stu_info" ]
        then
	        echo "sno not found"
    	else
		echo "$(head -n 1 $stu_message)"
        	echo "$stu_info"
	fi

}
find_sname()
{       
        read -p "please input sname you want to find:" sname
        stu_info=$(awk -v name="$sname" -F '\t' '$2 == name {print}' $stu_message)
	if [ -z "$stu_info" ]
	then
	  	echo "sname not found"
    	else
		echo "$(head -n 1 $stu_message)"
        	echo "$stu_info"
        fi
}
find_menu()
{
	echo ""
	echo "*****************************"
	echo "*****  1.find_sno     *******"
	echo "*****  2.find_sname   *******"
	echo "*****  0.exit         *******"
	echo "*****************************"
}
find_message()
{
	startUI
	while true
	do
		find_menu
		read  -p "please input your find model:" model
		if [ "$model" == "1" ]
		then
			find_sno
		elif [ "$model" == "2" ]
		then
			find_sname
		elif [ "$model" == "0"  ]
		then
			clear
			break
		else
			echo "error!"
		fi
	done
	startUI
}

modify_message()
{
	startUI
	read -p "please input sno you want to modify:" sno
        stu_info=$(grep "^$sno[ \t]*" $stu_message)
        if [ -z "$stu_info" ]
        then
                echo "sno not found"
		return
        else
		sed -i "/^$sno/d" $stu_message
                read -p "please input sname:" sname
                read -p "please input sex:" sex
                read -p "please input English_grade:" English
                read -p "please input Linux_grade:" Linux
                read -p "please input Java_grade:" Java
                read -p "please input Mysql_grade:" Mysql
		sum=$((English + Linux + Java + Mysql))
                avg=$(echo "scale=2; $sum / 4" | bc)
                echo "" 
                echo "successfully modified!"
        	echo -ne "$sno\t$sname\t\t$sex\t$English\t$Linux\t$Java\t$Mysql\t$sum\t$avg\n" >> $stu_message
	fi
}

sort_menu()
{
	echo ""
        echo "************************************************"
        echo "*********        sort  model          **********"
        echo "*********                             **********"
        echo "*********        1.max_grade          **********"
        echo "*********        2.min_grade          **********"
        echo "************************************************"

}
max_grade()
{
#English-Linux-Java-Mysql-sum-avg
	clear
	course_menu
	while true
	do
	read -p "please input a course your want to sort:" course
        if [ "$course" == "1" ]
        then
		clear
                course_menu
		echo "the current subject being sorted is:English"
		(head -n 1 $stu_message && tail -n +2 $stu_message | sort -t $'\t' -k5,5rn) | cat
        elif [ "$course" == "2" ]
        then
		clear
                course_menu
		echo "the current subject being sorted is:Linux"
                (head -n 1 $stu_message && tail -n +2 $stu_message | sort -t $'\t' -k6,6rn) | cat
	elif [ "$course" == "3" ]
	then
		clear
                course_menu
		echo "the current subject being sorted is:Java"	
		(head -n 1 $stu_message && tail -n +2 $stu_message | sort -t $'\t' -k7,7rn) | cat
	elif [ "$course" == "4" ]
        then
		clear
                course_menu
		echo "the current subject being sorted is:Mysql"
                (head -n 1 $stu_message && tail -n +2 $stu_message | sort -t $'\t' -k8,8rn) | cat
	elif [ "$course" == "5" ]
        then
		clear
                course_menu
		echo "the current subject being sorted is:sum"
                (head -n 1 $stu_message && tail -n +2 $stu_message | sort -t $'\t' -k9,9rn) | cat
	elif [ "$course" == "6"  ]
        then
		clear
                course_menu
		echo "the current subject being sorted is:avg"
                (head -n 1 $stu_message && tail -n +2 $stu_message | sort -t $'\t' -k10,10rn) | cat
        elif [ "$course" == "0"  ]
 	then
		break
	else
		clear
                course_menu
                echo "error"
        fi
	done
	startUI
}
min_grade()
{
#English-Linux-Java-Mysql-sum-avg
	clear
        course_menu
        while true
        do
        read -p "please input a course your want to sort:" course
        if [ "$course" == "1" ]
        then
		clear
                course_menu
                echo "the current subject being sorted is:English"
                (head -n 1 $stu_message && tail -n +2 $stu_message | sort -t $'\t' -k5,5n) | cat
        elif [ "$course" == "2" ]
        then
		clear
                course_menu
                echo "the current subject being sorted is:Linux"
                (head -n 1 $stu_message && tail -n +2 $stu_message | sort -t $'\t' -k6,6n) | cat
        elif [ "$course" == "3" ]
        then
		clear
                course_menu
                echo "the current subject being sorted is:Java"		
                (head -n 1 $stu_message && tail -n +2 $stu_message | sort -t $'\t' -k7,7n) | cat
        elif [ "$course" == "4" ]
        then
		clear
                course_menu
                echo "the current subject being sorted is:Mysql"
                (head -n 1 $stu_message && tail -n +2 $stu_message | sort -t $'\t' -k8,8n) | cat
        elif [ "$course" == "5" ]
        then
		clear
                course_menu
                echo "the current subject being sorted is:sum"
                (head -n 1 $stu_message && tail -n +2 $stu_message | sort -t $'\t' -k9,9n) | cat
        elif [ "$course" == "6"  ]
        then
		clear
                course_menu
                echo "the current subject being sorted is:avg"
                (head -n 1 $stu_message && tail -n +2 $stu_message | sort -t $'\t' -k10,10n) | cat
        elif [ "$course" == "0"  ]
        then
                break
        else
                echo "error"
        fi
        done
	startUI
}
sort_grade()
{
	startUI
	sort_menu
	read -p "please input a model your choose:" choose
        if [ "$choose" == "1" ]
        then
                max_grade
        elif [ "$choose" == "2" ]
        then
                min_grade
        else
                echo "error"
        fi
}
