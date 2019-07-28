
#


#鸡与蛋

先有的鸡还是先有的蛋,谁知道呢?
反正,不下蛋的鸡被吃掉了;不孵鸡的蛋也被吃掉了.

---

---	


# C++笔记

- 大部分的操作符是可以被重载的，例外的只有“.”、“::”、“?:”和“sizeof”
- 指针即为 间接寻址
- 宏定义的坏处: 没有强类型
- 泛型:类型参数化;
- 类有运行时调度(纵向扩展),泛型是编译时操作,(横向扩展)


## 其他
- 类可以帮助你组织代码和分析程序
- OOP 的意思是利用类层级（class hierarchies）及虚函数进行编程
- 如果你的问题的基本要素中没有与生俱来的层级关系，那么类层级和虚函数对你的代码不会有任何帮助
- 避免不安全的C++代码:
	- 不使用类型转换
	- 不用数组做接口
	- 避免void* 
	- 避免联合体
	- 不放心的指针,使用智能指针
	- 不要"赤裸裸"使用new delete.
	- 不要使用...风格的函数:printf等
- 成功的软件都是长寿的；数十年生命周期的软件并不少见
- 一个优秀的软件的寿命会比提供构造这个软件的基本技术的公司的寿命还要长
- 
## Boost
 Boris Schäling(2008-2010)
 
---
如何使用boost库
-L -static: 包含lib下的文件
-I /home/xzz/boost_1_56_0/include :包含头文件
---

- std::auto_ptr: 
	- 	 RAII ：资源申请即初始化
	- 	 在拷贝的时候传递了所有权(no copy op) ,所以不要放到容器中
	- 	 shared_ptr:用于容器
- 函数对象:
	- 可能称为'高阶函数'更为适合
	- boost::bind() 的参数是以值方式传递的,boost:ref,boost:cref;[常量引用]
	- boost:function:函数指针
	- boost:lambda
- 事件处理
	- boost:signal  类似qt的信号插槽
- 字符串处理
	- 尽管 std::string 囊括了百余函数，是标准 C++ 中最为臃肿的类之一，然而却并不能满足很多开发者在日常工作中的需要
	- boost:StringAlgorithms;#include \<boost/algorithm/string.hpp\>
	- starts_with,split(),串格式化
	- std::locale::global(std::locale("German"));
	- boost/regex.hpp:正则表达式,为能够使用unicode/icu,安装libicu等软件包
- 线程
	- boost:thread:感觉跟std:thread
- 异步IO:
	- boost:Asio主要被用于网络编程
	- 虽然 Boost.Asio 也可以用来在同一台计算机的应用程序间交换数据，但是使用 Boost.Interprocess 库通常性能更好
	- 共享内存通常是进程间通讯最快的形式:boost/interprocess/managed_shared_memory.hpp
	-  对于不同的互斥对象，可以使用不同的具有RAII概念的锁类
- 文件系统
	- 库 Boost.Filesystem 简化了处理文件和目录的工作
	- boost::filesystem::path 的类，可以对路径进行处理
	- file_size,boost/filesystem/fstream.hpp文件流
- 时间日期处理
	- 库 Boost.DateTime 可用于处理时间数据，如历法日期和时间
	- Boost.DateTime 只支持基于格里历的历法日期
	- boost::posix_time::ptime 则用于定义一个位置无关的时间
	-  boost::local_time::posix_time_zone 来保存时区信息
	-  boost::date_time::date_facet 和 boost::date_time::time_facet 类来格式化历法日期和时间。
- 序列化
	- Boost.Serialization 的主要概念是归档。 归档的文件是相当于序列化的 C++ 对象的一个字节流:boost/archive/text_oarchive.hpp||boost/archive/text_iarchive.hpp
	- boost/serialization/string.hpp :专用
	- 由于指针存储对象的地址，序列化对象的地址没有什么意义，而是在序列化指针和引用时，对象的引用被自动地序列化
	- boost::serialization::make_array () 优化封装
- 词法分词器: boost/spirit.hpp
	- Boost.Spirit 可以使用一种被称为扩展BNF范式的东西来表示规则
	- Boost.Spirit 的基本思想类似于正则表达式
	- Boost.Spirit 支持扩展BNF范式(EBNF)，可以用比 BNF 更简短的方式来指定规则
- 容器
	- C++11已基本包含:array;Unordered;bimap
	- Boost.MultiIndex 让我们可以自定义新的容器
- 数据结构
	- boost::any 类型的变量使用起来就像弱类型语言中的变量一样灵活
	-  boost::tuple 就扩展了 C++ 的数据类型 std::pair 用以储存多个而不只是两个值。 
	-  boost::variant 类型的变量可以储存一些预定义的数据类型， 就像我们用 union 时候一样。
- 异常处理
	- 异常被通常用来标示出未预期的异常情况
	- Boost.System 是一个定义了四个类的小型库，用以识别错误。 boost::system::error_code 是一个最基本的类，
	- Boost.Exception 库提供了一个新的异常类 boost::exception 允许给一个抛出的异常添加信息
- 类型转换
	- C++标准定义了四种类型转换操作符: static_cast, dynamic_cast, const_cast 和 reinterpret_cast。 Boost.Conversion 和 Boost.NumericConversion 这两个库特别为某些类型转换定义了额外的类型转换操作符
	- boost::polymorphic_cast 和 boost::polymorphic_downcast 是为了使原来用 dynamic_cast 实现的类型转换更加具体
	- Boost.NumericConversion 可将一种数值类型转换为不同的数值类型。 在C++里, 这种转换可以隐式地发生

---













