/*
 *日期 : 2017-12-11
 *
 *作者：Sun Jonson
 *
 *内容：go 语言上手
 *
*/

package main

import "fmt"

/*
基本语法：
	func 函数名（name type，name2 type2）（name type，name1 type1）{
		//依次是传入参数、传出参数(返回值列表)
		//大括号的格式固定
	}
	变量声明：
		var name type:  var book string 
	常量是指编译期间就已知且不可改变的值
	预定义常量：
		true
	  false
	  iota【iota 比较特殊,可以被认为是一个可被编译器修改的常量,
	  				在每一个 const 关键字出现时被重置为0,然后在下一个 const 出现之前,
	  				每出现一次 iota ,其所代表的数字会自动增1。】
	枚举：枚举指一系列相关的常量
	以大写字母开头的常量在包外可见
	类型：
		bool
		int8、 int16 int32 int64 uint8 uint16 uint32 uint64
		int uint（默认） uintptr【无假设长度使用方便】
		float32  float64（默认）
		complex64 complex128
		string
		rune[字符类型]
		error【错误类型】
		{uint8 is byte,}
	复合类型：
		pointer指针、数足array、切片slice、字典map、通道chan、结构体struct、接口interface
	运算符：
		+ - * / %
		<  >  <=  >= == !=
		<<  >>  ^ & |   
		 (^2 == -3  取反运算  与异或运算符相同  左值默认为1)
	在Go语言中数组是一个值类型：
		作为函数的参数时会产生复制动作
流程控制：
	if else  else if	[函数的末尾必须有 return]
	switch case    select
	for  range
	goto
defer:
	相当于finally 一定会执行的语句， 用于资源释放，
	defer file.close()
	defer func (){多行语句 }()
	defer语句 先进后出 【存在栈中】最后的语句先执行
panic() recover() :报告和处理运行时错误
	panic（）相当于abort()
	recover()?????
并发：
	不要通过共享内存来通信,而应该通过通信来共享内存。	
	channel是进程内的通信方式,因此通过channel传递对象的过程和调
		用函数时的参数传递行为比较一致,比如也可以传递指针等
	一个channel只能传递一种类型的值
	channel：
		var channame chan type
		example:var ch chan int , var m map[string] chan bool
		ch :=make(chan int)
		写入： ch <- value
		读取： value := <-ch
		close(ch)
		带缓冲的channel：
			c ：=make(chan int 1024)
		Go语言没有提供直接的超时处理机制,可以使用select解决
	select{
		case <-chan1:
		case chan2 <- 1:
		default:
			//无匹配处理
	}
go的编译命令：
	go run filename.go   //直接查看运行结果
	go build filename.go //生成filename可执行文件
		./filename
	xxx_test.go是对xxx.go的单元测试文件
执行go工程：
	将工程根目录添加到环境变量GOPATH中
		.bashrc  中添加 export GOPATH= 工程路径
		source ～/.bashrc
	cd /projectname/bin
	go build projectname
	go test packagename
包：
	fmt：打印函数
	log：基础的日志功能
	strings:
	
社区：	
	Go邮件组的地址为http://groups.google.com/group/golang-nuts	
	Go的中文邮件组为http://groups.google.com/group/golang-china
	http://groups.google.com/group/ecug
	Go语言的官方网站为 http://golang.org
	http://code.google.com/p/go/
	http://github.com/wonderfo/wonderfogo/wiki
	
*/
func add2(x,y int){  //没有return 即使返回了也丢弃（未验证）
	z :=x+y
	fmt.Println("result:",z)
}

func another_main()(n int,err error){
	//错误处理 有待完善48
	//panic(404)   //错误信息的第一条为出错位置 和python相反
	for i:=0;i<100;i++{
		go add2(i,i)
	}
	return 3,nil
}




//前一个函数的调用就在后一个函数里
//任意类型的不定参数
func anypara(length int,para ...interface{}){
	for _,one := range para{
		fmt.Println("any ",one)
	}
}
//不定参数的函数
func dontno_para(parameters ...int){ //无返回值的形式
	for _,para := range parameters{
		fmt.Println("is ",para)
	}
	anypara(10,"wo","我",3.14)
}
func just_do_it(a,b,c,d int) bool {
	dontno_para()
	dontno_para(1,2,3)
	dontno_para(1,2,3,4,5,7)
	return true
}
func show_used(a int,b string)(x int,y bool){
	value := just_do_it(1,2,3,4)  //声明了就得用
	if value {
		fmt.Println("声明了就得用阿！")
	}
	return 3,true
}
//参数列表 若多个参数相同 则可以在最后一个声明类型
func getname()(firstname,lastname,nickname string){
	show_used(7,"no used")
	return "Sun","Jonson","sen"
}
func main(){
	fmt.Println("你好，世界。hello world!")
	
	val1 :=200
	fmt.Println("打印方式1：" ,  val1)
	fmt.Printf("打印方式2：%d \n",val1)
	
//变量声明：
	var food string
	var (
		wolf string
		price int
	)
	open1 := true
	
//赋值
	food,wolf="enough to eat","like a dog yeah?"  //多重赋值
	price=100
	//不支持 x=3,y=4 支持x,y=3,4
//变量初始化
	var beef string = "deliseous"
	var weight=10
	time1 := 12  //声明的同时初始化 time1不能已被声明
	var complx complex64
	complx=3.2+ 3i
	fmt.Println(food,wolf[0],len(beef),price,beef,weight,time1,open1,complx)
	
//匿名变量
	_,_,nickname :=getname()
	fmt.Println(nickname)
	
//常量(无类型)
	const Pi float64 =3.141592632897492879
	const zero,one,two= 0.0,1.0,"2"
	const (
		size int64 = 1002
		eof = -1
	)
	fmt.Println(Pi,zero,one,two,size,eof,^2)
//数组:三种遍历方式
	array1 := [10] int {1,3,2,4,6,4,3,6,78,9}
	for i:=0;i<len(array1);i++ {
		fmt.Printf("value is %d. ",array1[i])
	}
	for i,v:=range array1 {   
	//rangerange 具有两个返回值,第一个返回值是元素的数组下标,第二个返回值是元素的值
		fmt.Println("array",i,"=",v)
	}
	fmt.Println(array1)
//切片
	myslice1 := make([]int ,5)   //长度为5 ，用0填充 的切片
	myslice2 := make([] int,5,10)  //长度为5 ，0填充，预留长度为10的切片
	myslice3 := [] int {1,2,3,4,5,6,7,8,9}
	fmt.Println("切片长度:",len(myslice2),"最多存储：",cap(myslice2) )
	myslice2= append(myslice2,1,2,1,7,6,4,6,5)
	fmt.Println("切片长度:",len(myslice2),"最多存储：",cap(myslice2) )
	myslice3=append(myslice3,myslice1...)
	fmt.Println(myslice3)
	copy(myslice1,myslice3)  //拷贝操作以短的为准
	fmt.Println(myslice1)
//字典：
	type pinfo struct {
		id string
		name string
	}
	var dict map[string] 	pinfo
	//dict=make(map[string] pinfo)
	//dict=make(map[string] pinfo,100)
	dict= map[string] pinfo {
		"7733":pinfo{"7733","Jack"},
	}  // 上一行最后的逗号不能少。
	dict["3388"]=pinfo{"3388","jonson"}
	person,ok := dict["3388"]
	if ok {  //改格式固定
		fmt.Println("find it .",person.name)
	}else
	{   // 可以
		fmt.Println("no found it.")
	}
	delete(dict,"7733")
//控制语句
	yourname :="Jonson"
	switch yourname {
		case "stark" :
			fmt.Println("my name is ",yourname)
		case "Jonson":
			fmt.Println("my name is ",yourname)
			fallthrough  //继续下一行
		case "Semen" :
			fmt.Println("my name is ",yourname)
		case "johnson":
			fmt.Println("my name is ",yourname)
		default:
			fmt.Println("my name is None ")
	}
	switch{
		case yourname == "jonson" :
			fmt.Println("my name is ",yourname)
		case yourname == "stark":
			fmt.Println("my name is ",yourname)
		default:
			fmt.Println("my name is no one")
	}
	sum := 0
	for {
		sum++
		if sum>1000{
			fmt.Println(sum)
			break
		}
		if sum ==100{
			fmt.Println(sum)
			continue
		}
	}
	//死循环：for{}
//匿名函数：
	noname :=func(x,y int) int{
		return x+y
	}
	fmt.Println("匿名函数：",noname(3,6) )
//闭包：与外部变量绑定的和函数？？？
	num :=10
	closure := func()(func() ){ //返回函数的情况
		i :=8
		return func(){fmt.Println("闭包被调用",i,num) }
	}( ) //为神魔此处要有小括号？？
	closure()
	num+=10
	closure()
	
	_,err := another_main()
	if err == nil {
		fmt.Println("函数调用正常。")
	}else{
		fmt.Println("函数调用出错！")
	}
//无需返回值
	
}

/*
变量相当于是对一块数据存储空间的命名
因此需要先牢记这样的规则:
	小写字母开头的函数只在本包内可见,大写字母开头的函数才
	能被其他包使用。这个规则也适用于类型和变量的可见性。
*/
