#!/home/asen/julia110/bin/julia
function called_func_between_files()
	#本函数用于julia.jl进行跨文件函数调用
	println("本文件(fushu.jl)开始执行")
end
called_func_between_files()


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



using PyPlot
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
粮食产量()
