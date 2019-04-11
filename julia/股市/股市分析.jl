# 本文件为Julia程序设计预言源文件 

#=====================================
金融数据处理: 
	1,下载大盘数据:download_data.py 
		关键:url="http://hq.sinajs.cn/list=sh601006"  
		美股的股票代码为字母:有待进一步分析     
	2,分析股市数据
		暂时处理上证和深证,由于存在时间差,暂不分析港股;
		统计量使用均值和标准差;(加权的话可能有偏见)
==================================#
import Statistics.std  #标准差
import Statistics.mean  #均值
import Statistics.median #中位数
import Serialization.serialize
import Serialization.deserialize

function 符数转换(数字串:: SubString{String})
	#@info typeof(数字串)
	number::Float64=0.0
	小数=false
	指数=1
	进制=10
	table=Dict('0'=>0,'1'=>1,'2'=>2,'3'=>3,'4'=>4,'5'=>5,
	        '6'=>6,'7'=>7,'8'=>8,'9'=>9)   
	for item in 数字串
		if item == '.'   小数=true;指数=0;进制=1;number/=10;continue; end
		if 小数 == true 指数-=1 end
	    number=number*进制 + table[item]*(10.0^指数)
	end
	return round(number,digits=4)
end

function 分析股市1(文件名,类型::Int=4)
	#类型为2:3是昨天收盘价与今天收盘价的变化
	function 获取数据(列::Int)
		# 2:昨日收盘价格;
		# 4:当前价格;
		# 3:今日收盘价格
		数据列=[]
		for 行 in eachline(文件名)
		  try
			单数据=split(行,",")
			tmp= 符数转换(单数据[列])
			if tmp<0.01 continue end #去掉不变项(变化过小的项)
			push!(数据列,tmp)
		  catch e 
	  		@info "出现异常:$(e)"
	  		continue
	  	  end
		end
		return 数据列
	end
		
	当前价格向量=获取数据(类型)
	当前均值=mean(当前价格向量)
	当前标准差=std(当前价格向量)

	return round(当前均值,digits=4),round(当前标准差,digits=4)
end


function 实时分析()
	上证="shdata.txt"
	深证="szdata.txt"
	list_sh,list_sz=[],[]	
	
	for i=1:30
		run(`rm -f shdata.txt`)
		run(`rm -f szdata.txt`)
		run(`./download_data.py`)
		
		num1=分析股市1(上证)
		push!(list_sh,num1)
		num2=分析股市1(深证)
		push!(list_sz,num2)
		
		
		@info "完成第$(i)次操作.$(num1),$(num2)"
	end
	#序列化与反序列化
	serialize("tmp_sh",list_sh)
	serialize("tmp_sz",list_sz)
	#list_sh=deserialize("tmp_sh")
	#list_sz=deserialize("tmp_sz")
end


#import PyPlot.plot  #pyplot太慢
function 展示结果()
	list_sh=deserialize("tmp_sh")
	list_sz=deserialize("tmp_sz")
	plot(list_sh)
	show()
	plot(list_sz)
	show()
end
#实时分析()
#展示结果()



#===============================================
	第二部分:
	
=============================================#


function 统计两种价格(文件名,col1=3,col2=4)

	function 获取数据(列::Int)
		# 2:昨日收盘价格;
		# 3:今日收盘价格
		数据列=[]
		for 行 in eachline(文件名)
		  try
			单数据=split(行,",")
			tmp= 符数转换(单数据[列])
			if tmp<0.01 continue end #去掉不变项(变化过小的项)
			push!(数据列,tmp)
		  catch e 
	  		@info "出现异常:$(e)"
	  		continue
	  	  end
		end
		return 数据列
	end
		
	价格向量1=获取数据(col1)
	均值1=mean(价格向量1)
	标准差1=std(价格向量1)
	
	价格向量2=获取数据(col2) 
	均值2=mean(价格向量2)
	标准差2=std(价格向量2)

	@info "统计中包含指数变化"
	#@show 昨日收盘价格向量[rand(1:100)]
	@show length(价格向量1)
	@show length(价格向量2)
		
	@show round(均值1,digits=4)
	@show round(均值2,digits=4)
	@show round(标准差1,digits=4)
	@show round(标准差2,digits=4)

end
function test()
	@info "测试函数开始执行"
	上证="sh_finace.txt"
	深证="sz_finace.txt"
	
	统计两种价格(上证,4,5)  #????
	统计两种价格(深证,3,5)  #????
	
	@info "函数执行结束"
end
test()