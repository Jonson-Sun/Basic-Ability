
//时间：2019-秋

//作者：Sun Jonson

//内容：: 本文件存放旧代码


#include<iostream>
using namespace std;


//
// 3x+1 问题的解法
//

#include<boost/multiprecision/cpp_int.hpp> 
#include<boost/lexical_cast.hpp>
#include<future> //不要使用C++11的静态编译选项
using namespace boost::multiprecision;

bool Ulam_quest(cpp_int num)
{
	unsigned int i=1;
	while(num!=1){ //只要出现1就会421循环
		if(num%2==1){
			num=3*num+1;
		}else{
			num/=2;
		}
		//cout<<num<<" ";
		if(i > 1000000000000){
			return false;
		}else{
			i+=1;
		}
	}
	return true;
}
bool control_function(cpp_int start,cpp_int endp)
{
	cpp_int count=1;
	for(;start<endp;start++){
		if(Ulam_quest(start)==false){
			cout<<"该值循环超过万亿:\n"<<start<<endl;
			return false;
		}
		if( ( start%(endp/100) ) ==0){//endp 必须大于100否则 溢出
			cout<<count<<"%"<<endl;
			count+=1;
		}
	}
	return true;	
}
bool file_thread()
{
	vector<string> num_str=readlines("num.txt");
	cout<<"串向量的大小:"<<num_str.size()<<endl;
	cpp_int start=lexical_cast<cpp_int>(num_str[0]);
	cpp_int endp=lexical_cast<cpp_int>(num_str[1]);
	
	cout<<"起始值为:"<<start<<endl;
	cout<<"终止值为:"<<endp<<endl;
	
	//bool result=control_function(start,endp);
	cpp_int diff_val=(endp-start)/5;
	
	auto t1=async(control_function,start,start+diff_val);
	start+=diff_val;
	auto t2=async(control_function,start,start+diff_val);
	start+=diff_val;
	auto t3=async(control_function,start,start+diff_val);
	start+=diff_val;
	auto t4=async(control_function,start,start+diff_val);
	start+=diff_val;
	auto t5=async(control_function,start,start+diff_val);
	start+=diff_val;//方便最后测验
	
	if(t1.get()&&t2.get()&&t3.get()&&t4.get()&&t5.get()){
		cout<<"该部分正常."<<endl;
	}
	else{
		cout<<"该部分存在异常!"<<endl;
	}	
	if(start!=endp){
		cout<<"最后测验值:"<<start<<endl;
	}
	return true;	
}

int main()
{
	cout<<"程序开始执行"<<endl;
	file_thread();
	return 0;
}