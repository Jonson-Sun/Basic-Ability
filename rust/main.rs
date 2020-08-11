fn main() {
	println!("hello word");

	//syntex();  //基本语法使用
	data_struct();
}

//**********************************************

fn data_struct()
{
//向量：
	let v=vec![1,2,3,3,4,5,6,7,8];
	let v2=vec![1;10];  //用10个1初始化 向量
	println!("使用向量{},{}",v[2],v2[5]);
	for i in &v {
		println!("i = {}",i);
	}
//移动语义
	let v1=v;  // v已经失效 由复制粘贴-》剪切粘贴
//运算符：
	println!("0b1100 and 0b1010 is {:b}",0b1100 & 0b1010);
	println!("逻辑操作：{}",true && true);
//结构体和enum类型
	struct point{
		x:u32,y:u32
	}
	let po1=point{x:3,y:4};
	println!("结构体：{},{}",po1.x,po1.y);
	assert_eq!(3,po1.x);
//元组结构体：
	struct color(i32,i32,i32);
	let black=color(0,0,0);
//枚举类型
	enum message{
		changecolor(i32,i32,i32),
		write(String),
		Move {x:i32,y:i32},
	}
	let one=message::Move{x:3,y:5};
//匹配 match
	let choose=3;
	match choose {
		1=> println!("one"),
		2=> println!("two"),
		3=> println!("three"),
		4=> println!("one"),
		5=> println!("one"),
		6=> println!("one"),
		7=> println!("one"),
		_=> println!("none"),  //必须存在 _
	}
//闭包
	let plus_one = |x:i32| x+1;
	assert_eq!(2,plus_one(1));
	let plus_two = |x| {
		let mut result :i32 =x;
		result+=1;
		result+=1;
		result
	};
	assert_eq!(3,plus_two(1) );
//static const
	static N :i32 =5;  //被内联到用到它们的地方。为此对同一常量的引用并不能保证引用到相同的内存地址。
	const S :i32 =7;  //全局变量 c中的#define
	static mut food :u32 =234;
	unsafe {food+=1;println!("多线程时不安全：{}",food);  }
//别名type
	type int=i32;
	let x:i32=3;
	let y:int=3;
	if x==y {
		println!("两者相等！");
	}
//类型转换
	let x1:i32= 5;
	let y =x as i64;
	println!("类型转换：{}",y);
	//不安全转换：transmute
//裸指针
	let raw=&x as *const i32;
	
}

//*********************************************

fn syntex()
{
//常量
	const language: i32 = 100; //为全局常量
	static place_of_me:str = "China hebei xinji"; //为全局量
//变量：
	let mut x=5;  //默认常量
	let x0:i32;
	let x1:i32 = 5;  //i32为类型
	let (xi,yi) = (1,2);  //左侧是一个模式，而不仅仅是一个变量
	let mut x2=3; //可变绑定
	x0=xi+yi+x2;
	x2=x+x1+x0;
	println!("x2 is {}",x2);//基于表达式语言 一个分号就是一个表达式
//函数：	
	print_sum(x,x0);
	println!("返回值 是 {}", return_value(x2) );
	let fntmp0:fn(i32)->i32 =plus_three;  //冒号后面是函数类型
	let fntmp=plus_three(7);
	println!("函数指针：{},{}",fntmp,fntmp0(2));
//数据类型：
	let mut boo = true;
	let boo1:bool = false;
	//char类型代表一个单独的 Unicode 字符的值：是四个字节
	let chr='x';
	let chr1='我' ;
	//数值类型： u：无符号 i：有符号整型 8、16、32、64 |   f32 、f64、 
	//可变大小类型：isize、usize （依赖底层机器指针大小）
	
	//定长数组
	let array=[1,2,3];
	let mut array1=[1;10]; //10个1初始化
	println!("数组的长度为：{},{}", array1.len(),array[1] );
	//切片：在底层，slice 代表一个指向数据开始的指针和一个长度。
	let slice1=&array[..];
	let slice2=&array1[3..5];
	//println!("切片：{}",slice1);  //如何输出切片？
	//str ： ？？
	//元组 tuples
	let tu=(1,"hello");
	let tu1:(i32,&str)=(2,"world");
	println!("{}元组索引{}",tu.0,tu1.1);
	println!("元组输出：{:?}",tu);
// 注释 1、// 2、/// 3、//！
	if chr=='x' {
		println!("if 语句。");
	}else{
		println!("else 语句。");
	}
	if boo == true {
		println!("多层if。");
	}else if boo1==false{
		println!("多层elseif .");
	}else{
		println!("最后else");
	}
	//一个没有else的if总是返回()作为返回值
//循环：
	loop{
		x=x+1;
		println!("loop循环：{}",x);
		if x>=10{
			break;
		}
	}
	while boo {
		x=x+1;
		println!("while循环：{}",x);
		if x>=20 {
			boo=false;
		}
	}	
	for one in 0..10{
		//同样是半开半闭区间
		println!("for循环：{}",one);
	}
	for (index,value) in (1..7).enumerate() {
		println!("index={},value={}",index,value);
	}
	//循环标签 'name 标签的格式
	'outer : for num1 in 0..10 {
		'inner : for num2 in 0..10 {
			if num1%2 == 0 {continue 'outer;}
			if num2%2 == 0 {continue 'inner;}
			println!("x={},y={}",num1,num2);
		}
	}
}
fn print_sum(x:i32,y:i32)
{
	println!("sum is {}",x+y);
}
fn return_value(x:i32) ->i32 
{
	return x;
	x+1  //返回值无分号
}
fn plus_three(num:i32)->i32
{
	num+3
}
//一个块是一个被{和}包围的语句集合
//变量可以被隐藏。这意味着一个后声明的并位于同一作用域的相同名字的变量绑定将会覆盖前一个变量绑定
//隐藏允许我们将一个名字重绑定为不同的类型。它也可以改变一个绑定的可变性。
//注意隐藏并不改变和销毁被绑定的值，这个值会在离开作用域之前继续存在，即便无法访问到它
//rust中只有两种语句：声明语句和表达式语句，其余都是表达式
//let只能开始一个语句
//声明未使用的变量会产生warning
//在计算机编程中，一个语句是一个编程语言能让计算执行操的最小的独立元素
//在计算机编程中，一个表达式是一个值，常量，变量，运算符和函数的组合，它可以产生一个单一的值。
//Arity 代表一个函数或操作获取的参数的数量。
//环境无法推断类型时：i32 f64
//1_000 等同于 1000
//i32 后缀表明数据是一个 32 位存储的带符号整数。
//元组可以充当函数的参数和返回值
//只有与引用（例如一个包含引用的struct）相关的变量才需要生命周期。
//结构体的可变性位于它的绑定上结构体的可变性位于它的绑定上
//包装箱（crate）和模块（module）。包装箱是其它语言中库（library）或包（package）的同义词
//我们用mod关键字来定义我们的每一个模块