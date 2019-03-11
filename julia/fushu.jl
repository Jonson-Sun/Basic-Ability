#附属julia.jl 文件
#=======================================
	一般来说，我喜欢在较好的语言里找缺点。在糟糕的语言里找优点。
julia 的缺点：
	1、无法想C++一样生成一个可执行文件（垃圾回收）
	2、不习惯使用 if end；for end
	3、 计数从1开始。英文句号的意思是逐元素调用方法
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
function compute_entropy()
	#dir_name="/home/asen/asd.txt"
	dir_name="/media/asen/软件/PROJECT/pynlp/词向量/corpus.txt"
	str_list=[]
	word_freq_table=Dict()
	Global_entropy,all_num=0,0
	
	println("读取文件。。。")
	open(dir_name,"r") do F
		for line in eachline(F)
			if length(line)<5
				continue
			end
			for word in line
				if word == ' '
				continue
				end
				if word in keys(word_freq_table)
					word_freq_table[word]+=1
				else
					word_freq_table[word]=1
				end
			end
		end
	end
	word_num=length(word_freq_table)
	println("词频表的长度为$word_num")
	for i in values(word_freq_table)
		all_num+=i
	end
	println("计算熵。。。")
	entropy=freq-> -(freq/all_num)*log2(freq/all_num)
	for freq_num in values(word_freq_table)
		Global_entropy+=entropy(freq_num)
	end
	println("the entropy is : ",Global_entropy)
end
@time compute_entropy()
