//时间：2017-11-17

//作者：sun jonson

//内容： 例子rust

/*
	rustc 源文件
*/

fn hello(){
	//hello world 程序
	println!("hello world:世界 你好");
	println!("I am a Rustacean!");
	print!("x=={1} ,{0}\n",10,"Alice");
	println!("{object} is not enough.",object="java");
}
fn tuple_used(){
	//元组的使用
	let pair=(1,2,3,4,5);
	println!("pair is {:?}",pair);
	let (a,b,c,d,e)=pair;
	println!("{},{:?},{:?},{:?},{:?}",a,b,c,d,e);
}
fn main(){
	hello();
	tuple_used();
}



