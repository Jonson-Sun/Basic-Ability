
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
	long big_num = 9999999999;
	int run = 4;
	if (run == 1){
		//单参数 基本使用方式
		for (int i = 0; i<10; i++){
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
		for (int i = 0; i<4; i++){
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

//使用datech 可以实现真正的多核并行
//async 和 join都是单核执行:linux
//windows下：async多核心并行
//async 的线程数使用自身的自动控制。
//尽量少用共享内存的锁模式。

class A
{public:
	A()
	{
		cout << "base construct()" << endl;
	}
	~A()
	{
		cout << "base destruct" << endl;
	}
	void cai()
	{
		cout << "base cai()" << endl;
	}
	void kai()
	{
		cout << "base kai()" << endl;
	}
};

class B : public A
{
public:
	B()
	{
		cout << "construct() B" << endl;
	}
	~B()
	{
		cout << "destruct() B" << endl;
	}
	void cai()
	{
		cout << "cai()  B" << endl;
	}
	void kai()
	{
		cout << "kai()  B" << endl;
	}
};

void test_class()
{
	A*  asd = new B();
	asd->cai();
	asd->kai();
	asd->~A();
}



