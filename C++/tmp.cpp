
#ifndef TMP_CPP
#define TMP_CPP

//时间：2019-4-24

//作者：Sun Jonson
#include<iostream>
using namespace std;
#include<sstream> //stringstream
#include<string>

//
//	C++读取utf-8文件
//
#include<vector>
struct utf8
{
	queue<char> byte_queue; //从文件读取的字节队列
	vector<int> word_vec; //存储每个文字的值
	int byte_len;  // 1,2,3,4  应读取的字节数
	
	iterator file2iter(string file_name) //文件名->字迭代
	{
	
	}
	

};

string itos(int i)	// convert int to string
{
	stringstream s;
	s << i;
	return s.str();
}

void test() //不再头文件中声明一样可以调用;表明include是一个装入过程
{
	cout<<"测试函数开始执行"<<endl;
	string tmp=itos(72);
	cout<<tmp<<endl;
	cout<<"int的字节数为"<<sizeof(int)<<";char="<<sizeof(char)<<endl;
}


#endif
