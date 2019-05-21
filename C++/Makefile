#		 -g  调试选项
#		 -lpthread   多线程选项
#       -static ： 静态链接 
#       -shared -fpic：动态连接(默认)  适合大型项目
cc = g++ 
cc += -std=c++11
cc += -O2 
cc += -static

objects = main.o

#设置最终可执行文件名
project_name = 应用.out


$(project_name) : $(objects)
	@$(cc) -o  $(project_name) $(objects) 
	@echo 编译成功 !   !   !

main.o : main.cpp head.h
	@$(cc) -c  main.cpp
	@echo main.o编译完成

#cpointer.o : text_deal.h	#默认包含 cpointer.c
#	$(cc) -c text_deal.h 

.PHONY : clean  cla run
run :
	./$(project_name)
	@echo 项目运行完毕
clean :
	@rm -f *.o
	@echo 所有.o文件清理完毕
cla :
	@rm -f *.o
	@rm $(project_name)
	@echo  "所有编译文件清理完毕 \n  可以重新编译该项目"