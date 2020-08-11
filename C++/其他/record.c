#include<QString>
#include<vector>
#include<iostream>
#include<fstream>
#include<sstream>
using namespace std;
string convert(vector<char> char_list )
{
    string result="";
    string tmp;
    stringstream ss;
    bool space=false;
    long count=0;

    for(auto i: char_list)
    {
        ss<<hex<<i<<endl;//字符表示
        //ss<<hex<<short(i)<<endl;
        ss>>tmp;
        result+=tmp;
        if(space==true){ result+=" ";    }
        space=!space;
        count++;
        if(count%10==0){result+="\n";}
    }
    return result;
}

void call_other_func(vector<QString>& result)
{
    //result[0]="日志输出";
    //result[3]="log:  normal...";
    //或者
    //result.push_back("");

    char str;
    vector<char> char_list;
    QString tmp;
    unsigned num_1=0;

    ifstream bin_file("/home/asen/eow.mp3");
    if( bin_file.is_open()==true)  result.push_back("文件以打开");
    while( bin_file>>str){
        char_list.push_back(str);
        num_1++;
    }
    bin_file.close();

    result.push_back("字符数为:"+tmp.setNum(num_1));
    string tmp1=convert(char_list);
    ofstream txt_file("/home/asen/asd.txt");
    if(txt_file.is_open()==true){
        txt_file<<tmp1;
        txt_file.close();
    }


    //没有协程,所以只能函数执行结束后返回
    result.push_back("程序执行结束");
}
