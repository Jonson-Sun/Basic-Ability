#附属julia.jl 文件
#=
	一般来说，我喜欢在好的语言里找缺点。在糟糕的语言里找优点。
julia 的缺点：
	1、无法想C++一样生成一个可执行文件（垃圾回收）
	2、不习惯使用 if end；for end
	3、 计数从1开始。英文句号的意思是逐元素调用方法
	4、
=#
function called_func_between_files()
	println("the function was called in other files.")
end

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