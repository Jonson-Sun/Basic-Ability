#		-g  调试选项
#		-lpthread   多线程选项
#       -static ： 静态链接 
#       -shared -fpic：动态连接(默认)  适合大型项目

#cc += -g
#cc += -Wall  #打开 warning 信息
#cc += -O2 
cc =  g++
cc += -std=c++11
cc += -static
cc += -I /home/asen/boost/include
cc += -L /home/asen/boost/lib   
#使用boost_regex，并添加-lboost_regex，启用-lpthread
#coroutine2: -lboost_context


post_opt=   -lpthread  
objects = main.o



#设置最终可执行文件名
project_name = boost_app.out


$(project_name) : $(objects)
	@$(cc) -o  $(project_name) $(objects) 	$(post_opt)
	@echo [make]编译成功 !   !   !

main.o : main.cpp  boost_used.h
	@$(cc) -c  main.cpp

#xxx.o : ssss.h	#默认包含 xxx.c
#	$(cc) -c ssss.h 

.PHONY : clean  cla run
run :
	@./$(project_name)
	@echo [make run]项目运行完毕
cl  :
	@rm -f *.o
	@echo [make cl].o文件清理完毕
cla :
	@rm -f *.o
	@rm $(project_name)
	@echo [make cla]清理完毕

	
	