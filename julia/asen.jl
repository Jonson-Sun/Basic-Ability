#   
#	一些比较常用的函数
#

#============================================
utf-8变长编码-> 可直接索引的[]存储?
  使用方式:
	substr("阿三科技的符号i阿斯顿飞呢",3,-2)
	substr("阿三科技的符号i阿斯顿飞呢",3,7)
========================================#

function substr(str::String,start_idx::Int,end_idx::Int)
	#半开半闭区间[start,end) 没法表示索引到结尾
	#使用[start,end] 更附和julia的原则:从1开始
	if end_idx >length(str) @error "BoundsError 索引越界";return end
	char_list=[];
	tmp=""
	
	for item in str		push!(char_list,item)	end
	if end_idx<0 	end_idx=(length(char_list)+end_idx+1) end
	if start_idx>end_idx	return "" end   #排除错误参数
	for item in char_list[start_idx:end_idx]
		tmp=tmp*item
	end
	#@info "$(tmp)"
	return tmp
end


#=======================================
	类型转换:  Int64('苏') ->33487
		String -> Int32 -> bitstring
		Int->Float32 ->
====================================#
function str2array(str::String)
	tmp=[]
	for item in str
		push!(tmp,item)
	end
	return tmp
end
function str2int_array(str::String)
	tmp=Array{Int32,1}()  #不要忘了维度信息
	for item in str
		push!(tmp,Int32(item))
	end
	return tmp
end
function str2int_str(str::String)
	tmp=""
	for item in str
		tmp=tmp*repr(Int(item))
	end
	return tmp
end
function str2BigInt(str::String)
	#十进制 str->BigInt转换
	table=Set(['0','1','2','3','4','5','6','7','8','9'])
	for item in str
		@assert item in table "$(item)不是十进制数字"
	end
	return parse(BigInt,str)
	#return big"1234645675643523412423123456457"
end

#using PyPlot
function 画图()	
	data1=[1.75,2.35,3.0]
	sina_debt=[2.449,2.668,2.659,2.834,3.061,3.178,3.743]
	usa_debt =[1.508,1.587,1.601,1.678,1.800,1.877,2.318]
	japan_debt=[-0.097,-0.110,-0.135,-0.117,-0.1,-0.006,0.424]
	de_debt=[-0.692,-0.641,-0.612,-0.531,-0.42,-0.253,0.276]
	en_debt=[0.597,0.535,0.493,0.564,0.558,0.754,1.256]
	title("2019-12-29各国债务收益率曲线")
	xlabel("时间（年）")
	ylabel("年率")
	xticks=[1,2,3,5,7,10,30]
	x=[1,2,3,5,7,10,30]
	text(20,3.5,"中国国债")
	text(20,2,"美国国债")
	text(20,0.3,"日本国债")
	text(10,-0.5,"德国国债")
	text(20,1,"英国国债")
	
	plot([1,2,3],data1,label="中国利息")
	plot(x,sina_debt,"or-")
	plot(x,usa_debt,"^k-")
	plot(x,japan_debt,"b^--")
	plot(x,de_debt,"yo--")
	plot(x,en_debt,"go-")
	
	grid() #显示网格
	legend()
	show()
end
#=====================================


=====================================#
function 鸡蛋价格(总价,重量=45)
	单价每斤=总价/重量;
	十元重量=10/单价每斤
	十元售重=十元重量-0.5
	@info "鸡蛋价 : " 单价每斤 十元重量 十元售重
end
#鸡蛋价格(175)
#=====================================


=====================================#
function 画圆()
	
	for 间隔=1:50
		x=[i for i=0:间隔:2000pi];
		a=sin.(x);
		b=cos.(x);
		plot(a,b,"bo--");
		title("x=[i for i=0:"*string(间隔)*":2000pi];a=sin.(x);b=cos.(x)")
		show()
	end
end
#画圆()
#========================================

			主函数

=======================================#

function test()
	
	画图()
	
	return true
	
	substr("阿三科技的符号i阿斯顿飞呢",3,-2)
	substr("阿三科技的符号i阿斯顿飞呢",3,7)

	asd="阿三健康的符合牛asdf郎我烦恼"
	@show str2array(asd)
	@show str2int_array(asd)
	@show str2int_str(asd)
	@show str2BigInt(str2int_str(asd))
	@show str2BigInt("123343245e")
end
#test()






#计算杨辉三角数列 1 1开始
#保加利亚单人纸牌游戏（Bulgarian solitaire）
#取出 45 张牌，然后把它们随意分成若干堆。接下来，从每一堆里各取一张牌，叠在一起形成一堆新的牌。不断这样做下去，如果某个时候桌面上正好有 9 堆牌，并且各堆牌数分别为 1, 2, 3, 4, …, 9 ，你就获胜了