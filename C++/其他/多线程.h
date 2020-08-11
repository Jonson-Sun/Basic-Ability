
//多线程：
// 共享数据的管理以及线程间的通信，是多线程编程的两大核心
//detach方式，启动的线程自主在后台运行，当前的代码继续往下执行，不等待新线程结束。前面代码所使用的就是这种方式。
//join方式，等待启动的线程完成，才会继续往下执行。假如前面的代码使用这种方式，其输出就会0,1,2,3，因为每次都是前一个线程输出完成了才会进行下一个循环，启动下一个新线程。
//默认的会将传递的参数以拷贝的方式复制到线程空间，即使参数的类型是引用

#include<iostream>
using namespace std;
#include<thread>   //make文件添加 -lpthread
//#include<unistd.h>  //sleep函数
#include<mutex>
#include<future>  //async future
#include<string>
#include<assert.h>
void sent_value(int i){
	//sleep(i);  //每一个子程序的耗时相同则 顺序创建的线程，顺序结束。
	cout << "sent value from main " << i << endl;
}
void text_read(string txt, int&  count){
	//ifstream txt_file(txt);
	//assert(txt_file.is_open() == true);
	for (int i = 0; i<count; i++){
		char out_tmp[1000];
		//txt_file.getline(out_tmp, 1000);
		cout << out_tmp << endl;
	}
	count++;
}
void txt_deal(int count){

	//streamlock.lock();

	//streamlock.unlock();
}
long sum_all(long end){
	long tmp = 0;
	for (long i = 0; i < end; i++){
		tmp += i;
	}
	cout << "sum_all" << tmp << endl;
	return tmp;  //多线程的 函数值回传
}


void multi_readfile()
{
	long big_num = 999999999;
	int run = 1;
	if (run == 1){
		//单参数 基本使用方式
		for (int i = 0; i<100; i++){
			//thread t_obj{sent_value , i};
			thread t_obj{ sum_all, big_num };
			cout << "线程的id为：" << t_obj.get_id() << endl;
			cout << "硬件上下文：" << t_obj.hardware_concurrency() << endl;  //4  核心数？？
			//t_obj.detach();  //乱序执行  id 不同
			if (t_obj.joinable())	t_obj.join();   //顺序执行 线程的id相同
		}
	}

	if (run == 2){
		//多参数 文件操作方式
		string need_open[] = { "data/foursign.txt", "data/result.txt" };
		int count = 4;
		for (string filename : need_open){
			thread t_text{ text_read, filename, ref(count) };
			t_text.join();
			cout << count << endl;
			count = 2;
		}
	}

	if (run == 3){
		//加锁 互斥资源使用
		mutex streamlock;
		//ifstream txt("data/foursign.txt");
		for (int i = 0; i<14; i++){
			//thread t0(txt_deal,3);
			thread t0(sum_all, big_num);   //四线程四核cpu全部占满。
			t0.detach();
		}
	}
	//atomic<int> asd(0);  //使用时无需加锁 单个数据
	if (run == 4){
		//async 的抽象程度最高
		future<long> fut = async(sum_all, big_num);  //为什么只使用了一个核心？
		auto fut1 = async(sum_all, big_num);
		auto fut2 = async(sum_all, big_num);
		async(sum_all, big_num - 10009);
		long max_num = fut.get() + fut1.get() + fut2.get();  //fut只能接受一个返回值
		cout << "加和的结果为：" << max_num << endl;

	}
}

//如何让程序跑得更快(运行时间更短)
	//1.优化算法减少不必要的计算
	//2.用空间换时间
	//3.多进程
	//4.多线程

//使用datech 可以实现真正的多核并行
//async 和 join都是单核执行:linux
//windows下：async多核心并行
//async 的线程数使用自身的自动控制。
//尽量少用共享内存的锁模式。


//深入理解并行编程.pdf

//大量的线程可能会带来大量计算和I/O操作。
/*
- 最有效的并行算法和系统，专注于资源并行算法
	工作分割绝对是并行计算需要的
	第一个并行访问控制问题是访问特定的资源是否受限于资源的位置
		其他的并行访问控制问题是线程如何协调访问资源
	资源分割非常有效，但是随着带来的复杂数据结构也非常有挑战性
	硬件交互通常是操作系统的核心
- I/O操作对性能的影响远远大于之前提到的各种障碍
- 趁手的工具——该如何选择？根据经验定律，应该在能完成工作的工具中选择最简单的一个。
	如果可以，尽量串行编程。
	如果这还不够，那么使用shell脚本来实现并行化。
	如果shell脚本的fork()/exec()开销（在Intel双核笔记本中最简单的C程序需要大概480毫秒）太大，那么使用C语言的fork()和wait()原语。
	如果这些原语的开销也太大（最小的子进程也需要80毫秒），
	那么你可能需要用POSIX线程库原语，选择合适的加锁、解锁原语和/或者原子操作。
	如果POSIX线程库原语的开销仍然太大（一般低于毫秒级），那么就需要使用第8章介绍的原语了。
永远记住，进程内的通信和消息传递总是比共享内存的多线程执行要好。

- 原子自增的性能随着CPU和线程个数的增加而下降
- 性能增加是花费如此多时间和精力进行并行化的主要原因
- 并行程序比相同的顺序执行程序复杂
	因为并行程序要比顺序执行程序维护更多状态
- 并行化只是众多优化中的一种，并且只是一种主要应用于CPU是瓶颈的优化
- 如果程序只有一个共享资源，那么代码锁的性能是最优的
	- 代码锁尤其容易引起“锁竞争”
- 数据锁通过将一块过大的临界区分散到各个小的临界区来减少锁竞争
- 数据所有权方法按照线程或者CPU的个数分割数据结构
- 在许多情况，绝大部分开销只由一小部分代码产生
	- 细粒度的设计一般要比粗粒度的设计复杂
- 所有美好的故事都需要一个坏人，锁在研究文献中扮演坏小子的角色已经有着悠久而光荣的历史了。
- 延迟处理
- 和读写锁一样，RCU的性能优势主要来源于较短的临界区
- 仅仅在两个CPUs之间或者CPU与设备之间需要交互时，才需要内存屏障
- 原子操作的实现通常在它们的定义中包含了必要的内存屏障
- 一个忠告：使用原始的内存屏障应当是最后的选择。使用已经处理了内存屏障的已有原语是更好的选择
- 除了最简单的并行程序外，其他所有并行程序都需要同步原语
- 读代码是比写代码更重要的学习方法
- 由于内存乱序以允许更好的性能，在某些情况下，需要内存屏障以强制保证内存顺序
- 现代CPU的速度比现代内存的速度快得多
- 一知半解是非常有害的
- 深入理解并行编程E.形式验证并行算法难于编写，甚至难于调试。测试虽然是必要的，但是往往还不够
- 
- 
- 
- 
- 
*/
