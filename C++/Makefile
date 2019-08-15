#		-g  调试选项
#		-w  关闭所有{warn}警告选项
#		-lpthread   多线程选项
#       -static ： 静态链接 : 文件会很大2.3m->9.1k
#       -shared -fpic：动态连接(默认)  适合大型项目
icon = /usr/share/icons/Humanity/apps/32/addressbook.svg


cc += -Wall  #打开所有的 warning 信息{Warn all}
#cc += -O2   #代码编译优化
cc =  g++
cc += -std=c++11
cc += -static   
cc += -I /home/asen/boost/include
cc += -L /home/asen/boost/lib 


#编译的后置选项
post_opt= 
#编译出的中间结果 *.o
objects = main.o head.o
#设置最终可执行文件名
project_name = app







$(project_name) : $(objects)
	@$(cc) -o  $(project_name) $(objects) 	$(post_opt)
	@notify-send -i "$(icon)" "[make] " "编译成功 !   !   !"
main.o : main.cpp
	@$(cc) -c  main.cpp

head.o :
	@$(cc) -c head.cpp
	
#中间结果的编译模板
#xxx.o : ssss.h	#默认包含 xxx.cpp
#	@$(cc) -c ssss.h 





#运行应用,清理无关项

.PHONY : clean  cla run
run :
	@./$(project_name)
	@notify-send -i "$(icon)" "[make run]" "项目运行完毕"
cl  :
	@rm -f *.o
	@notify-send -i "$(icon)" "[make cl]" .o文件清理完毕
cla :
	@rm -f *.o
	@rm $(project_name)
	@notify-send -i "$(icon)" "[make cla]" 清理完毕
# 
#将bash 输出转换 为 系统通知
#	notify-send -i $icon  "[标题:$USER]" " 消息:AAAAAAAAAA"
#	icon = /usr/share/icons/Humanity/apps/32/application-community.svg
#		   | addressbook.svg | clock.svg | bash.svg |user-info.svg
#