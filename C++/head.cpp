
#ifndef HEAD_CPP
#define HEAD_CPP

//时间：2019-?-?

//作者：Sun Jonson

//内容：:
#include<iostream>
#include<fstream>
#include<vector>
#include<string>
using namespace std;
//
//utf8串转换为字符向量：方法2
//
vector<string> line2vec(string& sentence)
{
	vector<string> line;
	if(sentence.empty()==true){cout<<"空句"<<endl;return line;} 
		//待识别句子内容为空
	
	int 	i=0;
	string	 tmp="";
	unsigned int  val=0;
	
	for(auto x:sentence){
		unsigned char item=(unsigned char)x;
			 if((0<item)    && (item<128)){val=1;} 
		else if((128<=item) && (item<192)){i++;continue;}
		else if((192<=item) && (item<224)){val=2;}
		else if((224<=item) && (item<240)){val=3;}
		else if((240<=item) && (item<248)){val=4;}
		else{cout<<"异常值"<<endl;}//异常情况 0~-8
		line.push_back(sentence.substr(i,val) );  //此处不进行符数转换，直接切分
		i++;
	}
	return line;
}


//
//仿照julia的readlines函数
//进一步简化 文件读取
//
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
	ifs.close();
	return str_vec;
}
//
//	对应的writelines
//
bool writelines(vector<string>& str_vec,string filename="tmp.txt")
{
	ofstream log_file(filename,ios::app);
    for(auto item:str_vec){
        log_file<<item<<endl;
    }
	log_file.close();
	return true;
}

//
//日志记录函数
//

vector<string> log_record{"项目执行日志\n","时间:2019- \n"};
bool log_add(string log_info,bool write2file=false)
{
    log_record.push_back(log_info);
    if(write2file==true){
        writelines(log_record,"log.txt");
        log_record.clear();
    }
    return true;
}



#endif