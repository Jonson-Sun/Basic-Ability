<link type="text/css" rel="stylesheet" href="/css/GitHub_Word.css">
<br><br>
# boost 备忘录
<br><br>
<center> 2019</center>
<br><br>

[TOC]

---
## 
## 
## 
## 随机数 boost::random
	//
	// 各种分布:仍待探索
	//
	#include<boost/random/bernoulli_distribution.hpp>
	#include<boost/random/beta_distribution.hpp>
	#include<boost/random/binomial_distribution.hpp>
	#include<boost/random/cauchy_distribution.hpp>
	#include<boost/random/chi_squared_distribution.hpp>
	#include<boost/random/discrete_distribution.hpp>
	#include<boost/random/exponential_distribution.hpp>
	#include<boost/random/extreme_value_distribution.hpp>
	#include<boost/random/gamma_distribution.hpp>
	#include<boost/random/fisher_f_distribution.hpp>
	#include<boost/random/generate_canonical.hpp>
	#include<boost/random/geometric_distribution.hpp>
	#include<boost/random/hyperexponential_distribution.hpp>
	#include<boost/random/laplace_distribution.hpp>
	#include<boost/random/lognormal_distribution.hpp>
	#include<boost/random/negative_binomial_distribution.hpp>
	#include<boost/random/non_central_chi_squared_distribution.hpp>
	#include<boost/random/normal_distribution.hpp>
	#include<boost/random/piecewise_constant_distribution.hpp>
	#include<boost/random/piecewise_linear_distribution.hpp>
	#include<boost/random/poisson_distribution.hpp>
	#include<boost/random/student_t_distribution.hpp>
	#include<boost/random/triangle_distribution.hpp>
	#include<boost/random/uniform_int_distribution.hpp>
	#include<boost/random/uniform_real_distribution.hpp>
	#include<boost/random/weibull_distribution.hpp>

	#include<boost/random/uniform_01.hpp>
	#include<boost/random/uniform_smallint.hpp>
	#include<boost/random/uniform_on_sphere.hpp>


	//
	//  生成器  
	//
	#include<boost/random/linear_congruential.hpp> //minstd_rand0  minstd_rand rand48
	#include<boost/random/additive_combine.hpp>    //ecuyer1988
	#include<boost/random/shuffle_order.hpp>       //knuth_b, kreutzer1986
	#include<boost/random/taus88.hpp>			   //taus88
	#include<boost/random/inversive_congruential.hpp>//hellekalek1995
	#include<boost/random/mersenne_twister.hpp>    //mt11213b, mt19937
	#include<boost/random/lagged_fibonacci.hpp>	   
	//lagged_fibonacci607, lagged_fibonacci1279, lagged_fibonacci2281
	//lagged_fibonacci3217, lagged_fibonacci4423, lagged_fibonacci9689
	//lagged_fibonacci19937, lagged_fibonacci23209, lagged_fibonacci44497
	#include<boost/random/ranlux.hpp>
	//ranlux3, ranlux4, ranlux64_3,ranlux64_4, ranlux3_01, ranlux4_01
	//ranlux64_3_01, ranlux64_4_01, ranlux24, ranlux48

	///
	///其他
	///
	#include<boost/random/seed_seq.hpp>
	#include<boost/random/random_number_generator.hpp>
	#include<boost/random/generate_canonical.hpp>


	random::mt19937 rng;
	int rand_one(int start=1,int end=600){
		//random::uniform_int_distribution<> diset(start,end);
		//random::student_t_distribution<> diset;
		random::normal_distribution<> diset(start,end);
		
		return diset(rng);
	}
	int gailv(){
		double probabilities[] = {0.1, 0.2, 0.1, 0.3, 0.1, 0.2};
		random::discrete_distribution<> dist(probabilities);
		return dist(rng)+1;
	}
	#include<boost/random/random_device.hpp>
	random::random_device rng1;
	bool mima(){
	//该函数需要:-lboost_random
		string table="abcdefghijklmnopqrstuvwxyz1234567890";

		random::uniform_int_distribution<> index_dist(0, 35);
		for(int i=0;i<10;i++){
			cout<<table[index_dist(rng1)]<<",";
		}
		cout<<"mima"<<endl;
		return true;
	}
	bool rand_test()//再试试其他的分布和生成器
	{
		int s=0,s1=0,m=0,e1=0,e=0;
		int start=1;
		int end=600;
		
		for(int i=0;i<1000;i++){
			int tmp=rand_one();
			//int tmp=gailv();
			if(tmp<= (end/5))s++;
			else if(tmp<= (end*0.4))s1++;
			else if(tmp<= (end*0.6))m++;
			else if(tmp<= (end*0.8))e1++;
			else e++;
		}
		cout<<"从小到达的数量:"
			<<s<<"-"
			<<s1<<"-"
			<<m<<"-"
			<<e1<<"-"
			<<e<<endl;
		
		//mima();
		
		return true;
	}





## 协程 coroutine2
	//
	// coroutine2 :provides asymmetric coroutines.
	//	协程: 相当于python的yield 程序在任一位置中断或恢复执行
	//		关键 就是执行的流程控制
	//		The implementation uses Boost.Context for context switching
	//	适合事件驱动模型
	//	实现: fcontext_t:默认实现,基于汇编,有平台依赖,性能最好
	//		 ucontext_t:跨平台,性能稍差
	//	对称协程:显示yield;非对称协程:隐式转移控制权[本库实现方式]
	//	编译选项:-lboost_context
	//
	#include <boost/coroutine2/all.hpp>
	bool called_func(coroutines2::coroutine<void>::push_type & qwe)//无值传递
	{
		cout << "一 ";
	    qwe();
	    cout << "二 ";
	    qwe();
	    cout << "三 ";
		return true;
	}
	bool call_func()
	{
		//push_type 与 pull_type 的位置可互换 从push开始向下执行
		coroutines2::coroutine<void>::pull_type goto_qwe(called_func);
	    cout << "1 ";
	    goto_qwe();
	    cout << "2 ";
	    goto_qwe();
	    cout << "3 "<<endl;
		return true;
	}
	bool called_func1(coroutines2::coroutine<unsigned int>::push_type& qwe)//有值传递
	{
		for(int i=0;i<10;i++){
			cout <<i<< " ";
			qwe(++i);
		}
		return true;
	}
	bool call_func1()
	{
		coroutines2::coroutine<unsigned int>::pull_type goto_qwe(called_func1);
		/*
		//第一种方法:
		unsigned int  i=1;
		for(;i<10;i++){
			cout <<goto_qwe.get()<<" ";
			goto_qwe();
		}
		//第二种方法
	   	using iter = coroutines2::coroutine<unsigned int>::pull_type::iterator;
	    for (iter start = begin(goto_qwe); start != end(goto_qwe); ++start) {
		cout<< *start << " ";
	    }
		*/
		//第三种方法:
		for(auto val:goto_qwe){
			cout<<val<<" ";	
		}
		
	    cout <<endl;
		return true;
	}




##串算法库 string algo
	#include<iostream>
	#include<string>
	#include<boost/algorithm/string_regex.hpp>
	#include<boost/algorithm/string.hpp> // split join replace
	#include <boost/lexical_cast.hpp>
	#include <boost/convert.hpp>
	#include <boost/regex.hpp>

	using namespace boost;
	
	void show_str(string one_str){cout<<one_str+";"<<endl;}
	bool str_opt()
	{
		string one_str="   啊撒了123看到    年份,12314s gdfg1bf. SDFG345SDFUK    ";
		cout<<"1、size:"<<one_str.size()<<endl;
		cout<<"2、length:"<<one_str.length()<<endl;
		//to_lower(),to_upper(one_str); show_str(one_str);
		cout<<"3、转为小写"<<to_lower_copy(one_str) <<endl;
		
		// 去掉开头结尾空格trim(),trim_left,trim_right,trim_left_copy
		//trim_copy_if(str, boost::is_alnum());
		cout<<"4、去开头空格："<<trim_left_copy(one_str)<<endl;
		
		cout<<"5、starts_with:"<<starts_with(" BBCSDRFG","BBC")<<endl;
		cout<<"6、ends_with："<<ends_with("踩踩julia","julia") <<endl;
		
		cout<<"7、contains(包含 in)："<<contains("123zhong456","zhong") <<endl;
		cout<<"8、equals（串相等）"<<equals("julia123","julia123") <<endl;
		cout<<"9、字典序比较："<< lexicographical_compare("abvfg","bwerf")<<endl;
		//cout<<"10、all(元素相同):"<<all("aaaaa",[](char i){return i=='a'?true:false;}) <<endl;
		cout<<"10、all(元素相同):"<<all("aaaaa",is_any_of("a") ) <<endl;
		
		//find_last,find_nth,
		cout<<"11、find_first:"<<find_first(one_str,"123") <<endl;  //怎么用?返回123不是索引
			//if(find_first(one_str,"看到")){cout<<"找到了"<<endl;}else{cout<<"未找到"<<endl;}
		cout<<"12、检索头"<<find_head(one_str,6) <<endl;  //find_tail
		iterator_range<string::iterator> iter1=find_token(one_str,is_any_of("312"));
		cout<<"13、find_token:"<<string(iter1.begin(),iter1.end()) <<endl;  //怎么用???
		
		regex re1{"[0-9]+"};
		iterator_range<string::iterator> iter=find_regex(one_str,re1);
		cout<<"14、find_regex:"<<string(iter.begin(),iter.end()) <<endl;
		//cout<<"15、find："<<find(one_str,first_finder("查找的串",is_iequal()) ) <<endl;
		
		//{replace | erase}_{first | last | all | nth | head | tail | regex}_{copy|""}
		// 28中组合
		replace_first(one_str,"啊撒了","Julia");show_str(one_str);
		replace_last(one_str,"年份","天狼星");show_str(one_str);
		replace_all(one_str,"gdf","aab");show_str(one_str);
		erase_all(one_str,"1");show_str(one_str);  //删除所有的1
		//replace_all_regex_copy()
		
		//find_all,find_all_regex,iter_find,iter_split
		vector<string> neirong;
		find_all_regex(neirong,one_str,re1);
		cout<<"16、find_all_regex 个数"<<neirong.size()<<" "<<neirong[1]<<endl;  //****常用****
		find_all(neirong,one_str,"23");
		cout<<"17、find_all: "<<neirong[1]<<endl;
		
		vector<string> str_vec;
		regex e{"\\s+"};
		//split(str_vec,one_str,is_any_of(" "));
		split_regex(str_vec,one_str,e);
		for(auto val:str_vec){cout<<val+"+"<<endl;}
		
		//join,join_if（比join多个谓词）
		string single_str=join(str_vec,"+");
		cout<<"18、join连接："<<single_str<<endl;
		unsigned int y=142;
		cout<<"19、字面量转换 : "<<lexical_cast<string>(y)<<endl; //类型转换142->"142"	
		//string s2 = convert<string>(100).value();
		//cout<<"20.convert: "<< s2<<endl;
		
		
		//finder
		//{first,last,nth,head,tail,token,range,regex}_finder
		
		//Formatters 格式化器
		//const_formatter,identity_formatter,empty_formatter,regex_formatter
		
		//迭代器 
		//find_iterator,split_iterator	
		
			
		return true;
	}



##Circular Buffer{循环缓冲,vector}
	#include <boost/circular_buffer.hpp>
	bool buffer()
	{
		circular_buffer<string> buffer5(5);
		buffer5.push_back("1.sdf");
		buffer5.push_back("2.啊撒");
		buffer5.push_back("3.撒地方了");
		buffer5.push_back("4.333");
		buffer5.push_back("5.让他鱼");
		string example=buffer5[3];
		buffer5[3]="4.电饭锅";
		buffer5.pop_back();
		buffer5.pop_front();
		for(auto i : buffer5){
			cout<<"["<<i<<endl;
		}
		return true;
	}
##序列化 Serialization
	//	===		========================
	//				
	//	 1.	非自定义对象:写个函数(文件名,对象,存储方式)直接存储
	//	 2. 自定义对象: 在类中添加方法
	//
	//	 编译时添加lib库 : -lboost_serialization
	//
	//	===		========================
	#include <boost/archive/text_oarchive.hpp>
	#include <boost/archive/text_iarchive.hpp>
	#include <boost/archive/text_woarchive.hpp> //宽字符 utf8
	#include <boost/archive/text_wiarchive.hpp>

	#include <boost/archive/xml_oarchive.hpp>
	#include <boost/archive/xml_iarchive.hpp>
	#include <boost/archive/xml_woarchive.hpp>
	#include <boost/archive/xml_wiarchive.hpp>

	#include <boost/archive/binary_oarchive.hpp>
	#include <boost/archive/binary_iarchive.hpp>

	#include <boost/serialization/vector.hpp>
	#include <boost/serialization/map.hpp>
	#include <boost/serialization/set.hpp>
	//
	//	自定义类 的序列化
	//
	class self_def
	{
	public:
		//类内数据定义
		vector<float> aaa;
		set<string> bbb;
		string ccc;
		
		friend class boost::serialization::access;
		
		template<class Archive>
	    void serialize(Archive &ar,unsigned int version)
	    {
			ar & aaa & bbb & ccc ;//读取,写入均可
		} 

		self_def(vector<float>& val1,set<string>& val2,string val3){
			this->aaa=val1;
			this->bbb=val2;
			this->ccc=val3;
		}
		self_def(){};

	};
	//
	//	函数对象 实现序列化与反序列化
	//
	template<class object>
	class Arch_out
	{
	public:
		bool operator()(string filename,object& obj,string type="xml")
		{
			ofstream out_stream(filename);

			if(type=="text"){
				archive::text_oarchive out_ar(out_stream);
				out_ar<<obj; 
			}
			else if(type=="xml"){
				archive::xml_oarchive out_ar(out_stream);
				out_ar<<BOOST_SERIALIZATION_NVP(obj); 
			}
			else{}

			// out_ar && obj;  //相同
			return true;
		}
		friend class boost::serialization::access;
	};
	template<class object>
	class Arch_in  //该class代码未测试
	{
	public:
		bool operator()(string filename,object& obj,string type="xml")
		{
			ifstream in_stream(filename);

			if(type=="text"){
				archive::text_iarchive in_ar(in_stream);
				in_ar>>obj; 
			}
			else if(type=="xml"){
				archive::xml_iarchive in_ar(in_stream);
				in_ar>>BOOST_SERIALIZATION_NVP(obj); 
			}
			else{}
			return true;
		}
		friend class boost::serialization::access;
	};

	//
	//	泛型 实现序列化与反序列化
	//
	template<class object>
	bool arch_out(string filename,object& obj,string type="xml")
	{
		ofstream out_stream(filename);
		//多试几种存储方式
		if(type=="txt"){
			archive::text_oarchive out_ar(out_stream);
			out_ar<<obj;
		}
		else if(type=="xml"){
			archive::xml_oarchive out_ar(out_stream);
			out_ar<<BOOST_SERIALIZATION_NVP(obj);
		}
		else if(type=="bin"){
			archive::binary_oarchive out_ar(out_stream);
			out_ar<<obj;
		}
		/*对‘vtable for boost::archive::codecvt_null<wchar_t>’未定义的引用
		//		-lboost_wserialization 加上无效,难道依赖C++20的u8string
		
		if(type=="wtxt"){
			wofstream out_stream(filename);
			archive::text_woarchive out_ar(out_stream);
			out_ar<<obj;
		}
		else if(type=="wxml"){
			wofstream out_stream(filename);
			archive::xml_woarchive out_ar(out_stream);
			out_ar<<BOOST_SERIALIZATION_NVP(obj);
		} */
		else{
			//type参数的内容:未知
			cerr<<"type 参数错误"<<endl;
		}
		out_stream.close();
		return true;
	}
	template<class object>
	bool arch_in(string filename,object& obj,string type="xml")
	{
		ifstream in_stream(filename);//stringstream is ok
		
		if(type=="txt"){
			archive::text_iarchive in_ar(in_stream);
			in_ar>>obj;
		}
		else if(type=="xml"){
			archive::xml_iarchive in_ar(in_stream);
			in_ar>>BOOST_SERIALIZATION_NVP(obj);
		}
		else if(type=="bin"){//binary 
			archive::binary_iarchive in_ar(in_stream);
			in_ar>>obj;
		}
		/*
		else if(type=="wtxt"){
			wifstream in_stream(filename);
			archive::text_wiarchive in_ar(in_stream);
			in_ar>>obj;
		}
		else if(type=="wxml"){
			wifstream in_stream(filename);
			archive::xml_wiarchive in_ar(in_stream);
			in_ar>>BOOST_SERIALIZATION_NVP(obj);
		} */
		else{
		//wait to fill
		}
		in_stream.close();
		return true;
	}
	//
	//	序列化测试函数
	//
	#include<map>
	#include<set>
	bool Serial_test()
	{
		//1. 多试几种类型 map set vector<int string long>
		vector<long> example_obj{234,456,2342456,6784523,7897435,123457};
		map<string,long> map_tmp{{"C++",1},{"julia",2},{"python",3},{"Perl",4}};
		set<string> set_tmp{"喀什的愤怒","速度快了女","sdlvn","所得率几年","送到了房间"};
		
		set<string> tmp;
		
		
		//2. 多次类型
		auto filename="archive";
		//方法1 函数对象
		//Arch_out<vector<long>> CC;
		//CC(filename,example_obj);
		//方法2 泛型
		//*
		vector<string> type{"txt","bin","xml"};
		for(auto ll:type){
			arch_out(filename,set_tmp,ll);
			arch_in(filename,tmp,ll);
			//for(auto i:tmp){cout<<i.first<<"="<<i.second<<" ";} //map
			for(auto i:tmp){cout<<i<<" ";}
			cout<<ll<<"_tested"<<endl;
		}//
		//方法3 自定义类的序列化
		vector<float> val1={3.12443,5.2347,2345.3456,2345.789};
		set<string> val2={"喀什的愤怒","速度快了女","sdlvn","所得率几年","送到了房间"};
		string val3="撒的开ak sdnf发那可asdf怜检索2354;多次";
		
		self_def item1{val1,val2,val3};
		self_def item2;
		
		ofstream out_stream(filename);
		archive::text_oarchive out_ar(out_stream);
		out_ar<<item1;
		out_stream.close();
		
		ifstream in_stream(filename);
		archive::text_iarchive in_ar(in_stream);
		in_ar>>item2;
		/*
		arch_out<self_def>(filename,item1,"txt");  //该部分出现的错误,尚未解决
		arch_in <self_def>(filename,item2,"txt");	//暂时使用上面七行代码解决
		*/
		cout<<item2.aaa[0]<<endl;;
		cout<<item2.bbb.size()<<endl;
		cout<<item2.ccc<<endl;
		
		return true;
	}
-  -lboost_serialization   编译时需要添加的命令后缀

## 





## 


## 




---
<br><br><br><br>
# 完

<br><br><br><br>