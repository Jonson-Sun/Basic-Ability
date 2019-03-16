#附属julia.jl 文件
#=======================================
	一般来说，我喜欢在较好的语言里找缺点。在糟糕的语言里找优点。
julia 的缺点：
	1、无法像C++一样生成一个可执行文件（垃圾回收）
	2、不习惯使用 end
	3、计数从1开始。英文句号的意思是逐元素调用方法
	4、语言比较新,变化较多
=======================================#
function called_func_between_files()
	#本函数用于julia.jl进行跨文件函数调用
	println("the function was called in other files.")
end



















