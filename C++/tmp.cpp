
#ifndef TMP_CPP
#define TMP_CPP

//时间：2019-4-24

//作者：Sun Jonson

//内容：:

string itos(int i)	// convert int to string
{
	stringstream s;
	s << i;
	return s.str();
}

void test() //不再头文件中声明一样可以调用;表明include是一个装入过程
{
	cout<<"测试函数开始执行"<<endl;
	string tmp=itos(123);
	cout<<tmp<<endl;
}

//==========================================
//				位(bit)操作
//功能:
//	可以用作信号表
//	安全性上讲vector<bool>更好,理由: 8个1的出错概率远小于一个1
//函数功能:
//		bit_value_get: 按位置取值
//		bits_show:整数的bit表示
//		bit_value_set: 按位置设值
//==========================================

//获取val 的第position位的值
template<typename T>
char bit_value_get(T val,int position) 
{
	int lens=sizeof(val)*8;
	assert(lens>=position);
	T label=1;
	label<<=(position-1);
	return (label&val ? '1' : '0'); //char
	//return (label&val ? 1 : 0); //int
	//return (label&val ? true : false); //bool
}

template<typename T>
void bits_show(T val) 
{
	int lens=sizeof(val)*8;
	//cout<<"bit长度"<<lens<<endl;
	
	T label=1;
	string result="";
	for(int i=0;i<lens;i++){
		result+=(label&val ? '1' : '0');
		label<<=1;  //移位检测
		//label*=2;
		//cout<<itos(label)<<endl;
	}
	reverse(result.begin(),result.end());
	cout<<result<<endl;
}

template<typename T>
bool bit_value_set(T& val,int position)  //将position的值 取反
{
	int lens=sizeof(val)*8;
	assert(lens>=position);
	
	T label=1;
	label<<=(position-1);
	
	return val^=label;
}


//bit操作的测试函数

bool bit_used()		
{
	short tmp=11;
	bits_show<short>(tmp);
	short i=1;
	while(i <= 16){
		bit_value_set<short>(tmp,i);
		bits_show<short>(tmp);
		i++;
	}
  return true;
	bits_show<long>(8848);
	bits_show<unsigned int>(8848);
	bits_show<int>(-8849); //负数->补码表示
	bits_show<short>(1);
	bits_show<int>(-1);
	bits_show<bool>(false);
	bits_show<bool>(true); //原来是8个1
	bits_show<char>('A');
	//string float double 不行,缺少<<= 和 float label=1 出错
	//string:可以使用stoi
	
	bits_show<int>(33);
	cout<<bit_value_get<int>(33,1)<<endl;
	cout<<bit_value_get<int>(33,9)<<endl;
  return true;
}
#endif
