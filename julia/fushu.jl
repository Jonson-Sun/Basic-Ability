#!/home/asen/julia110/bin/julia

#================================
	多进程和多线程 : still need to do

#using Distributed
#using SharedArrays
#addprocs(3)
#pmap
#fetch @spawn
#@everywhere 
#@spawnat

		a = randn(1000)
		@parallel (+) for i=1:100000
		f(a[randi(end)])
		end

		M = {rand(1000,1000) for i=1:10}
		pmap(svd, M)

function use1_multi()
	sum_all()=begin
		tmp=0
		tmp=@distributed (+) for iter in num_list
			iter	
		end
		return tmp
	end
	num_list=Array{Int64}([rand(1:1000) for i=1:1000000])
end

#@time use1_multi()
=============================#
function 同步与异步演示()
	@sync begin
		for id=1:10
			@async begin sleep(rand(1:5));@info  "$id is  a thead id";	end
		end
		
	end
end

#同步与异步演示()



#using PyPlot
function 粮食产量()

	
	title("美国经济危机")
	年份=1783:2019
	危机=[1825,1837,1847,1857,1866,1873,1882,1890,1900,1907, 
	1920,1921,1929,1930,1931,1932,1933,1937,1938,1948,1949,  
	1957,1958,1969,1970,1974,1975,1980,1981,1982,1990,1991,2001,2008]
	
	
	bar(危机,危机)
	legend()
	show()
end
#粮食产量()


#
#		使用预制的函数来拟合 实际分布
#1.假设存在一个先天形式;例如:  ax^2+bx+c
#		1.不假设先验公式又如何?深度学习?
#		2.
#2.逐渐缩小先验形式与实际分布的距离:如何度量一条曲线和所有点的距离?
#		1. 所有样本点(横向距离+纵向距离)/点数
#		2.
#3.缩小距离的方式:
#		1.遍历,随机,
#
#


#using PyPlot
function 先验公式(a,b,c,d)
	result(x)=(a*x^3+b*x^2+c*x+d) #
	return result
end
function 先验公式(a,b,c)
	result(x)=(a*x^2+b*x+c) #
	return result
end
function 先验公式(a,b)
	result(x)=(a*x+b)

	return result
end

function 距离测量()

end
function 修正公式参数()

end
function 查看曲线图像()
	# 验证神经网络是一个多级非线性函数
	x=rand(Int32,100)
	#x=1:100
	k=4

	function 获得随机数(个数) 
		结果=rand(个数)
		#@info 结果
		return 结果; 
	end
	for _ in 1:10
		#@info "$(a),$(b)"
		a=获得随机数(k)
		result1=先验公式(a[1],a[2],a[3],a[4])
		a=获得随机数(k)
		result2=先验公式(a[1],a[2],a[3],a[4])
		a=获得随机数(k)
		result3=先验公式(a[1],a[2],a[3],a[4])
		a=获得随机数(k)
		result4=先验公式(a[1],a[2],a[3])
		a=获得随机数(k)
		result5=先验公式(a[1],a[2])
		
		y=map(result1,x)
		y=map(result2,y)
		y=map(result3,y)
		y=map(result4,y)
		y=map(result5,y)
		
		title("NN猜想验证")
		#@info x
		plot(x,"b^-")
		#@info y
		plot(y,"ro-")
		show()
	end
end
function test()
	查看曲线图像()
end
#test()

# 为什么x,y十分相似?????
function stat_Char()
	#exit=UInt[]
	#str_vec=Char[]
	count=0
	tmp_str=""
	for i=1:2^32
		if isvalid(Char,i)
			#push!(exit,i)
			#push!(str_vec,Char(i))
			tmp_str *="$(i) $(Char(i))\n"
		else
			#push!(noexit,i)
			count+=1
		end
	end
	#@info "存在的元素为$(length(exit))"  #111_2063
	#@info "不存在的元素为$(count)"  #42_9385_5233
	#@info "最大的元素值为:$(maximum(exit)),$(minimum(exit))"
	write("utf8.txt",tmp_str)  #14M
	
end
#stat_Char()


function 图片信息()
	#	md 的图片信息
	# ls>>tmp.txt
	tmp=""
	str_vec=readlines("tmp.txt")
	for item in str_vec
       tmp="![](资本论21/"*item*")<br>"
	   println(tmp)
    end
	
end
