#附属julia.jl 文件
#=======================================
	一般来说，我喜欢在较好的语言里找缺点。在糟糕的语言里找优点。
julia 的缺点：
	1、无法像C++一样生成一个可执行文件（垃圾回收）
	2、不习惯使用 end
	3、计数从1开始。英文句号的意思是逐元素调用方法
	4、语言比较新,变化较多
	
	All code is bad
=======================================#
function called_func_between_files()
	#本函数用于julia.jl进行跨文件函数调用
	println("the function was called in other files.")
end


#========================================
	网页内容-> 可分析的文本数据 
		
=====================================#
import Base.Iterators.Stateful
import Base.Filesystem.filesize
import Base.Filesystem.walkdir
import Base.Filesystem.rm

#
#获取网页：
#	方式：curl、wget、Base.download(url,name)
#	功能：通过本地存储的url文件；下载网页
#
function get_PathName_from_dir(dir_name)
	#目录名->iter(file_name)
	#walkdir :是深度优先搜索
	filename_list=[]
	function get_filename(dir_one)
		for (root,dirs,files) in walkdir(dir_one)
			for file in files
				push!(filename_list,(root*'/'*file) )
			end
		end
	end
	get_filename(dir_name)
	return Stateful(filename_list)
end
function get_url_from_file(filename)
	#文件内容格式：每行：name！link？other
	NameUrl=Dict()
	for line in eachline(filename)
		name,url,other=split(line,['!','?'])
		NameUrl[name]=url
	end
	return Stateful(collect(NameUrl) )
end
function get_context_from_net()
	dir_name="tmp/"
	for file_name in get_PathName_from_dir("Baidu")
		for (name,url) in get_url_from_file(file_name)
			try
				download(url,dir_name*name*".html")
			catch 
				continue
			end
		end
		break
	end  
	println("文件下载完成")
end
function rm_null_file()
	#去掉空文件
	dir_name="htmlfile/"
	count::Int64=0
	for file_name in readdir(dir_name)  #默认是本目录
		if filesize(dir_name*file_name) < 10
			rm(dir_name*file_name)
			count+=1
		end
	end
	@info "空文件的数量为： $count ;\n "
end



#=========================================
网页内容:分类提取：
	类别：超链接，文本，图像<img>，其他
	class:1」    2」    3」       4」
======================================#
function get_context_from_html!(file_name,url_list,Pattern,class)
  #change place ： url_list
  	tmp=""
  try
	for line in eachline(file_name)
		if occursin(Pattern,line)
			m=match(Pattern,line)
		  	tmp=m.match
		    if class==1 && length(tmp)>10
		    	#push!(url_list,tmp[7:end-1])
		    	#StringIndexError :变长编码索引困难
		    	push!(url_list,tmp[7:prevind(tmp,lastindex(tmp))])
		    elseif class==2 
		    	push!(url_list,tmp)  #暂时如此
		    elseif class==3 && length(tmp) > 50
		    	push!(url_list,tmp[2:prevind(tmp,lastindex(tmp))])
		    end
			#println(m.match) #查看匹配的内容
		end
	end
  catch e
	println(tmp,length(tmp))
	throw(e)
  end
	return url_list
end
#==================================
	构建网络上的多级链接跳转
		1、func：link ->link
		2、
===============================#
function deal_html(dir_name="htmlfile/")
  #正则表达式模式定义
	#Pattern=r"<img.+?>"  #匹配<a></a>
	#Pattern=r"href=\"https?.+?\""  #匹配  href=“https：”
	Pattern=r">[^<a-zA-Z]+?[^>]<"  #文本

  	result_file="link_palace.txt"

	url_list=Array{String,1}()


		if count%100==1 println(fileName) end
		count+=1
		get_context_from_html!(fileName,url_list,Pattern,class)
#=
  @info "结果存入文件"
	open(result_file,"w") do io
  		for node in url_list
  			write(io,node*'\n')
  		end
	end
	@info "deal_html runing is end! $count"
=#
end
@time deal_html()

#get_context_from_net()
#rm_null_file()