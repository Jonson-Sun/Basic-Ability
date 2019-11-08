
#ifndef BOOST_USED_CPP
#define BOOST_USED_CPP

//时间：2019-?-?

//作者：Sun Jonson

//内容：:

#include"head.h"

#include<iostream>
#include<boost/algorithm/string.hpp>
#include<regex>
using namespace std;
using namespace boost;
//coroutine2: -lboost_context
bool get_video_url()
{
	//用regex在html文件中提取 url
	vector<string> html_vec=readlines("asd.html");
	regex expr{"src=\".+?\\.mp4"};
	smatch result;
	for(auto line:html_vec)
	{
		if(regex_search(line,result,expr))
		{
			cout<<"匹配结果的长度: "<<result.size()<<endl;
			string tmp=result[0];
			cout<<tmp.substr(7)<<endl;//去掉前7个byte
			//log_add();
			//log_add(result[0]);
			//输出链接
		}
	}
	//log_add("结束",true);
	return true;	
}

//
// 建立模型的输入和输出的数据[分词]
//1.输入:字符->数字 one-hot
//2.输出:有空格为0,否则1
//3.模型即为one-hot到bool序列的映射
//
bool build_data()
{
	

	return true;
}
//
//	模型:傅立叶变换
//	连杆系统:由于各种曲线都能用代数曲线近似地描述，因此连杆系统几乎可以视为万能的了
//
//
bool fft_model()
{
	return true;
}

//
//	计算bigram 
//	即A->B:概率
//
#include<boost/tokenizer.hpp>
#include<map>
bool bigram_freq()
{
	string filename="/home/asen/Jonson-Sun/baidu_sep.txt";
	vector<string> lines=readlines(filename);
	cout<<"!行数为:"<<lines.size()<<endl;
	map<string,int> word_pair_freq;
	string key="";
	int stop_num=1;
	
	for(string s : lines){
		tokenizer<> token_one(s);
		string before="";
		for(auto item:token_one){
			//cout<<item<<" ";
			//计算频率:
			if(before!=""){
				key=before+"#"+item;
				if(word_pair_freq.count(key)==0){
					//不存在	
					word_pair_freq[key]=1;
				}else{
					word_pair_freq[key]+=1;
				}
			}
			before=item;
		}
		//if(stop_num++ >100)break;
	}
	cout<<"词对 数量为:"<<word_pair_freq.size()<<endl;
	
	for(auto item:word_pair_freq){
		string tmp=(item.first)+"\t:\t"+to_string(item.second)+"\n";
		log_add(tmp);
	}
	
	return true;
}
//
// A->B1,B2,B3......
//
bool bigram_words()
{
	string filename="/home/asen/Jonson-Sun/baidu_sep.txt";
	vector<string> lines=readlines(filename);
	cout<<"!行数为:"<<lines.size()<<endl;
	multimap<string,string> word_pair;
	
	for(string s : lines){
		tokenizer<> token_one(s);
		string before="";
		for(auto item:token_one){
			//cout<<item<<" ";
			if(before!="" && word_pair.count(before)==0){
				word_pair.insert({before,item});//不存在
			}
			before=item;
		}
	}
	cout<<"词对 数量为:"<<word_pair.size()<<endl;
	for(auto& e:word_pair){
		log_add(e.first+"\t:\t"+e.second+"\n");
	}
	return true;
}




//
//	本文件的测试函数
//
#include <boost/timer/timer.hpp>
void test()  
{
	file_thread();

	auto a="alksdfjka";
	cout<<"typeid used :"<<typeid(a).name()<<endl;
return;
	timer::auto_cpu_timer t;  //静态编译时启用
	//bigram_words();
	//control();
	//get_video_url();
	//猛虎在深山，百兽震恐，及在槛阱之中，摇尾而求食，积威约之渐也...积威约之势也
	log_add("\n\n 日志结束",true);
}
#endif

//include/boost/range/begin.hpp:114:61: 
//	error: no type named ‘type’ in ‘struct boost::range_iterator
// no solution
