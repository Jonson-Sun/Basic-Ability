#！/bin/bash
#此为txt文档  仅用于记录bash基本内容

#bash脚本 相对于 python 的特点:
#	1.需要注意的语法细节太多(space,$,...)
#	2.多个程序间的协作方便
#	3.给出的错误信息太少(只有错误位置)
#	4.语法要求严格


set  -e #命令运行失败让脚本推出执行

# ---- 基本语法 --------

variable_used() {
	#局部变量声明
	local var1=123; 
	echo $((var1))  # 整数求值使用双括号
	echo $var1  #第二种求值方式
	#声明静态变量
	readonly password="qweasdzxc123#"
	#代换
	user=$(echo "asen")   #自定义变量用小写,环境变量用大写
	echo user
}
function condition {
	val=123
	if [ $val -eq 123 ]; then
		echo "变量是123."
	else
		echo "变量不是123."
	fi
	if [[ $val =~ ^-?[0-9]+$  ]]; then
		# =~ 匹配正则表达式
		echo "val为整数."
	else
		echo "val 不是整数."
	fi
}
loop_used() {
	# 循环的方式1:
	names="sun jonson" #等号的两侧不能有空格
	for chr in $names; # for ((i=0;i<10;i++));
	do
		echo "$chr"
	done
	# for (()) do done
	# 循环的方式2:
	count=0
	while [[ $count -le 5 ]];do
		if [[ $count -eq 3 ]];then
			count=$((count + 1))
			continue  #break
		else
			echo $count
			count=$((count + 1))
		fi
	done
	# 循环的方式3: 同样是满足条件执行
	until [[ $count < 11 ]]; do
		count=$((count + 1));
		echo "until+1 : "$count;
	done
	
	
	local finish=true
	until ((finish != true));   # ????
	do
		echo "第二次until : "$count;
		((count < 15? count++ : break ));
	done

	echo "第3次until "    # 为什么不继续执行?????
	
	fin=0
	
	until ((fin != 0));
	do
		echo "第3次until : "$count;
		((count < 18? count++ : (fin = 1) ));
	done
	
	return
}

function use_case {
	val=6
	case $val in
		1) echo "选项1";;
		3) echo "选项3";;   #注意:两个分号
		6) echo "选项6";;
		*) echo "其他选项";;
	esac
}
function num_str {
	echo "2#1010101结果为:" $((2#1010101));  # 进制#数值
	echo "7#123456234结果为:" $((7#123456234));
	echo "0xff结果为:" $((0xff));
	echo "123 + 123结果为:" $((123 + 123));
	echo "123 -23结果为:" $((123 -23));
	echo "123 * 123结果为:" $((123 * 123));
	echo "123 / 7结果为:" $((123 / 7));
	echo "123 ** 3=指数结果为:" $((123 ** 3));
	echo "123 % 9=求余.结果为:" $((123 % 9 ));
	# += ,-=,*=,/=,%=,  ++, --
	local val=6;
	echo "val++ = $((val++)) ,先输出后加值:6"
	echo "++val = $((++val)) ,先加值,后输出:8"
	echo "val+=1 :$((val+=1)) ,val+1,返回:9"
	# 位运算: 左移<<,右移 >> ,~ 取反,&与,|或,^异或
	echo "0011^1010 :异或的结果为 $(( 2#0011 ^ 2#1010 )) "
	echo "1010"
	echo "1001 : 9"  #异或:相同为0,不同为1
	#逻辑运算: <= ,>= ,== ,< ,> ,!= ,&&,||,三元运算符?:
	echo "2<3 : $((2 < 3 ))   1为真"
	echo $((val > 10 ? 100+"123" : 200+"qwe" ))  #只是输出数字,即三元运算符仅仅用于求值
	#另一种输出方式
	printf "%f %s \n" 520.1314 "mesi"
	#浮点计算:bc
	bc <<- EOF
		result=3.14 * (133.4 ^ 2)
		print result ,"是bc 的执行结果\n"
	EOF
	
}
function array_use {
	#声明数组: declare -a arrayname
	declare -a array_one;
	array_one["blue"]="#0000ff"
	
	array_one[1]=123;
	echo ${array_one[1]};  #  $array_one[1] 结果为1 ???
	
	array_two=(12,23,56,33,76,86,53,99)
	
	
	for i in $array_two;do
		echo $i;  # 为何此处不换行?
	done
	for i in {12,22,32,42,52,62,72};do
		echo $i;   # 而这里换行?
	done
	
	#数组大小
	echo "该数组大小为:"${#array_two[@]};  # =1 ???
	echo "数组第三个元素${array_two[3]}大小为:"${#array_two[3]}; # 数组元素的大小=0 ???
	array_two+=(111,222,333,444)
	echo ${!array_one[@]},${!array_one[*]}  # ???  又是1
	
}

#	-----function to define ------
function first_func {
	echo "第一种函数定义方式";
	echo "    函数中的命令都以分号结尾";
	return
}
second_func() {
	echo "第二种函数定义方式"
	read number_one  # 读取输入
	echo "输入数字为 $((number_one))"
}

#  --------


main () {  #以后 统一同一脚本内的函数定义方式
	#first_func
	#second_func
	#variable_used
	#condition
	# loop_used;use_case;
	# (num_str;array_use;)
	return
}

function end_function {
	main  #三级函数调用演示:end_function-> main -> first_func...
	echo "脚本执行结束"
	exit 0  #正常推出
}
end_function

#   ------  END ------

#	group command
# { ls -l; echo "Listing of foo.txt"; cat foo.txt; } > output.txt
#	subshell
# (ls -l; echo "Listing of foo.txt"; cat foo.txt) > output.txt
# help trap
# mktemp :创建临时文件
#process1 > named_pipe;   process2 < named_pipe 等价于 process1 | process2
#mkpipe pipe_name ;  定义命名管道
#