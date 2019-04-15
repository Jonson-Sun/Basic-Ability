# 创建  周期性的执行命令
#	类似 cron 的效果
# 本文件的执行命令: 
# 	nohup:输入输出重定向,忽略sigup信号,来创建进程
# >>> nohup julia nohup_order.jl > log.txt
import Dates.dayofweek
import Dates.Hour
import Dates.Minute
import Dates.now

function 时间对正(hour::Int,min::Int)
	整点=Hour(now())
	分钟=Minute(now())
	if (整点==hour)&&(分钟==min)
		return true  #到达指定时间
	else
		return false
	end
end
#=========================
	每周1-5执行: 股市信息采集
		上午,9:30
		下午,1:00
	110m的内存占用,得不偿失!
=======================#
function 股市信息采集()
	星期=dayofweek(now())
	if 0< 星期< 6
		while true
			if 时间对正(9,30)||时间对正(13,00)
				#run(`julia julia/股市/analyse.jl`)
				@info "执行;时间:$(now())"
			else
				@info "不执行;时间:$(now())"
			end 
			sleep(60)
		end
	end
end
股市信息采集()