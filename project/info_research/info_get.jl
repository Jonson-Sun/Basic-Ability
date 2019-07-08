
#     滚动新闻整理

#	对网络信息进行 自动 抓取,处理,分析,并生成报告


# 1. 下载,提取,归档
# 2. 
# 3.




#
#
#
#	对 功能1 的代码实现
#
#



function 空文件检测(文件名)
	if filesize(文件名)<10
		return true
	else
		return false
	end
end
function 下载信息(INFO_URL,文件名)
	出错次数=0
	try
		download(INFO_URL,文件名)
		if 空文件检测(文件名)
			throw("所下载文件为空!!!")
		end
	catch e
			@error "下载出错: $e"
	end
end


function 提取时间(item)
	pattern=r"\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}"
	m=match(pattern,item)
	result=m.match
	#@info result
	return result
end
function 提取link(item)
	pattern=r"http:.+?html"
	m=match(pattern,item)
	result=m.match
	#@info result
	return result
end
function 提取类型标签(item)
	pattern=r">\w{2}</a>\]"
	m=match(pattern,item)
	result=m.match
	#@info result[2:5]
	return result[2:5]
end
function 提取title(item)
	pattern=r"title=\".+?\""
	m=match(pattern,item)
	result=m.match
	result=result[7:end]
	if (',' in result)
		tmp=""
		for iter in result
			if iter ==','
				tmp=tmp*' '
			else
				tmp=tmp*iter
			end
		end
		result=tmp
	end
	#@info result[8:end-3]
	return result
end
function 内容提取(文件名)
	#正则表达式提取 "时间,标签,title"
	str_tmp=""
	str_vec=String[]
	[str_tmp=str_tmp*line for line in readlines(文件名)]
	@info "文本文件长度: $(length(str_tmp))"
	
	regex=r"<li>\s*?<span>.+?</li>?"
	context=[m.match for m=eachmatch(regex,str_tmp)]
	#@info  context[1],context[3] #?
	for item in context
		#@info "子项$(length(item))"
		time=提取时间(item)
		type_finace=提取类型标签(item)
		title=提取title(item)
		link=提取link(item)
		
		push!(str_vec,time*','*type_finace*','*title*','*link)
		#break
		#注意:应在保存前,检查 内部逗号 的存在
		@assert !(',' in time) "提取的 时间序列 中包含逗号"
		@assert !(',' in type_finace) "提取的 类型标签 中包含逗号!"
		@assert !(',' in title) "提取的 标题 中包含逗号!"   #这种情况还真出现了
		@assert !(',' in link) "提取的 链接 中包含逗号!"
	end
	return str_vec
end


function 每日归档(str_vec)
	归档内容="###归档分割标记==============\n"
	for term in str_vec
		归档内容=归档内容*term*"\n"
	end
	open("经济新闻.txt","a") do io
		write(io,归档内容)
	end
end


function test()
	下载地址="http://roll.eastmoney.com/"
	文件名="two.html"
	内容向量=String[]
	
	# 可以设置为半个小时执行一次
	# 如果长期运行出错:
	#	将下面的代码块 添加try..for.end  catch finally 每日归档
	
	for i=1:(60*3)  #采样次数
		下载信息(下载地址,文件名)
		str_vec=内容提取(文件名)
		#去除重复项
		#reverse和pushfirst 目的是保持内容的时间顺序
		for item in reverse(str_vec)
			if item in 内容向量 continue end
			pushfirst!(内容向量,item)
		end
		rm("文件名",force=true)
		@info "内容向量的长度为 $(length(内容向量))"
		@info "第$(i)次执行等待中 ..."
		sleep(120)  #采样间隔
	end
	每日归档(内容向量)
	
	#三小时,180次采样无差错
	@info "测试函数运行完成"
end
test()
