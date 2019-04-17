# 本文件为Julia程序设计语言源文件 

#网页冲浪
function firefox_url(文件名)
	count=1
	for url in eachline(文件名)
		if startswith(url,"http")&&(length(url)>7)
			run(`firefox -new-tab $(url)`,wait=false) 
			#wait=false设置异步执行
			@info "成功打开第$(count)个链接."
			sleep(3)
		end
		if count>200 break end
		count+=1
	end
	@info "程序执行结束!"
end

#firefox_url("old.txt")

function filter_url()
	#过滤掉冗余的url  : 千龙网,北方网...
	str=""
	filename="tmp.txt"
	for url in eachline(filename)
		if occursin("cri",url) continue end
		if occursin("qq",url) continue end
		if occursin("wenming",url) continue end
		if occursin("southcn",url) continue end
		if occursin("mozilla",url) continue end
		if occursin("twitter",url) continue end
		if occursin("onlinedown",url) continue end
		if occursin("qianlong",url) continue end
		if occursin("weibo",url) continue end
		if occursin("enorth",url) continue end
		if occursin("faxie",url) continue end
		if occursin("nxtv",url) continue end
		if occursin("tv1958",url) continue end
		if occursin("eastday",url) continue end
		if occursin("zol",url) continue end
		if occursin("google",url) continue end
		if occursin("migu",url) continue end
		if occursin("cctv",url) continue end
		if occursin("hinews",url) continue end
		if occursin("gywtb",url) continue end
		if occursin("press",url) continue end
		if occursin("piyao",url) continue end
		if occursin("taobao",url) continue end
		if occursin("piyao",url) continue end
		if occursin("suning",url) continue end
		if occursin("cnr",url) continue end
		if occursin("gzpp",url) continue end
		if occursin("cssn",url) continue end
		if occursin(".cndfilm",url) continue end
		if occursin("sxpmg",url) continue end
		if occursin("cas.cn",url) continue end
		if occursin("gmw",url) continue end
		if occursin("china",url) continue end
		if occursin("people",url) continue end
		if occursin("xinhua",url) continue end
		if occursin("gwytb",url) continue end
		if occursin("gov.cn",url) continue end
		if occursin("sina",url) continue end
		if occursin("toutiao",url) continue end
		if occursin("legaldaily",url) continue end
		if occursin("ce.cn",url) continue end
		if occursin("12377",url) continue end
		if occursin("gzpg.com",url) continue end
		if occursin("cefc.co",url) continue end
		if occursin("cdpf.org",url) continue end
		if occursin("anhuinews",url) continue end
		if occursin("jcrb",url) continue end
		if occursin("bjjubao",url) continue end
		if occursin("dmcc",url) continue end
		if occursin("baidu",url) continue end
		if occursin("downza",url) continue end
		
		
		
		str=str*url*'\n'
	end
	io=open("old1.txt","w")
	write(io,str)
	close(io)
	@info "url过滤完毕"
end
filter_url()

#==========================================

	去除同一网站的url:
		1.将url排序,前后比较
		2.过滤出"//.../"间的部分,放入集合
======================================#



# utf-8变长编码-> 可直接索引的[]存储?
# 使用方式:
#	substr("阿三科技的符号i阿斯顿飞呢",3,-2)
#	substr("阿三科技的符号i阿斯顿飞呢",3,7)
	
function substr(str::String,start_idx::Int,end_idx::Int)
	#半开半闭区间[start,end) 没法表示索引到结尾
	#使用[start,end] 更附和julia的原则:从1开始
	if end_idx >length(str) @error "BoundsError 索引越界";return end
	char_list=[];
	tmp=""
	
	for item in str		push!(char_list,item)	end
	if end_idx<0 	end_idx=(length(char_list)+end_idx+1) end
	if start_idx>end_idx	return "" end   #排除错误参数
	for item in char_list[start_idx:end_idx]
		tmp=tmp*item
	end
	#@info "$(tmp)"
	return tmp
end

#========第一种方法: 比较开始元素的相似性======

function 相似性检验(url_1,url_2)
	#检查两个url是否有相同的开头->Bool
	#用不了索引真的很麻烦!!!{无法截取前20来进行比较}
	if substr(url1,1,20)==sub(url_2,1,20)  #仍需检验是否越界
		return true
	else
		return false
	end
end
function filter_url(filename)  #功能1的实现
	list_url=[]
	prev_url,after_url="",""
	str=""
	
	for line in eachline(filename)
		push!(list_url,line)
	end
	sort!(list_url)
	for line in list_url
		after_url=line;
		if prev_url=="" prev_url=after_url;continue;end
		if 相似性检测(prev_url,after_url)
			continue
		else
			str=str*prev_url*'\n'
			prev_url=after_url
		end 
	end
	open("tmp_"*filename,'w') do io
		write(io,str)
	end
	@info "url筛选完毕:function 1"
end

#  ============ 第二种 : 筛选方法 =========

function 提取主站(url::String)
	pattern=r"//.+?/"  #非贪婪模式匹配
	m=match(pattern,url)  #match(p,url).captures???
	#return m.match 
	if typeof(m)==Nothing return url; end
	return SubString(m.match,3)
end
function 提取主站_2(url::String)
	arr=split(url,'/')
	if length(arr)<3
		return ""
	else
		return arr[3] 
	end
end

function filter_url_2(filename)  #功能2实现
	url_set=Set()
	str=""
	
	for line in eachline(filename)
		push!(url_set,提取主站(line))
	end
	for line in url_set
		str=str*line*'\n'
	end
	open("tmp_"*filename,"w") do io
		write(io,str)
	end
	@info "url筛选完毕:function 2"
end
#filter_url_2("link_palace.txt")
#===========================================
	文学网站分析与内容提取
		1.下载网页信息,识别404
			<title>404错误</title>
			http://www.dolphin-books.com.cn/main/20005_2.html
		2.提取网页中的文本内容
		3.其他:
			大约3万个网页,
			格式:书籍编号_章节(2...)
========================================#