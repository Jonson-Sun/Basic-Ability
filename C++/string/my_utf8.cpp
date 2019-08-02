
#ifndef MY_UTF8_CPP
#define MY_UTF8_CPP

//时间：2019-7-31

//作者：Sun Jonson

//内容：:UTF-8 字符串处理


//===========================================
//		utf-8字符串读取与字符迭代 
//					手工实现
//
//	vector<line_str> readlines(文件名)
//	vector<u8char>   line2vec (line_str)
//	
//===========================================
#include<fstream>
#include<vector>
#include<string>
#include<sstream>
#include<map>  //可能缺少头文件


//
//仿照julia的readlines函数
//进一步简化 文件读取
//
vector<string> readlines(string filename)  
{
	vector<string> str_vec;
	string tmp("");
	
	ifstream ifs(filename,ios::in);
	if(ifs.is_open()){for(;getline(ifs,tmp);){str_vec.push_back(tmp);}}
	else{str_vec.push_back("打开文件失败!");	}
	ifs.close();
	return str_vec;
}
//utf-8对应方式
//11101001 10011101 10011001 00000000   bitstring('静') 38745
//    1001   011101   011001           bitstring(38745)[end-15:end]


//
//utf8串转换为字符向量：方法1
//
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
		//1.自己建立转换表[choose this]
		//2.使用系统的映射表
		line.push_back(utf8table[val]);
		i++;
	}
	return line;
}

//
//utf8串转换为字符向量：方法2
//
vector<string> line2vec(string& sentence)
{
	vector<string> line;
	if(sentence.empty()==true){return line;} //待识别句子内容为空
	
	int 	i=0;
	string	 tmp="";
	unsigned int  val=0;
	
	for(auto x:sentence){
		unsigned char item=(unsigned char)x;//不转换也行，直接负数比较。也可以使用位操作
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
//	建立自己的 数字->字符 对照表
//
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

//
//	字符迭代的测试函数
//
bool test(string filename)
{	//构建utf8 数符映射
	map<unsigned int,string> utf8table;
	//num2char(utf8table);
	//读取utf8文件的每一行到string向量中
	//迭代显示每一个 字
	//vector<string> lines=readlines(filename);
	//vector<string> line=line_iter(lines[2],utf8table);
	string tmp="阿喀琉斯12465的纪念封i啊色道错sadklfjhnv年";
	vector<string> line=line2vec(tmp);
	for(string x:line){
		//cout<<x<<endl;//为啥必须有endl??????
		cout<<x<<" ";
	}
	cout<<endl;
	cout<<"\n索引使用:"<<line[2]<<'\n';
	return true;
}

#endif
