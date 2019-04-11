
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
### 
