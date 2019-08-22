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




function test()
		
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