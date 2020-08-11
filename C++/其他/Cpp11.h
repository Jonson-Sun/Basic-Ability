/*
	学习C++ 11 
		2017-10-7 晚 宿舍
		
		本文件用于不清楚的语法细节验证
		及相关第三方库的练习使用
*/
//算法比计算或者数据可用性更重要。
/*
	std::transform  ->map()
	std::copy_if()  ->filter()
	std::accumulate  ->reduce()
	
	 错误：程序中有游离的‘\274’
	 	原因：存在中文标点符号
	
*/

#include<fstream>
#include<string>

#include"lib/utf8.h"


void test_profile() //性能测试
{
	long last_num=100000000;
	double tmp=1.0;
	for(int i=1;i <=last_num;i++)
	{
	 	tmp+=i;tmp*=i;tmp/=i;
	}
	cout<< "result is  : "<<tmp<<endl;
}



void test1()
{
	/*UTF-8编码问题
	wstring str = L"我是中国人。";
	wcout.imbue(locale("chs"));
	wcout << str[0] << str[3] << endl;
	wcout << str << endl;*/

	//使用utf-8
	string astr = "我早已为你种下九百99duo玫瑰，SAASDas";  
	string wei = "为";
	string nine = "9";

	string str1;
	ifstream foursign;
	foursign.open("foursign.txt");
	if (foursign.is_open()){
		cout << "四签名文件已打开。" << endl;
		getline(foursign, str1);
	}
	foursign.close();
	ofstream tmp("tmplog.txt");
	//tmp.write(sentence);
	tmp.close();
	std::vector<string> sentence;
	//astr = str1;

	getCharactersFromString(astr,sentence);
	for (int i = 0; i < sentence.size(); i++){
		cout << sentence[i]<<"-";
		if (sentence[i] == wei){ cout << "\n I find it.yeah!"; }
	}
	cout <<"串长度"<< getUTF8StringLength(astr)<<endl;
	getCharactersFromUTF8String(astr, sentence);
	for (int i = 0; i < sentence.size(); i++){
		cout << " : " << sentence[i]<<endl;
		if (sentence[i] == wei){ cout << "\n I find it.yeah!"; }
	}
	cout << normalize_to_lowerwithdigit(astr) << endl;
	cout << "字类型："<< wordtype(astr) << endl;
	cout << "字符类型："<< getUTF8CharType(nine) << endl;
	cout << "是utf8类型？" << isOneUTF8Character(nine) << endl;
	cout <<"尾字符："<< getLastCharFromUTF8String(astr) << endl;//注释掉第二个return s；即可得到正确结果
	cout << "首字符：" << getFirstCharFromUTF8String(astr) << endl;
	

	//函数对象  class 换位struct不行
	class funcobj
	{
	public:
		bool operator()() const
		{
			cout << "函数对象调用成功。\n"<<endl;
			return true;
		}
	};
	funcobj jonson;
	jonson();
}

#include<assert.h>
#include<iostream>
#include<functional>
using namespace std;
void learn1()
{
//自动类型推断
	auto shu = 123454;
	cout << "auto type is :" << shu << endl;
//空指针
	int* pot = nullptr;
	if (pot == NULL) cout << "point is null.";
	else cout << "nullptr is not NULL.";
//强类型枚举
	enum class options {none,one,two,all};
	options you = options::one;
	options me = options::all;
	if (you == me){
		cout << "\n咱俩一样。";
	}
	else{
		cout << "\n咱俩不一样哦。";
	}
//lambda 匿名函数
	auto lambda = [](int x, int y){return x + y; };
	cout << "\nlambda(3,4) = " << lambda(3, 4) << endl;
	function<int(int, int)> lambda1 = [](int x, int y){return x + y; };
	cout << "lambda1(3,4) = " << lambda1(3, 4) << endl;
//引用的和传值 效果
	int i = 3;
	int j = 4;
	function<int(void)> f = [i, &j]{return i + j; };
	i = 20, j = 50;
	cout << "f(i,&j) = " << f() << endl;  //53 
//初始化
	int n = [](int x, int y){return x + y; }(3,4);
	cout << "lambda exp n is : " << n << endl;
//nested 嵌套
	int twoplusthree = [](int x){return [](int y){return y * 2; }(x)+3; }(5);
	cout << "twoplusthree is: " << twoplusthree << endl;  //结果：13 5初始化的x，x初始化的y。y==5，返回5*2，在返回5*2+3.=13  传入的是括号里的值
	//for(;;[](){}) 正则表达式用在这里
//静态断言
	static const int size = 1;
	static_assert(size < 10, "size is wrong!");
//随机数
	//std::random_device rd;
}
#include<cmath>
void c_fundemental()
{
	//c 的基础语法
	cout<<"+ -0的表示："<<0<<' '<<-0<<endl;
	int i=-20;
	unsigned j=10;
	cout<<"(int)-20+(unsigned)10="<<i+j<<endl;
	
	typedef struct{//int,char,long:16byte;int,long,char:24byte;
		char c;
		int a;
		long b;
	}A;
	union B {int a;long b;char c;};
	enum  C {apple,pear,banana,peach};
	cout<<"int is     "<<sizeof(int)<<"byte"<<endl;
	cout<<"unsigned is"<<sizeof(unsigned)<<"byte"<<endl;
	cout<<"long is    "<<sizeof(long)<<"byte"<<endl;
	cout<<"short is   "<<sizeof(short)<<"byte"<<endl;
	cout<<"char is    "<<sizeof(char)<<"byte"<<endl;
	cout<<"double is  "<<sizeof(double)<<"byte"<<endl;
	cout<<"float is   "<<sizeof(float)<<"byte"<<endl;
	cout<<"struct is  "<<sizeof(A)<<"byte"<<endl;
	cout<<"union is   "<<sizeof(B)<<"byte"<<endl;
	cout<<"enum is    "<<sizeof(C)<<"byte"<<endl;
	cout<<"int* is    "<<sizeof(int*)<<"byte"<<endl;
	cout<<"long* is   "<<sizeof(long*)<<"byte"<<endl;
	cout<<"short* is  "<<sizeof(short*)<<"byte"<<endl;
	cout<<"float* is  "<<sizeof(float*)<<"byte"<<endl;
	cout<<"double* is "<<sizeof(double*)<<"byte"<<endl;
	cout<<"char* is   "<<sizeof(char*)<<"byte"<<endl;
	cout<<"unsigned is"<<sizeof(unsigned*)<<"byte"<<endl;
	cout<<"struct* is "<<sizeof(A*)<<"byte"<<endl;
	cout<<"void* is   "<<sizeof(void*)<<endl;
	//64位操作系统，指针都是8位。与类型无关。void 代表任意类型。
	
	//2^64=1844亿亿，2^32=42,9496,7296~42亿。2^16=65536,2^8=256,
	cout<<"2^8 ="<<pow(2,8)<<endl;
	cout<<"2^16="<<pow(2,16)<<endl;
	cout<<"2^32="<<pow(2,32)<<endl;//4G 40亿
	cout<<"2^64="<<pow(2,64)<<endl;
	cout<<"2^10="<<pow(2,10)<<endl;
	cout<<"2^20="<<pow(2,20)<<endl;
	cout<<"2^30="<<pow(2,30)<<endl;
	//char:[-128,127] 2^7
	//省略的默认类型：signed int
	//局部变量：位于栈内寸中，块结束即释放。
	//编译器将注释替换为空格。
	
	int x=0;
	cout<<"x="<<x<<endl;
	cout<<"x++="<<(x++)<<endl;
	cout<<"x--="<<(x--)<<endl;
	cout<<"x="<<x<<endl;
	cout<<"++x="<<(++x)<<endl;
	cout<<"--x="<<(--x)<<endl;
	
	//调试代码（优于）>看代码 >想代码。
	cout<<"2/(-2)= "<<(2/(-2))<<endl;
	cout<<"2%(-2)= "<<(2%(-2))<<endl;
	
	int a[5]={1,2,3,4,5};
	int *p=(int*)((&a)+1);  //&a+1 == a+sizeof(a)
	cout<<*(a+1)<<" "<<*(p-1)<<endl;  //2 5
	
	//指针free（p）以后要将p==NULL;因为p中仍是原有地址，虽然已被释放。
	//	风格： 注释。函数，空行。（不要担心浪费纸）
}
/*
#include "Eigen/Dense"
using namespace Eigen;
void eigen_used()
{
	//使用eigen 线性代数库  position:/usr/local/include/Eigen
	Matrix<double,3,3> my_matrix;
	Matrix<double,5,5> A;
	
	
	my_matrix.fill(91);
	cout<< my_matrix<<endl;
	my_matrix.setZero();
	cout<< my_matrix<<endl;
	my_matrix.setRandom();
	cout<< my_matrix<<endl;
	
	cout<<"行数："<< my_matrix.rows() <<endl;
	cout<<"列数："<< my_matrix.cols() <<endl;
	cout<<"(1,2): "<< my_matrix(1,1)<<endl;
	
	VectorXd vec;
	vec.setLinSpaced(11,0,100);//开头是0，结尾是100，分成11个数。
	//cout<<vec<<endl;
	
	cout<< my_matrix.block<1,2>(0,0)<<endl;//第一行，前两列
	cout<< my_matrix.row(1)<<endl;				//中间行
	cout<< my_matrix.col(1)<<endl;				//中间列
	cout<< my_matrix.leftCols(2)<<endl;		//前两列
	cout<< my_matrix.middleCols(1,2)<<endl;//后两列
	cout<< my_matrix.rightCols(1)<<endl;	//最后一列
	cout<< my_matrix.topRows(1)<<endl;		//第一行
	cout<< my_matrix.middleRows(0,2)<<endl;//前两行
	cout<< my_matrix.bottomRows(1)<<endl; //最后一行
	
	cout<<"计算："<<endl;
	my_matrix.col(1)=my_matrix.row(1);
	cout<< my_matrix<<endl<<endl;
	cout<< my_matrix.transpose()<<endl<<endl;
	cout<< my_matrix.adjoint()<<endl<<endl;
	cout<< my_matrix.diagonal()<<endl<<endl;//取主对角线上的值。
	cout<< my_matrix.conjugate()<<endl<<endl;
	
	cout<<"四则运算："<<endl;
	cout<<(my_matrix+my_matrix)<<endl;
	cout<<(my_matrix-my_matrix)<<endl;
	cout<<(my_matrix*my_matrix)<<endl;
	
}
#include<string>
void using_str()
{
	//串初始化
	string str; //空串
	string str1("abcde"); //60 is str length
	cout<<str1<<endl;
	string str2(3,'A');  //"AAA"
	//operate
	cout<<str1.length()<<endl;
	str1.push_back('V');
	cout<<str1<<endl;
	str1.append("III");
	cout<<str1<<endl;
	str1.insert(4,"DDD");
	cout<<str1<<endl;
	str1.clear();
	reverse(str.begin(),str.end() );
	int index=str2.find('A');
	cout<<index<<endl;
}
*/
void call_first()
{
	//using_str();
	//learn1();   //utf8.h 及unicode字符处理
	//test1();		//C++11 的使用方法
	//c_fundemental();
	//eigen_used();
}
