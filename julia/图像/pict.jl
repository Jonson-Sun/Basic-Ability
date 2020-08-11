
#
#	图像的几种滤镜,变换
# 1. 螺旋曲线转动
# 2.
# 3.


function 螺旋曲线(x::Int,y::Int,Matrix_pict)
	# 参数为: 旋转中心坐标,矩阵
	
end
function 反向螺旋曲线()

end



using PyPlot
function test()
	pict0 = imread("pict/原图.png")
	@show size(pict0) typeof(pict0) #(768, 1366, 3)  Array{Float32,3}
	
end
#test()

function 曲线()
	title("曲线")
	function 帽子(x) return(sqrt(Complex(1-x^2)),-sqrt(Complex(1-2x^2))) end
	function 圆(x) 
		a=sqrt(1-x^2)
		return (a,-a)
	end
	
	function 正弦(x)
		return sin(x)
	end
	function sd(x)
	
	end
	function ad(x)
	
	end
	function as(x)
	
	end
	
	plot(map(正弦,[i for i=-1:0.01:1]),"bo-")
	show()
end
曲线()




