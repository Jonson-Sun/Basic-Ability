//一九年四月二十四日 
// 大风 阴

#ifndef HEAD_H
#define HEAD_H

//类,结构,函数的 声明
//类和结构体中不进行数据定义,只有函数声明作为接口
//	全部采用 "virtual function()const =0" 形式
//	数据定义放到实现中的public protected
//头文件和实现文件的文件名应保持一致:
//	filename.h -> filename.cpp

#include<iostream>
#include<sstream> //stringstream
#include<string>
#include <iterator>
#include <algorithm>
#include<cassert>
using namespace std;
//接口 , 声明
bool bit_used();

//实现 , 定义
#include"tmp.cpp"

#endif



