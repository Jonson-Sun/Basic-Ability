#设置编译器    调试-g
cc = g++ -std=c++11 -O2 -static

#设置中间文件名 所有的  *.o文件
objects = main.o

#设置最终可执行文件名
project_name = 应用.out

# -static ： 静态链接 -shared -fpic：动态连接

$(project_name) : $(objects)
	$(cc) -o  $(project_name) $(objects) # -lpthread

main.o : main.cpp head.h
	$(cc) -c  main.cpp

#cpointer.o : text_deal.h
#	$(cc) -c text_deal.h 

#example2.0 : example2.h
#	$(cc) -c example2.h

cl :
	rm -f *.o
	
cla :
	rm -f *.o
	rm $(project_name)
	
#rm edit $(objects)
