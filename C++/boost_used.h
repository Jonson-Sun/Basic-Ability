
#ifndef FILE_NAME_CPP
#define FILE_NAME_CPP

//时间：2019-?-?

//作者：Sun Jonson

//内容：:Boost 库


//#include<boost/>
//#include<boost/>
//#include<boost/>
#include<iostream>
#include<string>
#include<boost/algorithm/string_regex.hpp>
#include<boost/algorithm/string.hpp> // split join replace
#include <boost/lexical_cast.hpp>
#include <boost/regex.hpp>

using namespace std;
using namespace boost;

void show_str(string one_str){cout<<one_str+";"<<endl;}
bool str_opt()
{
	string one_str=" 啊撒了1看到    年份,12314s gdfg1bf.    ";
	cout<<"size:"<<one_str.size()<<endl;
	cout<<"length:"<<one_str.length()<<endl;
	//to_lower()
	//to_upper(one_str); show_str(one_str);
	// 去掉开头空格trim(),trim_left,trim_right,trim_left_copy
	//trim_right(one_str); show_str(one_str);
	
	//replace_first(one_str,"啊撒了","Julia");show_str(one_str);
	//replace_last(one_str,"年份","天狼星");show_str(one_str);
	//replace_all(one_str,"gdf","aab");show_str(one_str);
	//erase_all(one_str,"1");show_str(one_str);
	
	if(find_first(one_str,"看到"))
		{cout<<"找到"<<endl;}
	else{
		cout<<"未找到"<<endl;
	}
	
	vector<string> str_vec;
	//regex e("^(\s)+?");           //未定义的引用???
	//split(str_vec,one_str,is_any_of(" "));
	//split_regex(str_vec,one_str,e);
	for(auto val:str_vec){
		cout<<val+"+"<<endl;
	}
	return true;
	//starts_with
	//ends_with
	//contains
	//join
	unsigned int yoko=142;
	cout<<"字面量转换 : "<<boost::lexical_cast<std::string>(yoko); //类型转换142->"142"
	
	
	
	for(auto it:one_str){
		//问题: wstring:find_first失灵,显示的是数字
		//		string:汉字无法显示
		//原因:utf8 是变长编码
		cout<<it<<endl;// char 迭代
	}
	
	return true;
}
//===========================================
#include<fstream>
vector<string> readlines(string filename)
{
	vector<string> str_vec;
	string tmp("");
	
	ifstream ifs(filename,ios::in);
	if(ifs.is_open()){
		for(;getline(ifs,tmp);){
			str_vec.push_back(tmp);
		}
	}
	else{
		str_vec.push_back("打开文件失败!");
	}
	return str_vec;
}
//对应方式
//11101001 10011101 10011001 00000000   bitstring('静') 38745
//    1001   011101   011001           bitstring(38745)[end-15:end]

#include<sstream>
vector<string> line_iter(string sentence,map<unsigned int,string> &utf8table)
{
	vector<string> line;
	if(sentence.empty()==true){return line;} //待识别句子内容为空
	//cout<<(sentence[0]>0?true:false)<<endl;
	int i=0;
	unsigned int val=0;
	for(auto x:sentence){
		unsigned char item=(unsigned char)x;
		//cout<<"item的值为"<<short(item)<<"长度为"<<sizeof(item)<<endl;
		if((0<item) && (item<128)){
			//cout<<"一个字节"<<endl;
			val=sentence[i];
		}
		else if((192<=item) && (item<224)){//-64~ -32  (-2^6<=item) && (item<-2^5)
			cout<<"2个字节";
			int val1=(256+(sentence[i])-(128+64));
			int val2=(256+(sentence[i+1])-128);
			//cout<<val1<<":"<<val2<<endl;
			val=(val1*64+val2);
		}
		else if((224<=item) && (item<240)){//-32~ -16 (-2^5<=item) && (item<-2^4)
			//cout<<"3个字节";
			int val1=(256+(sentence[i])-(128+64+32));
			int val2=(256+(sentence[i+1])-128);
			int val3=(256+(sentence[i+2])-128);
			//cout<<val1<<":"<<val2<<":"<<val3<<endl;
			val=(val1*64+val2)*64+val3;
		}
		else if((240<=item) && (item<248)){//-16~ -8 (-2^4<=item) && (item<-2^3)
			cout<<"4个字节";
			int val1=(256+(sentence[i])-(128+64+32+16));
			int val2=(256+(sentence[i+1])-128);
			int val3=(256+(sentence[i+2])-128);
			int val4=(256+(sentence[i+3])-128);
			//cout<<val1<<":"<<val2<<":"<<val3<<":"<<val4<<endl;
			val=((val1*64+val2)*64+val3)*64+val4;
		}
		else if((128<=item) && (item<192)){//-128~ -64  (-2^7<=item) && (item<-2^6)
			//cout<<"中间"<<endl; //中间值	
			i++;continue;
		}
		else{
			//异常情况 0~-8
			cout<<"异常值"<<endl;
		}
		//数符转换
		//1.自己建立转换表
		//2.使用系统的映射表
		line.push_back(utf8table[val]);
		i++;
	}
	return line;
}
#include <map>
void num2char(map<unsigned int,string> &utf8table)
{
	vector<string> u_vec=readlines("utf8.txt");
	vector<string> str_vec;
	unsigned int count=0;
	
	for(auto two_str:u_vec){
		split(str_vec,two_str,is_any_of(" "));
		if(str_vec.size()!=2){count++;cout<<"存储符数对的向量长度:"<<str_vec.size()<<endl;continue;}
		int val=lexical_cast<int>(str_vec[0]);  //符数转换
		utf8table[val]=str_vec[1];  //加入映射表
		//str_vec.clear()  //考虑是否需要清理向量
	}
	
	cout<<"表的大小为:"<<utf8table.size()<<endl;
	//cout<<"38745(静)对应的映射表值为"<<utf8table[38745]<<'0'<<endl;
	//进一步可以 序列化
}
bool read_iter_utf8(string filename)
{	//构建utf8 数符映射
	map<unsigned int,string> utf8table;
	num2char(utf8table);
	//读取utf8文件的每一行到string向量中
	//迭代显示每一个 字
	vector<string> lines=readlines(filename);
	vector<string> line=line_iter(lines[2],utf8table);
	for(string x:line){
		cout<<x<<endl;//为啥必须有endl??????
	}
	cout<<endl;
	cout<<"索引使用"<<line[2]<<'\t';
	return true;
}
void test()
{
	//str_opt();
	read_iter_utf8("tmp.txt");
	//num2char();
}
#endif
