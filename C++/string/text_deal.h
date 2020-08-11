/* 本文件用于文本处理
		1\得到字向量
		2、得到词向量
		
		
		2017-11-20 晚
		sun jonson
*/

#include"lib/utf8.h"
#include<string>
#include<vector>
#include<math.h>

//定义 字的存储结构


typedef struct word_represent  //词表示
{
	basic_string<char> word; //单个的字
	long freq; //这个字的频率
	//还可以加上这个字的向量表示
	
	struct word_represent& operator=(struct word_represent& C)
	{
		this->word=C.word;
		this->freq=C.freq;
		return *this;
	}
	int operator<(struct word_represent& C)
	{
		if( (this->freq) < (C.freq) ){
			return true;
		}
		else{
			return false;
		}
	}
	int operator>(struct word_represent& C)
	{
		if( (this->freq) > (C.freq) ){
			return true;
		}
		else{
			return false;
		}
	}
	bool operator==(struct word_represent& C)
	{
		if( (this->word ==C.word)&&(this->freq == C.freq) ){
			return true;
		}
		else{
			return false;
		}
	}
} word_rep;



//字函数@1.1.1   检查字符是否在表中


vector<word_rep>::iterator find_str(vector<word_rep>::iterator start,vector<word_rep>::iterator end,basic_string<char> find_str)
{
	vector<word_rep>::iterator iter=start;//直接使用start迭代产生 段错误(吐核)  
	for(;iter!=end;iter++){
		if(iter->word == find_str){
			break;
		}
	}
	return iter;
}

//函数@1.2.1

void exchange(word_rep& A,word_rep& B)
{
	//用于排序函数的 元素交换
	word_rep C;
	C=A;
	A=B;		//这才是简介、流畅、优美
	B=C;
}


//函数@1.2.2


bool choise_sort(vector<word_rep>& word_table)
{
	//选择排序：安频率由高到底
	unsigned int table_end=word_table.size();
	
	for(unsigned int wait_sorted =0;wait_sorted<table_end;wait_sorted++)
	{
		unsigned int cousor=wait_sorted+1;
		for(;cousor<table_end;cousor++){  //cousor:游标
			if(word_table[wait_sorted] < word_table[cousor] ){
				exchange(word_table[wait_sorted],word_table[cousor]);
			}
		}
	}
	return true;
}


//函数1.2.3.1
void fixed_insert(vector<word_rep>& word_table,unsigned int moved)
{
	//将找到的较大元素插入到合适的位置，由moved向前查找
	unsigned int check_one= moved-1;
	while(word_table[check_one] < word_table[moved])//第一次的比较  多余
	{
		exchange(word_table[check_one],word_table[moved]);
		check_one-=1;
		moved-=1;
		if(moved <= 0){//check_one<0 段错误：越界 下溢出 替换为moved
			break;
		}
	}
}

//函数1.2.3

bool insert_sort(vector<word_rep>& word_table)
{
//由大到小排序
	unsigned int length=word_table.size();
	for(unsigned int fronter=0;fronter<length;fronter++)
	{
		unsigned int backer=fronter+1;
		if(word_table[fronter] < word_table[backer] )
		{
			//cout<<"insert function is called!"<<backer<<endl;
			fixed_insert(word_table,backer);
		}
	}
	return true;
}



//函数1.2.4
bool DLshell_sort(vector<word_rep>& word_table)
{
	//不稳定 适合中等规模数据 O（n^3/2）
	unsigned int table_length=word_table.size();
	unsigned int width_set[]={1,3,5,7,13,19};   //最后一趟的值一定为1
	unsigned int set_length=(sizeof(width_set)/sizeof(unsigned int) );//length?
	for(int i=(set_length-1);i>=0;i--)
	{
		//width_set[i] 为步长 ，形成数列
		vector<int> num_group;
		//将符合条件的下标加入num_group
		for(int j=0;j<table_length;)
		{
			num_group.push_back(j);
			j=j+width_set[i];
		}
		//按照分好的数列 插入排序(我用选择排序代替)   word_table[num_group[i]]
		unsigned int num_group_length=num_group.size();
		//cout<<"insert called,length is "<<num_group_length<<endl;
		for(int i=0;i<num_group_length;i++)
		{
			unsigned int j=i+1;
			for(;j<num_group_length;j++){
				if( word_table[num_group[i]] <  word_table[num_group[j]]){
					exchange( word_table[num_group[i]], word_table[num_group[j]]);
				}
			}
		}
	}
	return true;
}




//函数1.2.5  1962 《痴心绝对 》
//2017-11-22：递归程序真实难写又难调！
bool fast_sort(vector<word_rep>& word_table,int start,int end)
{
	//快速排序O(n*logn)不稳定：适合大规模数据,第一遍确定基准的左边都比自己小，右边都大
	if( (end-start)<=1 ){
		return true;
	}
	int tmp1=start,tmp2=end;
	int benchmark=++start;
 	
	while((start) != end)//会不会出现不重合的情况？？？
	{
		//查找到二分位置
		if( word_table[start] > word_table[benchmark])
		{
			start+=1;
		}
		else if( word_table[end] < word_table[benchmark])
		{
			end-=1;
		} 
		else
		{
			exchange(word_table[start],word_table[end--]);//每次循环只做一件事。
		}
	}
	exchange(word_table[tmp1],word_table[end]);
	//cout<<": "<<start<<end<<endl;
	fast_sort(word_table,tmp1,end);
	fast_sort(word_table,end,tmp2);
	
	return true;// 1  8 7 6 (2) 3  5 4 9  
}							//  9    8   7 6    4     3    5  2  1



//函数1.2.6
bool heap_sort(vector<word_rep>& word_table)
{
	return true;
}



//函数1.2.7  《苟日新，日日新，又日新》
bool maopao_sort(vector<word_rep>& word_table)
{
	bool run=true;
	unsigned int end=word_table.size();
	unsigned int cousor=0;
	while(run){
		for(unsigned int start=0;start<end;start++)
		{
			cousor=start+1;
			if(word_table[start] < word_table[cousor])
			{ //走一趟 最后一个便不动了
				exchange(word_table[start],word_table[cousor]);
				run=false;
			}
		}
		end-=1;
		run=!run;  //上下两个语句都忘了分号（ ;  ）
	}
	return true;
}



//字函数@1.1
//可以将p改为const 指针
//因为存在形参检查，所以形参类型不能是auto
void build_word_table(vector<word_rep>& word_table,vector<string>::iterator p)
{
	//cout<< *p <<endl;
	vector<string> sentence;
	getCharactersFromString(*p,sentence);
	
	vector<word_rep>::iterator word_rep_iter;
	//auto compare=[](string a,string b){return (a==b?true:false);};
	//cout<<"lambda exp is : "<<compare("西","西")<<endl;
	
	for (int i = 0; i < sentence.size(); i++){//检验p指针
		//cout<<' '<<sentence[i];
		if(i==0){
			word_rep tmp;
			tmp.word=sentence[0];
			tmp.freq=1;
			word_table.push_back(tmp);
		}
		//检查字符是否在表中
		word_rep_iter=find_str(word_table.begin(),word_table.end(),sentence[i]);
		//不再表中 将字符加入表中 频率置为1
		if(word_rep_iter == word_table.end()){
			word_rep tmp;
			tmp.word=sentence[i];
			tmp.freq=1;
			word_table.push_back(tmp);
		}
		else{
		//在表中 频率+1
			word_rep_iter->freq+=1;
		}
	}
	
}

//子函数@1.2

bool word_table_sort(vector<word_rep>& word_table)
{
	//各种排序算法封装
	bool right_run=true;
	//right_run=maopao_sort(word_table);   //O(n^2)           冒泡
	//right_run=choise_sort(word_table);   //O(n^2)	          选择
	
	//right_run=insert_sort(word_table);   //O(n^2)           插入
	//right_run=DLshell_sort(word_table);  //O(n^1.2)         希尔
	
	unsigned int end=word_table.size();
	right_run=fast_sort(word_table,0,end);     //O(n*logn)-O(n^2) 快排
	//right_run=heap_sort(word_table);		 //O(n*logn)        堆排
	//错误检查使用断言 无需返回值,,大多数情况快排总是最好的。
	assert(right_run == true);
	return true;
}

//函数@1.3
void check_result(vector<word_rep>& word_table)
{
	cout<<"检查排序结果："<<endl;
	unsigned int i=0;
	for(auto p=word_table.begin();p!=word_table.end();p++){
		cout<<(p->word)<<' '<<(p->freq)<<endl;
		i++;
		if(i>=100){
			break;
		}
	}
}

//函数@1.4
bool result2file(vector<word_rep>& word_table)
{
	//自己的事情自己干 
	//运行结果检查使用 【函数内断言】
	ofstream result("data/result.txt");
	assert(result.is_open() == true);
	int end=word_table.size();

	for(int i=0;i<end;i++)
	{
		result<<word_table[i].word<<' '<<word_table[i].freq<<endl;
	}
	result.close();
	cout<<"排序表的大小为："<<end<<endl;
	return true;
}

//字函数@1
bool readfile_and_sort()
{
	ifstream the4sign("data/foursign.txt");
	if(!the4sign.is_open()){
		cout<<"文件打开失败！"<<endl;
		return false;
	}
	else{
		cout<<"文件读取完成！"<<endl;
	}
	string tmpsentence="";
	vector<string> text_lines;
	while(!the4sign.eof()){
		getline(the4sign,tmpsentence);//读取一行存到串tmpsentence里
		text_lines.push_back(tmpsentence);//将串压入容器
	}
	the4sign.close();
	unsigned int lines_size=text_lines.size();
	cout<<"文件的行数为："<<lines_size<<endl;
	
	vector<word_rep> word_table;
	//vector<string>::iterator p;  //使用auto也可以，显示声明也行
	for(auto p=text_lines.begin();p!=text_lines.end();p++){
		//cout<< *p <<endl;  //endl 少打了个l。：一个字母都不能错呀！
		build_word_table(word_table,p);
		//break;									//控制程序只执行一行。
	}
	
	//对word_table进行排序
	word_table_sort(word_table);
	
	//检验word_table
	//check_result(word_table);
	
	//排序结果写入文件
	result2file(word_table);
	return true;
}


//字函数@2
bool build_haffman_tree()
{
	return true;
}
//字函数@3


//用于字向量训练的主函数。
//1、排序 2、构建haffman树 
//3、cbow\skip-gram 4
bool train_word_vector_represent()
{
	bool true_or_false=true;
	//读文件、并且排序
	true_or_false=readfile_and_sort();
	if(!true_or_false){		//使用断言还是逻辑判断？
		cout<<"readfile_and_sort(); error"<<endl;
		return false;
	}
	//建立haffman 树
	true_or_false=build_haffman_tree();
	if(!true_or_false){
		cout<<"build_haffman_tree(); error"<<endl;
		return false;
	}
	//cbow模型
	
	//
	return true;
}		





/*笔记：
		1\函数传入的参数检查，调用的函数的返回值检查。
		2、坚持就是胜利
		3、桶排序：将数据影射到K个桶中，每个桶进行单独排序【空间占用为n，O（n）】
		4、分析{分解、分治} ，组合：线性组装    分总结构  【编程方法】
	问题：
		5、为什么排序结果的输出文件 result.txt 会有空字符？？？？2000行之后
		
		
		
		
		
*/
