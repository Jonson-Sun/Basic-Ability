//一九年四月二十四日 
// 大风 阴

#ifndef HEAD_H
#define HEAD_H

//类,结构,函数的 声明
//类和结构体中不进行数据定义,只有函数声明作为*接口*
//	全部采用 "virtual function()const =0" 形式
//	数据定义放到实现中的public protected

//头文件和实现文件的文件名应保持一致:
//	filename.h -> filename.cpp

//接口 , 声明
//bool bit_used();
//实现 , 定义:
//	显式包含*其他*的 filename.cpp;
//	不再包含 #include"head.cpp"
//#include"other_filename.cpp"

#include<iostream>
#include<fstream>
#include<vector>
#include<string>
using namespace std;
//utf8 文本切片
vector<string> line2vec(string& sentence);
//文本读写
vector<string> readlines(string filename);
bool writelines(vector<string> str_vec,string filename);
//日志
bool log_add(string log_info,bool write2file=false);

#endif



