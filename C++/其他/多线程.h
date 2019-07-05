
//���̣߳�
// �������ݵĹ����Լ��̼߳��ͨ�ţ��Ƕ��̱߳�̵��������
//detach��ʽ���������߳������ں�̨���У���ǰ�Ĵ����������ִ�У����ȴ����߳̽�����ǰ�������ʹ�õľ������ַ�ʽ��
//join��ʽ���ȴ��������߳���ɣ��Ż��������ִ�С�����ǰ��Ĵ���ʹ�����ַ�ʽ��������ͻ�0,1,2,3����Ϊÿ�ζ���ǰһ���߳��������˲Ż������һ��ѭ����������һ�����̡߳�
//Ĭ�ϵĻὫ���ݵĲ����Կ����ķ�ʽ���Ƶ��߳̿ռ䣬��ʹ����������������

#include<iostream>
using namespace std;
#include<thread>   //make�ļ���� -lpthread
//#include<unistd.h>  //sleep����
#include<mutex>
#include<future>  //async future
#include<string>
#include<assert.h>
void sent_value(int i){
	//sleep(i);  //ÿһ���ӳ���ĺ�ʱ��ͬ�� ˳�򴴽����̣߳�˳�������
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
	return tmp;  //���̵߳� ����ֵ�ش�
}


void multi_readfile()
{
	long big_num = 9999999999;
	int run = 4;
	if (run == 1){
		//������ ����ʹ�÷�ʽ
		for (int i = 0; i<10; i++){
			//thread t_obj{sent_value , i};
			thread t_obj{ sum_all, big_num };
			cout << "�̵߳�idΪ��" << t_obj.get_id() << endl;
			cout << "Ӳ�������ģ�" << t_obj.hardware_concurrency() << endl;  //4  ����������
			//t_obj.detach();  //����ִ��  id ��ͬ
			if (t_obj.joinable())	t_obj.join();   //˳��ִ�� �̵߳�id��ͬ
		}
	}

	if (run == 2){
		//����� �ļ�������ʽ
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
		//���� ������Դʹ��
		mutex streamlock;
		//ifstream txt("data/foursign.txt");
		for (int i = 0; i<4; i++){
			//thread t0(txt_deal,3);
			thread t0(sum_all, big_num);   //���߳��ĺ�cpuȫ��ռ����
			t0.detach();
		}
	}
	//atomic<int> asd(0);  //ʹ��ʱ������� ��������
	if (run == 4){
		//async �ĳ���̶����
		future<long> fut = async(sum_all, big_num);  //Ϊʲôֻʹ����һ�����ģ�
		auto fut1 = async(sum_all, big_num);
		auto fut2 = async(sum_all, big_num);
		async(sum_all, big_num - 10009);
		long max_num = fut.get() + fut1.get() + fut2.get();  //futֻ�ܽ���һ������ֵ
		cout << "�Ӻ͵Ľ��Ϊ��" << max_num << endl;

	}
}

//ʹ��datech ����ʵ�������Ķ�˲���
//async �� join���ǵ���ִ��:linux
//windows�£�async����Ĳ���
//async ���߳���ʹ��������Զ����ơ�
//�������ù����ڴ����ģʽ��

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



