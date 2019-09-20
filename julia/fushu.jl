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
function 串序列转换为正整数(X)
	newX=[]
	for item in X
		push!(newX,parse(Int,item))
	end
	return newX
end
function 串序列转换为浮点数(Y)
	newY=[]
	for item in Y
		push!(newY,parse(Float32,item))
	end
	return newY
end
function 数据处理(数据文件名="data.txt",分隔符="\t")
	数据行=readlines(数据文件名)
	X=[]
	Y=[]
	Y1=[]
	for 元素 in 数据行
		x,y,y1=split(元素,分隔符)
		#三个元素赋值给两个元素的话,多余的元素舍弃
		push!(X,x)
		push!(Y,y)
		push!(Y1,y1)
	end
	return X,Y,Y1
end
function 差值(Y)
	newY=[]
	for i=2:length(Y)
		push!(newY,(Y[i]-Y[i-1]))
	end
	return newY
end
function 画图()
	title("标题:宏观负债率")
	X,Y,Y1=数据处理()
	X=串序列转换为浮点数(X)
	Y=串序列转换为浮点数(Y)
	Y1=串序列转换为浮点数(Y1)
	
	#plot(X,Y,"bo--",label="居民负债率")
	 plot(X[2:end],差值(Y),label="居民负债变化率")
	#plot(X,Y1,"r^-",label="实体企业负债率")
	#plot(X[2:end],差值(Y1),label="企业负债变化率")
	grid()
	legend()
	show()
end
#画图()

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


function 图片转md()
	#	md 的图片信息
	# ls>>tmp.txt
	tmp=""
	str_vec=readlines("tmp.txt")
	for item in str_vec
       tmp="![](资本论21/"*item*")<br>"
	   println(tmp)
    end
end
#图片转md()

#
#	使用递归方式的傅立叶函数
# 1.递归一次,表达式增加一项
# 2.复数表示:complex(x,y);数据存储使用 字典
# 3.正样本标注:分词:只标记词语的结束
#
#问题:
#	如何形成表达式?
#
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

function 特殊符号表()
	内容=repeat("-|",20)*"\n"*repeat(":-:|",20)*"\n"
	for i=1:5_0000
		内容*=string(i)*"|&#"*string(i)*";|"
		if i%10==0
			内容*="\n"
		end
	end
	write("符号表.md",内容)
	@info "运行完成"
	sleep(5)
end
特殊符号表()


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