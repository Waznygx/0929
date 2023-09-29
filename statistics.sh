#!/bin/bash
source /root/stu_sys/global.sh

course_menu()
{
	echo ""
        echo "************************************************"
	echo "*********        course  grade        **********"
        echo "*********                             **********"
	echo "*********        1.English_grade      **********"
        echo "*********        2.Linux_grade        **********"
	echo "*********        3.Java_grade         **********"
        echo "*********        4.Mysql_grade        **********"
	echo "*********        5.sum   6.avg        **********"
	echo "*********        0.back               **********"
	echo "************************************************"
	
}
select_course_same()
{
        while true
        do
                read -p "please input course you want to statistics:" course
                if [ "$course" == "1" ]
                then
                        clear
                        course_menu
                        echo "The course currently being counted is: English"
                        same_grade_English
                elif [ "$course" == "2" ]
                then
                        clear
                        course_menu    
                        echo "The course currently being counted is: Linux"
                        same_grade_Linux
                elif [ "$course" == "3" ]
                then
                        clear
                        course_menu
                        echo "The course currently being counted is: Java"
                        same_grade_Java
                elif [ "$course" == "4" ]
                then    
                        clear
                        course_menu
                        echo "The course currently being counted is: Mysql"
                        same_grade_Mysql
                elif [ "$course" == "5" ]
                then    
                        clear
                        course_menu 
			echo "The course currently being counted is: sum"
                        same_grade_sum
                elif [ "$course" == "6" ]
                then    
                        clear
                        course_menu
                        echo "The course currently being counted is: avg"
                        same_grade_avg
                elif [ "$course" == "0" ]
                then    
                        clear
                        break
                else
                        clear
                        course_menu
                        echo "error!"
                fi  
        done
}
select_course_differ()
{
	while true
	do
		read -p "please input course you want to statistics:" course
	        if [ "$course" == "1" ]
	        then
			clear
                        course_menu
			echo "The course currently being counted is: English"
			range_grade_English
	        elif [ "$course" == "2" ]
	        then
			clear
			course_menu	
                        echo "The course currently being counted is: Linux"
	               	range_grade_Linux
	        elif [ "$course" == "3" ]
	        then
			clear
                        course_menu
                        echo "The course currently being counted is: Java"
	               	range_grade_Java
	        elif [ "$course" == "4" ]
        	then                
                        clear
                        course_menu
			echo "The course currently being counted is: Mysql"
			range_grade_Mysql
		elif [ "$course" == "5" ]
                then               
			clear
                        course_menu 
                        echo "unable to judge"
		elif [ "$course" == "6" ]
                then                
			clear
                        course_menu
                        echo "The course currently being counted is: avg"
                        range_grade_avg
		elif [ "$course" == "0" ]
                then                
                        clear
			break
	        else
			clear
                        course_menu
                	echo "error!"
        	fi
	done
}
sta_menu()
{
	echo ""
        echo "************************************************"
	echo "*********     statistics model         *********"
	echo "*********                              *********"
        echo "*********    1.different_grade_ranges  *********"
	echo "*********    2.stu_same_grade          *********"
	echo "*********    0.exit                    *********"
        echo "************************************************"
}
stu_same_grade()
{
	clear
        course_menu
	select_course_same
}
different_grade_ranges()
{
	clear
	course_menu
        select_course_differ	
}
declare -A score_counts_avg
declare -A score_counts_sum
declare -A score_counts_English
declare -A score_counts_Linux
declare -A score_counts_Java
declare -A score_counts_Mysql
same_grade_avg()
{
	line_number=0
# 读取一行内容，使用空格和制表符来分割这一行的内容，并将每个字段的值赋给对应的变量
	while IFS=$' \t' read -r sno sname sex English Linux Java Mysql sum avg
	do
		((line_number++))
	    	if [ $line_number == "1" ]
		then
        		continue
		fi
		sum=$((English + Linux + Java + Mysql))
		avg=$(echo "scale=2; $sum / 4" | bc)
		key="$sno--$avg"
#第一对方括号 [[ ... ]] 是用来包含整个条件表达式的，而第二对方括号 [...] 是用来从关联数组 score_counts_avg 中获取键为 $avg 的元素
		if [[ -v score_counts_avg[$key] ]]
		then
#((...))：这是一个算术复合命令，用于执行算术运算
#$((...))：这是一个算术扩展，用于执行算术运算并返回结果
        		score_counts_avg[$key]=$((score_counts[$key]+1))
	    	else
	        	score_counts_avg[$key]=1
	    	fi	
	done < $stu_message
	for score in ${!score_counts_avg[@]}
	do
	  	echo "$score:  appears ${score_counts_avg[$score]} times"
	done
}
same_grade_sum()
{
        line_number=0
# 读取一行内容，使用空格和制表符来分割这一行的内容，并将每个字段的值赋给对应的变量
        while IFS=$' \t' read -r sno sname sex English Linux Java Mysql sum avg
        do
                ((line_number++))
                if [ $line_number == "1" ]
                then
                        continue
                fi
                sum=$((English + Linux + Java + Mysql))
                key="$sno--$sum"
#第一对方括号 [[ ... ]] 是用来包含整个条件表达式的，而第二对方括号 [...] 是用来从关联数组 score_counts 中获取键为 $avg 的元素
                if [[ -v score_counts_sum[$key] ]]
                then
#((...))：这是一个算术复合命令，用于执行算术运算
#$((...))：这是一个算术扩展，用于执行算术运算并返回结果
                        score_counts_sum[$key]=$((score_counts_sum[$key]+1))
                else
                        score_counts_sum[$key]=1
                fi
        done < $stu_message
        for score in ${!score_counts_sum[@]}
        do
                echo "$score:  appears ${score_counts_sum[$score]} times"
        done
}
same_grade_English()
{
        line_number=0
# 读取一行内容，使用空格和制表符来分割这一行的内容，并将每个字段的值赋给对应的变量
        while IFS=$' \t' read -r sno sname sex English Linux Java Mysql sum avg
        do
                ((line_number++))
                if [ $line_number == "1" ]
                then
                        continue
                fi
                key="$sno--$English"
#第一对方括号 [[ ... ]] 是用来包含整个条件表达式的，而第二对方括号 [...] 是用来从关联数组 score_counts_English 中获取键为 $avg 的元素
                if [[ -v score_counts_English_English[$key] ]]
                then
#((...))：这是一个算术复合命令，用于执行算术运算
#$((...))：这是一个算术扩展，用于执行算术运算并返回结果
                        score_counts_English[$key]=$((score_counts[$key]+1))
                else
                        score_counts_English[$key]=1
                fi
        done < $stu_message
        for score in ${!score_counts_English[@]}
        do
                echo "$score:  appears ${score_counts_English[$score]} times"
        done
}
same_grade_Linux()
{
        line_number=0
# 读取一行内容，使用空格和制表符来分割这一行的内容，并将每个字段的值赋给对应的变量
        while IFS=$' \t' read -r sno sname sex English Linux Java Mysql sum avg
        do
                ((line_number++))
                if [ $line_number == "1" ]
                then
                        continue
                fi
                key="$sno--$Linux"
#第一对方括号 [[ ... ]] 是用来包含整个条件表达式的，而第二对方括号 [...] 是用来从关联数组 score_counts_Linux 中获取键为 $avg 的元素
                if [[ -v score_counts_Linux[$key] ]]
                then
#((...))：这是一个算术复合命令，用于执行算术运算
#$((...))：这是一个算术扩展，用于执行算术运算并返回结果
                        score_counts_Linux[$key]=$((score_counts[$key]+1))
                else
                        score_counts_Linux[$key]=1
                fi
        done < $stu_message
        for score in ${!score_counts_Linux[@]}
        do
                echo "$score:  appears ${score_counts_Linux[$score]} times"
        done
}
same_grade_Java()
{
        line_number=0
# 读取一行内容，使用空格和制表符来分割这一行的内容，并将每个字段的值赋给对应的变量
        while IFS=$' \t' read -r sno sname sex English Linux Java Mysql sum avg
        do
                ((line_number++))
                if [ $line_number == "1" ]
                then
                        continue
                fi
                key="$sno--$Java"
#第一对方括号 [[ ... ]] 是用来包含整个条件表达式的，而第二对方括号 [...] 是用来从关联数组 score_counts_Java 中获取键为 $avg 的元素
                if [[ -v score_counts_Java[$key] ]]
                then
#((...))：这是一个算术复合命令，用于执行算术运算
#$((...))：这是一个算术扩展，用于执行算术运算并返回结果
                        score_counts_Java[$key]=$((score_counts[$key]+1))
                else
                        score_counts_Java[$key]=1
                fi
        done < $stu_message
        for score in ${!score_counts_Java[@]}
        do
                echo "$score:  appears ${score_counts_Java[$score]} times"
        done
}
same_grade_Mysql()
{
        line_number=0
# 读取一行内容，使用空格和制表符来分割这一行的内容，并将每个字段的值赋给对应的变量
        while IFS=$' \t' read -r sno sname sex English Linux Java Mysql sum avg
        do
                ((line_number++))
                if [ $line_number == "1" ]
                then
                        continue
                fi
                key="$sno--$Mysql"
#第一对方括号 [[ ... ]] 是用来包含整个条件表达式的，而第二对方括号 [...] 是用来从关联数组 score_counts_Mysql 中获取键为 $avg 的元素
                if [[ -v score_counts_Mysql[$key] ]]
                then
#((...))：这是一个算术复合命令，用于执行算术运算
#$((...))：这是一个算术扩展，用于执行算术运算并返回结果
                        score_counts_Mysql[$key]=$((score_counts[$key]+1))
                else
                        score_counts_Mysql[$key]=1
                fi
        done < $stu_message
        for score in ${!score_counts_Mysql[@]}
        do
                echo "$score:  appears ${score_counts_Mysql[$score]} times"
        done
}

range_grade_avg()
{
    	fail=0
    	pass=0
	good=0
    	very_good=0
	excellent=0
	line_number=0
#读取一行内容，使用空格和制表符来分割这一行的内容，并将每个字段的值赋给对应的变量
	while IFS=$' \t' read -r sno sname sex English Linux Java Mysql sum avg
	do
		((line_number++))
		if [ $line_number == "1" ]
		then
	        	continue
		fi
		sum=$((English + Linux + Java + Mysql))
		avg=$(echo "scale=2; $sum / 4" | bc)
		if [ $(echo "$avg >= 90" | bc -l) == "1" ]
		then
			((excellent++))
		elif [ $(echo "$avg >= 80" | bc -l) == "1" ]
		then
			((very_good++))
		elif [ $(echo "$avg >= 70" | bc -l) == "1" ]
		then
			((good++))
		elif [ $(echo "$avg >= 60" | bc -l) == "1" ]
		then
			((pass++))
		else
			((fail++))
		fi	
    	done < $stu_message
	echo "fail: $fail"
    	echo "pass: $pass"
    	echo "good: $good"
    	echo "very_good: $very_good"
    	echo "excellent: $excellent"
}
range_grade_English()
{
        fail=0
        pass=0
        good=0
        very_good=0
        excellent=0
        line_number=0
#读取一行内容，使用空格和制表符来分割这一行的内容，并将每个字段的值赋给对应的变量
        while IFS=$' \t' read -r sno sname sex English Linux Java Mysql sum avg
        do
                ((line_number++))
                if [ $line_number == "1" ]
                then
                        continue
                fi
                if [ "$English" -ge 90 ]
                then
                        ((excellent++))
                elif [ "$English" -ge 80 ]
                then
                        ((very_good++))
                elif [ "$English" -ge 70 ]
                then
                        ((good++))
                elif [ "$English" -ge 60 ]
                then
                        ((pass++))
                else
                        ((fail++))
                fi
        done < $stu_message
        echo "fail: $fail"
        echo "pass: $pass"
        echo "good: $good"
        echo "very_good: $very_good"
        echo "excellent: $excellent"
}
range_grade_Java()
{
        fail=0
        pass=0
        good=0
        very_good=0
        excellent=0
        line_number=0
#读取一行内容，使用空格和制表符来分割这一行的内容，并将每个字段的值赋给对应的变量
        while IFS=$' \t' read -r sno sname sex English Linux Java Mysql sum avg
        do
                ((line_number++))
		if [ $line_number == "1" ]
                then
                        continue
                fi
		if [ "$Java" -ge 90 ]
                then
                        ((excellent++))
		elif [ "$Java" -ge 80 ]
                then
                        ((very_good++))
		elif [ "$Java" -ge 70 ]
                then
                        ((good++))
		elif [ "$Java" -ge 60 ]
                then
                        ((pass++))
                else
                        ((fail++))
                fi
        done < $stu_message
        echo "fail: $fail"
        echo "pass: $pass"
        echo "good: $good"
        echo "very_good: $very_good"
        echo "excellent: $excellent"
}
range_grade_Linux()
{
        fail=0
        pass=0
        good=0
        very_good=0
        excellent=0
        line_number=0
#读取一行内容，使用空格和制表符来分割这一行的内容，并将每个字段的值赋给对应的变量
        while IFS=$' \t' read -r sno sname sex English Linux Java Mysql sum avg
        do
                ((line_number++))
                if [ $line_number == "1" ]
                then
                        continue
                fi
                if [ "$Linux" -ge 90 ]
                then
                        ((excellent++))
                elif [ "$Linux" -ge 80 ]
                then
                        ((very_good++))
                elif [ "$Linux" -ge 70 ]
                then
                        ((good++))
                elif [ "$Linux" -ge 60 ]
                then
                        ((pass++))
                else
                        ((fail++))
                fi
        done < $stu_message
        echo "fail: $fail"
        echo "pass: $pass"
        echo "good: $good"
        echo "very_good: $very_good"
        echo "excellent: $excellent"
}
range_grade_Mysql()
{
        fail=0
        pass=0
        good=0
        very_good=0
        excellent=0
        line_number=0
#读取一行内容，使用空格和制表符来分割这一行的内容，并将每个字段的值赋给对应的变量
        while IFS=$' \t' read -r sno sname sex English Linux Java Mysql sum avg
        do
                ((line_number++))
                if [ $line_number == "1" ]
                then
                        continue
                fi
                if [ "$Mysql" -ge 90 ]
                then
                        ((excellent++))
                elif [ "$Mysql" -ge 80 ]
                then
                        ((very_good++))
                elif [ "$Mysql" -ge 70 ]
                then
                        ((good++))
                elif [ "$Mysql" -ge 60 ]
                then
                        ((pass++))
                else
                        ((fail++))
                fi
        done < $stu_message
        echo "fail: $fail"
        echo "pass: $pass"
        echo "good: $good"
        echo "very_good: $very_good"
        echo "excellent: $excellent"
}
statistics()
{
	startUI
	while true
	do
		sta_menu
		read -p "please input a model your choose:" choose
		if [ "$choose" == "1" ]
		then
			different_grade_ranges
		elif [ "$choose" == "2" ]
	        then
			stu_same_grade
		elif [ "$choose" == "0"  ]
		then
			clear
			break
		else
			echo "error"
		fi
	done
	startUI
}

