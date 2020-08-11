#!/bin/sh
#bash 文件的执行方式
#	./filename.sh  bash  source_filename 执行
#
find_max_memory_and_kill()
{

	# 存在的问题
	# 	inkscape打开大图片失败
	#	过程: 图片右键inkscape打开
	val=$(ps -eo pid,args,pmem | sort -k 3 -r -n| head -1 )
	echo "$val"
	id_proc=$(echo "$val"| awk '{print $1}')
	name_proc=$(echo "$val"| awk '{print $2}')
	mem_use=$(echo "$val"| awk '{print $3}')
	echo "$val1"
	if [ $(echo "$mem_use > 30"| bc) = 1 ]; then 
		#[空格 expr 空格]的内部需要空格
		kill -9 $id_proc
		echo "$name_proc 已杀死"
		echo "id为$id_proc"
	else 
		echo "不存在超大占用内存的应用"
		echo "最大进程为:$name_proc"
		echo "占用内存$mem_use %"
		#不要加括号 $name_proc
	fi
}
#find_max_memory_and_kill
find_max_memory_and_kill_2()
{
	#1. 文件读写方式
	#top -n 1 -o +%MEM | head -4|tail -1|cat > asd.txt
	#echo "$(cut -d ' ' -f 4 < asd.txt )" > asd.txt
	#asd=$(echo "$(cut -d '/' -f 1 < asd.txt )" )
	#echo $asd
	#top -n 1 -o +%MEM 	#只输出一次,按照内存占用排序
	#2. 变量存储方式
	asd=$(top -n 1 -o +%MEM | head -4|tail -1|awk -F ' ' '{print $4}');
	M_sum=$(echo "$asd"| awk -F '/' '{print $1}');
	#echo ":$M_sum "  	# ^[ 为Esc 
	#m_sum1=$(echo "$asd" | tr -cd '[0-9|.]') #替换的方法失败
	m_sum1=$(echo "${asd:0:2}" )
	echo "总的内存使用量:$m_sum1"
	if [ $(echo "$m_sum1 > 50"|bc) = 1 ]; then 
		#杀死占用内存最大的进程
		asd=$(top -n 1 -o +%MEM | head -8|tail -1);
		#echo "$asd"
		mem_use=$(echo "$asd" | awk -F ' ' '{print $7}')
		id_proc=$(echo "$asd" | awk -F ' ' '{print $2}')
		name_proc=$(echo "$asd" | awk -F ' ' '{print $1}')
		echo "id为 $id_proc;内存占用:$mem_use%"
		kill -9 $id_proc
		echo "已经杀死进程:$name_proc;"
	else
		echo "内存占用未过界!"
	fi
}
find_max_memory_and_kill_3()
{
	asd=$(top -n 1 -o +%MEM | head -4|tail -1|awk -F ' ' '{print $4}');
	m_sum1=$(echo "${asd:0:2}" )
	echo "1. ============================================================"
	echo " + 总内存使用量:$m_sum1"
	if [ $(echo "$m_sum1 > 80"|bc) = 1 ]; then 
		#杀死占用内存最大的进程
		asd=$(top -n 1 -o +%MEM | head -8|tail -1);
		#echo "$asd"
		mem_use=$(echo "$asd" | awk '{print $7}')
		id_proc=$(echo "$asd" | awk '{print $2}')
		name_proc=$(echo "$asd" | awk '{print $1}')
		
		kill -9 $id_proc
		echo " + 已经杀死进程:$name_proc;"
		echo " + 进程id为: $id_proc;"
		echo " + 内存占用:$mem_use%"
	else
		echo " + 内存占用未越界90%"
	fi
}
face()
{
	find_max_memory_and_kill_3
	
	echo "2. ============================================================"
	#查看进程的 id ,名字,内存占用率,cpu占用率
	#按照第3列[cpu使用率]进行排序,逆序,数值比较:sort -k 4 -r -n
	#只显示前10个
	echo "   ID           进程名             内存 cpu"
	echo "$(ps -eo pid,args,pmem,pcpu | sort -k 3 -r -n| head -10)"
	echo "3. ============================================================"
	echo " + $(ifconfig wlp3s0)"  #可替换:wlp3s0
	#echo " + $(df -h)"
	echo " + $(date)"

}


face




change_size()
{
	echo "窗口大小改变!"
}
signal()
{
	trap "" SIGINT  #阻塞ctrl-c信号
	trap change_size SIGWINCH  #将调整窗口大小信号 替换为函数调用
	sleep 10 #睡眠10s
	#子函数执行嗯sleep 主函数执行wait
	#spawnjob

}
#signal

# 速度:case_in > elif > if ;差别不明显
# 管道: mkfifo  echo read exec rm

function_math1()
{	
	#此种方法速度较快
    FROM=1
    TO=$(( $FROM + 3 ))
    while [ $FROM -lt 1000 ] ; do
		eval "FOO_$TO=\$FOO_$FROM"
		FROM=$(( $FROM + 1 ))
		TO=$(( $TO + 1 ))
    done
}

function_math2()
{
	#此种最慢
    FROM=1
	TO=`echo $FROM + 3 | bc`
    while [ $FROM -lt 1000 ] ; do
		eval "FOO_$TO=\$FOO_$FROM"
		FROM=`echo $FROM + 1 | bc`
		TO=`echo $FROM + 1 | bc`
	done
}
function_math3()
{
    FROM=1
    TO=`expr $FROM + 3`
    while [ $FROM -lt 1000 ] ; do
		eval "FOO_$TO=\$FOO_$FROM"
		FROM=`expr $FROM + 1`
		TO=`expr $TO + 1`
    done
}
#time function_math1
#time function_math2
#time function_math3

#找到超大进程并杀死
find_max_process_and_kill()
{
	ps -aux | sort -k4nr | head -1 | awk '{print $2}'
	print "进程id为: $process_id"  #?
	kill -9 process_id;
}
#find_max_process_and_kill



first()
{
	echo '我是谁?'
	#killall -9 evolution-calendar-factory
	#命令 文件名
	#julia asd.jl
	echo 'evolution is over!'
	printf "\ec" # resets the screen
	echo "c" # Resets the screen
	reset    # Resets the screen
}
table()
{
	NAME="John Doe"
	ADDRESS="1 Fictitious Rd, Bucksnort, TN"
	PHONE="(555) 555-5555"
	GPA="3.885"
	printf "%20s | %30s | %14s | %5s\n" "Name" "Address" "Phone Number" "GPA"
	printf "%20s | %30s | %14s | %5.2f\n" "$NAME" "$ADDRESS" "$PHONE" "$GPA"

}
number_used()
{
	GPA="3.885"

	printf "%f | whatever\n" "$GPA"
	printf "%20f | whatever\n" "$GPA"
	printf "%+20f | whatever\n" "$GPA"
	printf "%+020f | whatever\n" "$GPA"
	printf "%-20f | whatever\n" "$GPA"
	printf "%- 20f | whatever\n" "$GPA"

}
color_used()
{
	printf '\e[41mH\e[42me\e[43ml\e[44;32ml\e[45mo\e[m \e[46;33m'
	printf 'W\e[47;30mo\e[40;37mr\e[49;39ml\e[41md\e[42m!\e[m\n'
}
#color_used



#-------bash string deal --------
# iconv ,head ,tr(字符替换,压缩,删除), wc,  split,sort,uniq,
# cut, paste, join,grep,sed,  awk
function_word()
{
	iconv -f UTF-8 -t gbk inputfile >> outputfile
	# -l 列出所有可用字符编码; -c 忽略不能转换的非法字符
	
	#head -n 行数 文件名
	#head -c 字符数 文件名
	
	#tr -d 删除
	#tr -s 连续重复字符->一个字符
	#tr '[A-Z]' '[a-z]'  大写->小写
	
	#wc -l 行计数
	#wc -c 字节数
	#wc -L 最长行的字符数
	#wc -w 单词数目
	
	#split 大文件->小文件
	#split -l 500 源文件 结果文件名前缀
	#split -b 按字节分割
	
	#sort 排序 uniq 去重
	
	#cut -d -f 2- 保留第二列以后的所有
	
	#paste -d ',' 文件1 文件2 > 结果文件
	#将两个文件的每一行使用','连接
	
	#join 连接
	
	#grep 正则搜索
	
	#sed 流
	#awk编辑器
}



#-------old code--------
condition_state()
{
	#条件语句1
	VARIABLE="Silly"
	if [ "x$VARIABLE" = "xSilly" ] ; then
		echo "愚蠢的人类，小孩才写脚本"
	fi
	#条件语句2
	AI="bar"   #没有空格
	if [ "x$AI" = "xfoo" ] ; then
		echo "Foo"
	elif [ "x$AI" = "xbar" ] ; then
		echo "Bar"
	else
		echo "Other"
	fi
}
loop_function()
{
	#循环
	for i in a b c\ d ; do
		echo $i
	done

	IFS=":"
	LIST="a:b:c d"
	for i in $LIST ; do
		echo $i
	done

	i=1
	while [ $i -le 3 ] ; do
		echo "I is $i"
		i=`expr $i '+' 1`
	done
}
use_case()
{
	# case
	LOOP=0
	while [ $LOOP -lt 12 ] ; do
		VAL=`expr $LOOP % 10`
		case "$VAL" in
			( 0 ) echo "零" ;;
			( 1 ) echo "壹" ;;
			( 2 ) echo "贰" ;;
			( 3 ) echo "叁" ;;
			( 4 ) echo "肆" ;;
			( 5 ) echo "伍" ;;
			( 6 ) echo "陆" ;;
			( 7 ) echo "柒" ;;
			( 8 ) echo "捌" ;;
			( 9 ) echo "九" ;;
			( * ) echo "This shouldn't happen." ;;
		esac
		LOOP=$((LOOP + 1))
	done
}
expression()
{
	#表达式
	NAME=`expr "$1" '|' "Untitled"`
	echo "The chosen name was $NAME"

	STRING="This is a test"
	expr "$STRING" : ".*i"   #？
	echo "一共有多少字符？"
	expr "$STRING" : ".*"
	echo "打印est 结尾前的四个字符："
	expr "$STRING" : '.*\(....\)est'
}

#复制文件or 目录
#cp fold—file  determination——place 
#文件归档
#tar -czf file1 fold/file2   #保留文件路径
#tar -xzf *.tar
#远程服务器调用：下载 or 上传
#ssh username@hostname "cd /path/to/source; \ tar -czf - directory_name" | tar -xzf -
#tar -czf - directory_or_file_name | ssh username@hostname \ "cd /path/to/destination; tar -xzf -"
other_func()
{
	#目录检测
	if [ -d "/usr/bin/" ] ; then
		echo "/bin is a directory."
	fi
	#回显函数中的参数
	for i in "$@" ; do
		echo ARG $i
	done
	#将参数存到 VALUE 中
	#getopts ":hlo:" VALUE "$@"
}

#cmd输入
#printf "姓名 年龄 -> "
#read NAME Age
#echo "你好, $NAME. \n 都活了 $Age 年了！ "

#写入文件
#cat > mycprogram.c << EOF
# include <stdio.h> 
#EOF

mysub()
{
    local MYVAR
	MYVAR=3
	echo "SUBROUTINE: MYVAR IS $MYVAR";
	return 110  #返回值存储在$?
}
# source filename.sh  #在脚本中执行另一个脚本文件。
math_func()
{
	PI=3.14
	RAD=7
	AREA=$(echo "$PI * ($RAD ^ 2)" | bc)
	echo "The area is $AREA"
	
	asd=$(expr '(' '3' '*' '4' ')' '+' '2')
	qwe=$(expr '3' '<' '-2')
	echo "result is $asd,and $qwe ."
	
	expr '1' '+' '2'   #直接输出结果
	expr '2' '<' '1'
	
}
#int2oct()
{
	# 十进制到八进制转换
    echo $(echo "obase=8; $1" | bc)
}
#int2oct 214

advance()
{
	VAR1_VALUE="7"
	VAR1_NEXT="VAR2"

	VAR2_VALUE="11"
	VAR2_NEXT="VAR3"

	VAR3_VALUE="42"

	HEAD="VAR1"
	POS=$HEAD
	while [ "x$POS" != "x" ] ; do
		echo "POS: $POS"
		VALUE="$(eval echo '$'$POS'_VALUE')"
		echo "VALUE: $VALUE"
		POS="$(eval echo '$'$POS'_NEXT')"
	done

return

	count=0
	val="-1"
	echo "输入一列数字,按空格分开"

	read LIST
	IFS=" "
	for val in $LIST ; do
		eval ARRAY_$count=$val
		eval export ARRAY_$count
		count=$(expr $count '+' 1) 
	done


	count1=0;

	echo "输出数组"
	while [ $count1 -lt $count ] ; do
		echo "ARRAY[$count1] = $(eval echo '$'ARRAY_$count1)"
		count1=$(expr $count1 '+' 1) 
	done

return

	eval X=3;echo X==$X;
	VARIABLE="X";eval $VARIABLE=3;echo $X;
	
	#环境变量设置
	var1="julia_tmp"
	val1="/home/asen/julia110/julia"
	eval $var1=$val1
	echo $var1
	eval echo  "$"$var1
	
	eval export  $var1
	export | tail 
	
}
#advance






#call function area
#expression
#other_func 1 2 3 
#mysub
#math_func

#这不太符合我的兴趣，但现实压过兴趣

#目前人类连智力是什么都没有定论，更别说用智商精确测量智力的方法了
#