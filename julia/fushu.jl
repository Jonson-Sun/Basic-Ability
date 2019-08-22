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
function 距离测量()end
function 修正公式参数()end
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
function test() 查看曲线图像() end
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


#
#	使用递归方式的傅立叶函数
# 1.递归一次,表达式增加一项
# 2.复数表示:complex(x,y);数据存储使用 字典
# 3.正样本标注:分词:只标记词语的结束
#
#问题:
#	如何形成表达式?
#

"""
asd=Dict(1=>2,3=>4)
	for(x,y) in asd
       @info complex(x,y)
    end

	sum(Xn*exp(-im*2*pi*k*n/N))

function 表达式(当前深度=0,最大深度=10)
		当前深度+=1
		if 当前深度<最大深度
			
		end
		表达式(当前深度)
	end


"""
function 万能表示函数(深度=10)
	参数=[] #n
	for i=1:深度
		push!(参数,(rand(-10:10),rand(-10:10),i))
	end
	result=0
	for (a,b,c) in 参数
		result+=a*exp(-2π*b*im/深度)
	end
end







function matrix67()
	table=Dict('1'=>1,'2'=>2,'3'=>3,'4'=>4,'5'=>5,
			   '6'=>6,'7'=>7,'8'=>8,'9'=>9,'0'=>0)
	
	function position_sum()
		#串化
		str_tmp=string(num)
		num=0
		for iter in str_tmp
			num+=table[iter]
		end
		return num #返回按位加和
	end
	function single_calculer()#单步计算
		if(num%2==0)
			num=(position_sum())^2
		else
			num=(position_sum())^3
		end
		return num
	end
	function count()#计算次数
		count_num=0
		while true
			num=single_calculer()
			#@info num
			if num==1 || count_num>9
				break
			end
			count_num+=1
		end
		return count_num
	end
	
	num=10_0000_0000  #488,from2+
	endp=100_0000_0000
	calculer=0
	tmp1=num
	while(num<endp)  #待检验的数值区间
		if(num%3!=0 && num%2==0)
			tmp=count()
			if tmp>9  @info "异常值: $num ;次数为 $tmp "	end
		end
		tmp1+=1
		num=tmp1
		if tmp1%((endp-num)/100)==0
			calculer+=1
			@info "进度: $calculer % num is $num"
		end
	end
end
matrix67()

#湍流，又称为乱流、紊流或扰流
#当流速很小时，流体分层流动，互不混合，称为层流

#曲线的内接正方形
# 证明或推翻，在平面中的任意一条简单封闭曲线上，总能找到四个点，它们恰能组成一个正方形。


#环形跑道难题
#有一个环形跑道，总长为 1 个单位。n 个人从跑道上的同一位置出发，沿着跑道顺时针一直跑下去。每个人的速度都是固定的，但不同人的速度不同。证明或推翻，对于每一个人，总会有一个时刻，他与其他所有人的距离都不小于 1/n

#排序问题加强版
#有 n 个盒子，从左至右依次编号为 1, 2, …, n 。第 1 个盒子里放两个编号为 n 的小球，第 2 个盒子里放两个编号为 n – 1的小球，以此类推，第 n 个盒子里放两个编号为 1 的小球。每一次，你可以在相邻两个盒子中各取一个小球，交换它们的位置。为了把所有小球放进正确的盒子里，最少需要几次交换？

#多面体的展开
#证明或推翻，总可以把一个凸多面体沿着棱剪开，展开成一个简单的平面多边形。

#用平面镜拼成的多边形
# 证明或推翻，对于任意一个内壁全是镜面的多边形，总能在里面找到一个点，使得位于这个点的光源可以照亮整个多边形内部

#Thrackle 猜想
#如果一个图中，每条边都与其它所有边相交恰好一次（顶点处相接也算相交），这个图就叫做一个 thrackle 。问，是否存在边数大于顶点数的 thrackle 图？

#Venn 图
#是否随便什么样的 n 个集合的 Venn 图都可以扩展到 n + 1 个集合{的venn图}呢


#令 U 是一个有限集，S1 , S2 , … , Sn 都是 U 的非空子集，它们满足任意多个集合的并集仍然在这些集合里。证明，一定能找到某个元素，它出现在了至少一半的集合里。