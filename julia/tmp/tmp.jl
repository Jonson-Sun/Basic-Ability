# 本文件为Julia程序设计预言源文件 

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
	filename="old.txt"
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
		if occursin(".chinaneast.",url) continue end
		if occursin("gmw",url) continue end
		#if occursin("gzpp",url) continue end
		#if occursin("gzpp",url) continue end
		#if occursin("weibo",url) continue end
		
		
		str=str*url*'\n'
	end
	io=open("old1.txt","w")
	write(io,str)
	close(io)
	@info "url过滤完毕"
end
#filter_url()
