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




#======================================
			给markdown文件添加目录索引
起因：
		retext 软件没有[TOC]建立自动索引功能
======================================#
function startwith(head,line)
	#println(line[1],head,line[1]==head)
	if line[1] == head  #第一个字符相同
		return true
	else
		return false
	end
end
function sub_head(head_list,need2sub='#')
#使用数字替换掉所有的#
	count=1
	for line in head_list
		line=replace(line, need2sub => "- " )
		head_list[count]=line
		count+=1
	end
end
function 包装(head_list)
	local mark_count=1
	for line in head_list
		head_list[mark_count]="<a href=\"#chapter-$mark_count\">" * line  *  "</a>  \n"
		mark_count+=1
	end
	pushfirst!(head_list,"\n ---  \n ")
	pushfirst!(head_list,"目录：  ")
	push!(head_list,"\n ---    \n")
end
function add_index2markdown(Markdown_file)
	#给markdown文件按照头（#）添加目录索引
	mark_count=1  #标记#头的出现次数
	head_list=[]  #存储头内容
	new_str=""
	
	open(Markdown_file,"r+") do io
		for line in eachline(io)
			if length(line) < 2  #避免空行导致的bounderror
				continue
			end
			if startwith('#',line)
				push!(head_list,line)
				substr="<a id=\"chapter-$mark_count\"></a>    \n" 
				new_str *= substr  *   line * '\n'
				mark_count+=1
			else
				new_str *= line  * '\n'
			end
		end
		sub_head(head_list)
		包装(head_list)
	end
	open("tmp.txt","w") do io
		for line in reverse(head_list)
			println(line)
			new_str=line * new_str
		end
		#print(new_str)
		write(io,new_str)
	end
	println("markdown 文件添加目录（页内索引）完成。")
end
#Markdown_file="/home/asen/文档/笔记.md"
#add_index2markdown(Markdown_file)  #待优化




#============================================
			计算熵（Julia version）232s
============================================#
using PyPlot
function compute_entropy()
	dir_name="/media/asen/软件/PROJECT/pynlp/词向量/corpus.txt"
	word_freq_table=Dict{Char,UInt64}()   #时间缩短为57s
	Global_entropy,all_num=0,0
	
	@info "读取文件。。。"
	open(dir_name,"r") do F
		for line in eachline(F)   #去掉断行检查时间缩短为47s
			for word in line
				if word in keys(word_freq_table)
					word_freq_table[word]+=1
				else
					word_freq_table[word]=1
				end
			end
		end
	end
	word_num=length(word_freq_table)
	@show "词频表的长度为$word_num"
	all_num=sum(values(word_freq_table))  #sum 与for 性能相近
	
	println("all_num=$all_num 计算熵。。。")
	P =freq::UInt64 -> freq/all_num
	entropy= prob::Float64 -> -prob*log2(prob)
#=
	open("entropy_tmp.txt","w") do io
		for (k,v) in sort(collect(word_freq_table),by=x->x[2])
			val1=P(v)
			val2=entropy(val1)
			write(io,"$k \t freq  $v  \t 概率：$(val1)  \t 熵：$(val2)  \n")
			Global_entropy+=val2
		end
	end
=#
	@info Global_entropy
#=
	Global_entropy=sum(
	[entropy(P(i)) for i in values(word_freq_table)]) 
	 #表达方式更紧凑，没有性能提升
	println("the entropy is : ",Global_entropy)
	
	@info ("start plot ...")
	tmp=[P(i) for i in values(word_freq_table)]
	plot(tmp)
	show()
=#
end
#@time compute_entropy()

#字典按值排序的方法：sort(collect(dict),by=x->x[2])


module selfwrite
import Base.show
#export function name or type name 
#macro name  end

end







