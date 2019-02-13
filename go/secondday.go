//go 语言程序

// date：

// author ： Sun Jonson

// content: 第一个并发的go语言程序

package main

import "fmt"  //必须是双引号
//  **********子函数定义***********

func onethread(ch chan int,mark int){
	
	stop_point:= 0
	for i:=0;i<=1000000000;i++{
		if i ==100000000{
			stop_point++
			i=0
		}
		if stop_point>=20{
			fmt.Println("函数 onethread 结束。", mark)
			break
		}
	}
	
	ch <- mark  //写入通道  ！！一定要放在最后！！
}
func twothread(){
	stop_point:= 0
	for i:=0;i<=1000000000;i++{
		if i ==100000000{
			stop_point++
			i=0
		}
		if stop_point>=20{
			fmt.Println("函数 twothread 结束。")
			break
		}
	}
}


//***********enter port*******
func main(){
	//程序执行入口
	channel_ctrl := make([]chan int,16)  //16为建立的线程数0-15
	
	for i:=0;i<len(channel_ctrl);i++{
		channel_ctrl[i]=make(chan int)
		go onethread(channel_ctrl[i],i+1)  //建立新线程后继续执行
		//fmt.Printf(" %d ",i)
	}
	for _,ch := range(channel_ctrl){
		<-ch  //从通道中写出
	}
	twothread()
	
	fmt.Println("函数执行结束")
	//无返回值
}




