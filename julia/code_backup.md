
# julia 代码备份

### 计算2^1000的按位 加和
![](pict/math_sum.png)
```Julia
function 指数(num::Int,init::Int=2)  #计算指数
	tmp::BigInt=init
    return tmp^num
end
function sum_bigInt()  #计算2^1000的位值加和
	function char2num(item::Char)
		table=Dict(['0'=>0,'1'=>1,'2'=>2,'3'=>3,'4'=>4,'5'=>5,
			'6'=>6,'7'=>7,'8'=>8,'9'=>9])
		if item in keys(table)
			return table[item]
		end
	end
	num::Int=0
	tmp_str=repr(指数(1000))
	for char in tmp_str
		num+=char2num(char)
	end
	@info "位数为:$(length(tmp_str))"
	@info "2^1000:加和的结果为 $num ."
	@info "每一位上的平均值为:$(num/length(tmp_str))"
	@show tmp_str
end
sum_bigInt()  #结果是1366
```
### 有序数据->无序数据

```julia
#
#	排序的逆向操作
#		有序数据->无序数据
#
function 交换(arr::Array,p1::Int,p2::Int)
	tmp::Int=arr[p1]
	arr[p1]=arr[p2]
	arr[p2]=tmp
end
function 打散数据!(arr::Array) #使用随机数 进行交换
	size=length(arr)
	系数=1
	#0.3  0.5	0.6		0.7   0.8  0.9  1  1.2  2
	#50  37		31		27	  21	15	10	10	3
	for i=1:Int(round(size*系数))
		交换(arr,rand(1:size),rand(1:size))
	end
	
end
function 打散数据2!(arr::Array)
	size=length(arr)
	系数=0.8
	for i=1:Int(round(size*系数))
		交换(arr,rand(1:size),rand(1:size))
	end
	
	tmp=arr[1]
	for i=1:(size-1)
		arr[i]=arr[i+1]
	end
	arr[size]=tmp
end
function 相似度检验(arr1::Array,arr2::Array)
	size1=length(arr1)
	size2=length(arr2)
	@assert size1==size2 "两个集合的项数不等."
	
	count::Int=0
	for i=1:size1
		if arr1[i]==arr2[i] count+=1 end
	end
	return round((count/size1),digits=4)
end
function test()
	arr::Array=[]
	arr_tmp::Array=[]
	
	for i=1:100000 push!(arr,i);push!(arr_tmp,i) end
	#@info arr[40:50]
	#打散数据!(arr)
	打散数据2!(arr)
	#@info arr[40:50]
	
	result=相似度检验(arr_tmp,arr)
	@info "两个数组的相似度为:$(result*100)%"
	
end
test()
```


"""
	寻找勾股数(整数): 3,4,5 .......
		a,b,c
		(1) a不变,b(区间遍历)  寻找c 
				限制:c^2<a^2+b^2
		(2) a+=1,重复(1)
		
"""
function 寻找勾股数(end_val::BigInt )   #无限大版本
	 a::BigInt=3;
	 b::BigInt=3;
	 c::BigInt=3;
	区间=100
	@info "计算勾股整数对 开始......"

	while a < end_val
		while b<(a+区间)
			while c< Int(  round(sqrt(a^2+b^2)+1)  )
				if c^2 ==(a^2+b^2) 
				#@info "$a 的平方$(a^2) +  $b  平方$(b^2)==$c 的平方$(c^2)"
					write(io,"$a,$b,$c \n ")
				end
				c+=1
			end
			b+=1
			c=b
		end
		a+=1
		b=a
		flush(io)
	end
	@info "计算结束!"
end
function 寻找勾股数(end_val::Int)
	 a=3;
	 b=3;
	 c=3;
	区间=100
	@info "计算勾股整数对 开始......"

	while a < end_val
		while b<(a+区间)
			while c< Int(  round(sqrt(a^2+b^2)+1)  )
				if c^2 ==(a^2+b^2) 
					write(io,"$a,$b,$c \n ")
				end
				c+=1
			end
			b+=1
			c=b
		end
		a+=1
		b=a
		rand(1:10)==7 ? flush(io) : continue ;#避免每次都flush,注意?:前后的空格
	end
	@info "计算结束!"

end

function 计算大指数(底数::Int,指数::Int) a::BigInt=底数;return a^指数 end

function test()
	
	num::BigInt=2^30 #计算大指数(2,100) ;
	#寻找勾股数(num)
	寻找勾股数(100_0000)
end

io=open("tmp1.txt","w+")  #io定义必须放在全局
@time test()
close(io)