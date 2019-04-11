
#附属julia.jl 文件
#=======================================
	一般来说，我喜欢在较好的语言里找缺点。在糟糕的语言里找优点。
julia 的缺点：
	1、无法像C++一样生成一个可执行文件（垃圾回收）
	2、不习惯使用 end
	3、计数从1开始。英文句号的意思是逐元素调用方法
	4、语言比较新,变化较多
规则:	
	All code is bad
	写看得懂的代码!
=======================================#


#=  
同像性:语言的文本表示（通常指源代码）与其抽象语法树具有相同的结构
多分派:根据[调用者本身类型]和[方法参数]共同确定调用方法的
	结合C的速度与Python的可用性、Ruby的动态性、MATLAB的数学能力和R的统计能力。
=#

#include("fushu.jl")
#called_func_between_files()



function fundmental()
	x=123
	println("x的类型为$(x):",typeof(x))
	println("x类型最小|大值",typemin(x),"_",typemax(x) )

	# 为防止溢出 建议使用 BigInt 类 BigFloat
	# Float64 Int32 UInt64 {8,16,32,64,128}
	println("float64 size:",sizeof(Float64(1.2)),"----",sizeof(1.234)  )
	println("查看二进制表示:",bitstring(888) )
	println("0.0==-0.0  is ",(0.0==-0.0))
	println("1.0与下一个浮点数间的差值:",eps(Float32 ))
	println("2x+4=",(2x+4) )   # 变量数字间的运算默认为乘法
	println(7÷ 2,"-",xor(123, 234),"-")  #整除;异或
	# +=  -=  *=  /=  \=  ÷=  %=  ^=  &=  |=  ⊻= (异或) >>>=(逻辑右移)  >>=  <<=
	println("逐元素运算",[1,2,3] .* 2,"NaN 不等于它自己")
	# isequal 认为 NaN 之间是相等的
	# isfinite(x) 有限数,isinf();  isnan()
	println("链式比较:",(1<2<=23==23< 66))  #链式比较中的顺序是不确定的
	println("sin .([1,2,3])",sin.([1,2,3]))
	println("舍入运算:",round(4.49),"---",trunc(pi))  #ceil():向+inf 取整; trunc 向0取整
	# 除法: fld()下取整; cld(x,y) 上取整 gcd(x,y,z):最大公约数;lcm:最小公倍数
	println("尾数",significand(x/7))
	println("分数:6//9= $(6//9)=$(float(6//9))")
	#  transcode 函数是 提供 Unicode 编码和其他编码转换的函数
	println('G',typeof('G'),Int('\n')  )
	str="hello word!"
	println(str[end-2],str[3:6],length(str*"第二个字符串*链接而不是+"))
	# """三引号 :多行文本"""
	# 正则表达式: r"..."  ,  版本号字面量: v" ... "  原生字符串: raw" ... "
end
#fundmental()   # 函数名字表示函数对象 ; 引用方式传递阐述
# return 函数返回的值是最后计算的表达式的值
# 匿名函数 x -> x^2+2x-1
# 元组: array1=(a=1,'123',345)





function 流程控制()
	println("流程控制函数被调用")
	plus12 = 	begin 
		x=1;y=2;
		println("begin---end 使用" )
		#return x+y  #函数被截断
	end
	#(x=1;y=2;println("复合表达式2"))
	
	asd=true
	if asd == true
		println("条件语句为真")
	elseif asd == false
		println("条件语句为假")
	end
	# if 代码块是"有渗漏的"，也就是说它们不会引入局部作用域。这意味着在 if 语句中新定义的变量依然可以在 if 代码块之后使用
	#(?:) 三元运算符
	i=1
	while i<5
		print(i,"+")
		i+=1
	end
	println("while end")
	for i= 1:5
		print(i,"+")
		break
	end
	println("for end")
	for i in[1,2,3,4],j in [6,7,8,9]
		print(i,"+",j,"=")   #16种组合
		continue
	end
	println("for  in  end")
	# 用 throw 显式地创建异常
	# Julia 提供了 rethrow, backtrace 和 catch_backtrace 函数进行更高级的错误处理
	# 一个 Channel 是一个先进先出的队列
	# 全局声明常量 const ASD=666.666
	# struct 关键字与复合类型一起引入，后跟一个字段名称的块
	# 紧接在对象（函数，宏，类型和实例）之前的字符串都会被认为是对应对象的文档
	# 在 Julia Base 中，@assert 的实际定义更复杂。它允许用户可选地制定自己的错误信息
end
#流程控制()



function test()
	# test Julia's speed
	last_num=100000000
	tmp=1.0
	for  i=1:last_num
		tmp+=i
		tmp-=i
		tmp*=i
		tmp/=i
	end
	println("result is $tmp")
end
#@time  test()   #衡量性能




# julia 性能优化
function option_julia()
	#避免使用全局量;
	# 全局量尽量使用常量:const name=0
	# 全局变量指定类型
	# 已知类型的元素告诉编译器: a::Int64
	#动态参数列表速度慢
	#把大函数拆开
	#循环内部元素类型尽量不变
	# @simd   for
	# 注意:
	println("NaN !=NaN is ",NaN !=NaN )
	println("-0 == +0 : ",(-0 == +0))
	str1="黄天厚土"
	println("str1 的长度为 : ",length(str1) )
	for iter in str1
		print(iter,"+")
	end
	println( repeat("asd+",3) )
	little_func(x,y)=(x+y)*y
	println("简单函数:",little_func(3,4) )
	println("+(1,2,3)=",+(1,2,3))
	println("匿名函数",map((x->x^2+2),[1,2,3]) )
	#工具:@time, @allocated, 或者 -profiler -
	#		Profiling,Lint
end
#option_julia()



# 变参函数
function var_func(tmp=1,x...)
	for i in x   # 使用方式
		tmp +=i
	end
	return tmp
end
#println("变参加和:",var_func(1,2,3,4,5) )

function use_do()
	map([1,2,3,4,5,6]) do x
		if x < 4
			println("x <4  : $x")
		else
			println("x >4 :  $x")
		end
	end
	# open() do io
	
	context=( 1 > 2 ) ? "异常结果." : "正常结果."   # ?: 前后的空格是强制的
	println("三元表达式: $context ")
	# && : 全真为真,有假即假
	#    ||  : 全假为假,有真即真
end
#use_do()



struct my_except <: Exception
	#println("my except 发生!")
end


function use_except()
# Julia 提供了rethrow,backtrace, catch_backtrace进行更高级的错误处理。
	try
		println("try 执行")
		#throw(my_except)  # 先于"try执行"
	catch
		println("catch 执行")
	finally
		println("finally 执行")
	end
#协程: 是一种允许计算以更灵活的方式被中断或者恢复的流程控制特性
	local x=123  # global x :将x引入更内层作用域
	@show x
	println("奇偶判断",iseven(8),isodd(7))
	#比python 中lambda 表达式更简洁
	my_func= (x ,y) -> ((x+y)^2)/2
	println("lambda表达式: ",my_func(12,23))
	println("eval求值 : ",eval(3+2))
	@assert x == 123  "错误信息"# @time  macro time(ex)   end
	println("查看方法信息;",methods(my_func))
	println("函数的形式1",code_lowered(my_func)  )
	println("函数的形式2",code_typed(my_func)  )
	println("函数的形式3"  )
	#@code_llvm my_func()
	println("函数的形式4" )
	#@code_native my_func()  # 命令行可以???
end
#use_except()


#由于 begin 块并不引入新作用域块，使用 let 来引入新作用域块是很有用的
#编译器能自动推断本地变量是否为常量，所以本地常量的声明不是必要的
#列表推导:不能引入外部变量{适合map ,不能加和}
#编写面向抽象类型的函数并不会带来性能上的损失,abstract name
#immutable :不可变类型
#IntOrString = Union(Int,String):共用体类型
#方法重载仅基于位置参数
# 类型转换 convert 函数用于将值转换为各种类型
# using (全部模块内容), import(模块间接调用) ,importall(module的所有export) 
#module name  end  模块域
#三个标准模块: Main,Core,Base
#		Main 是顶级模块，Julia 启动时将 Main 设为当前模块.whos()
#		Core 包含“内置”的所有标志符，例如部分核心语言，但不包括库
#		Base 是标准库（ 在 base/ 文件夹下）
#全局变量 LOAD_PATH 包含了调用 require 时 Julia搜索模块的目录。可以用 push! 进行扩展
# 所有 Julia 流都至少提供一个 read 和一个 write 方法，且第一个参数都是流对象，
#stream=open(filename,'rw')
#for line in eachline(stream)
#close(stream)
# @async  :
# 并行计算 Julia 提供了一个基于消息传递的多处理器环境  
# 通过 julia -p n 启动，可以在本地机器上提供 n 个处理器
# 使用 @everywhere 宏在所有处理器上执行命令
# @parallel  pmap() @spawn   ClusterManager 
# Dates{Date,Datetime}
# 可空类型: Nullable{T}  isnull()
# run(`echo "hello world"`)  #运行外部命令
#调用C代码: 
#		被调用的代码应该是共享库的格式;Julia 调用这些库的开销与本地 C 语言相同。
#		GCC （或 Clang ）编译代码，需要添加 -shared 和 -fPIC 选项
#		t = ccall( (:clock, "libc"), Int32, ())   
#		t=ccall((:函数名,库名),返回值类型,(参数列表) )
# Ptr{Int}: Int型的指针  cpp.jl
# 如果函数修改了它的参数，在函数名后加 !
#在 macros 中调用 eval 实在是个危险的标志
# 在函数中不能使用 using 或 import
#isdefined 函数检测变量是否定义
# 对数组、字符串等索引下标是从 1 开始，而不是从 0 开始,结尾是end
# using Profile  
# @profile func_name
# profile.print()
# @allocated
#=
	type name{T}
		x::T
		y::T
	end
	name{float}
=#

function part1() #数据结构
#列表array
	arr=[]
	for i = 1:20
		push!(arr,i)
	end
	pop!(arr)
	println("可变数组的长度为:",length(arr))
#字典
	ddd=Dict("two"=>234,"three"=> 45)
	ddd["one"]=123
	ks=keys(ddd)
	println("键为:",ks)
	println("值为:",values(ddd))
	println( "属于关系:","one" ∈ ks,"one" in ks)
	println("字典中是否存在'one' 键 : ",haskey(ddd,"one"))
#集合set
	set1=Set([1,2,3,4])
	set2=Set([2,4,7,8,9])
	println("交集:",intersect( set1,set2) )
	println("并集:",union(set1,set2)  )
	println("差集:",setdiff(set1,set2)  ) #[1,3]
	println("差集：",setdiff(set2,set1)  ) #[7, 9, 8]
#矩阵
end
#part1()

function thinkjulia()
	result=trunc(Int64,3.14)
	result1 =round(pi)
	result2=parse(Float64,"3.768")
	println("截断，去掉小数点 ：",result,"---",result1,"---",result2)
	asd="abcdefghijklmnopqrstuvwxyz" #string是不可变类型不能直接赋值
	println("片段：",asd[3:6])
	println(uppercase(asd) )
	println(findfirst("皇上","保重身体呀皇上！"))
	println(findnext("皇上","保重身体呀皇上！",5) )  #第三个参数为起始位置
	@show asd
	println( occursin("asd","qwefghxcvasdfghj"))
	#string 不能使用sort ： sort()不改变排序内容本身；sort!()改变排序对象
	#串转化为数组
	println(collect(asd[1:10]) )
	println(split("this is 我",' '))
	println("array -> string : ",join(["this","is","wo"]," ")  )
	println("insert 31 at index 4",insert!([1,2,3,5,6],4,31))
	#error("错误信息输出!")
	#元组赋值: 
	a,b,c=1,2,3
	println("元组赋值:",b)
	[println(i) for i in zip([1,2,3,4],['a','s','d','g'])]#两个列表长度相同;zip返回值是迭代器
	#collect(zip())  Dict(zip())
	#enumerate : 加索引和python中相同
#随机数
	println(rand(3) ) #生成三个浮点书	
	println(rand(Int64,4 )) #生成4整数
	println(rand(1:100)  )
	println(rand([1,2,45,6,67,45,187,9898]))  #在数据结构中随机选一个
	# asd=replace(asd,"a"=>'-')
	#ispath(pwd())   isdir(pwd())  readdir()  joinpath()  walkdir()
	#using Test
	#命名元组: x=(1,2,3,)
	
end	
#@time thinkjulia()
#=
	块: begin end ,let end ,do end,
	@debug  "information "
	开启debug信息： JULIA_DEBUG=all
	@which 2+2   : 调用的哪一个方法
	get(字典名，key，默认值)
	字典的迭代方法：
	for （k，v）in dict  #括号不能少
	dump(32) : 查看内容的所有信息
	字典按照键值排序：sort(collect(keys(dict_name)))
=#


#======================================
			给markdown文件添加目录索引
起因：
		retext 软件没有[TOC]建立自动索引功能
======================================#
function startwith(head,line)
	#println(line[1],head,line[1]==head)
	if line[1] == head  #第一个字符相同
		return true
	else
		return false
	end
end
function sub_head(head_list,need2sub='#')
#使用数字替换掉所有的#
	count=1
	for line in head_list
		line=replace(line, need2sub => "- " )
		head_list[count]=line
		count+=1
	end
end
function 包装(head_list)
	local mark_count=1
	for line in head_list
		head_list[mark_count]="<a href=\"#chapter-$mark_count\">" * line  *  "</a>  \n"
		mark_count+=1
	end
	pushfirst!(head_list,"\n ---  \n ")
	pushfirst!(head_list,"目录：  ")
	push!(head_list,"\n ---    \n")
end
function add_index2markdown(Markdown_file)
	#给markdown文件按照头（#）添加目录索引
	mark_count=1  #标记#头的出现次数
	head_list=[]  #存储头内容
	new_str=""
	
	open(Markdown_file,"r+") do io
		for line in eachline(io)
			if length(line) < 2  #避免空行导致的bounderror
				continue
			end
			if startwith('#',line)
				push!(head_list,line)
				substr="<a id=\"chapter-$mark_count\"></a>    \n" 
				new_str *= substr  *   line * '\n'
				mark_count+=1
			else
				new_str *= line  * '\n'
			end
		end
		sub_head(head_list)
		包装(head_list)
	end
	open("tmp.txt","w") do io
		for line in reverse(head_list)
			println(line)
			new_str=line * new_str
		end
		#print(new_str)
		write(io,new_str)
	end
	println("markdown 文件添加目录（页内索引）完成。")
end
#Markdown_file="/home/asen/文档/笔记.md"
#add_index2markdown(Markdown_file)  #待优化


#字典按值排序的方法：sort(collect(dict),by=x->x[2])

#模块的基本定义方式
module selfwrite
import Base.show
#export function_name or type_name 
#macro name  end
	#asd=[1,2,32,3,4,5,65,7]
	#println(asd[end-3:end])
#作用域可见性
	var1="全局变量1"
	function func2()
		var3="func2（）变量3"
		@show "其他函数内部：" var1 
	end
	function func()
		asd=Array{Int,1}([1,2,3,4,78,56])	
		function func1()
			var4="func1()变量4"
			@show "func1()子函数内部：" var1 var2 var4 var5 
		end
		var2="func（）变量2"
		local var5="func（）local 变量5"
		#全局，local，函数内 ：可见
		#其他函数内的不可见，包括子函数
		@show "func函数内部：" var1 var2 var5
		
		func1()
		func2()
		#数据结构？？
		return asd
		
	end
qwe=func()
@show "函数外部" var1 typeof(qwe) #函数内部不可见

	
end

# 实验性的多线程库
