#!/home/asen/julia110/bin/julia

#================================
wh=8
using PyPlot

#plot(qwe1[1:wh],"b^--")
#plot(qwe2[1:wh],"yo--")
plot(qwe3[1:wh]-qwe2[1:wh],"ro--")
show()





	多进程和多线程 : still need to do

#using Distributed
#using SharedArrays
#addprocs(3)
#pmap
#fetch @spawn
#@everywhere 
#@spawnat

		a = randn(1000)
		@parallel (+) for i=1:100000
		f(a[randi(end)])
		end

		M = {rand(1000,1000) for i=1:10}
		pmap(svd, M)

function use1_multi()
	sum_all()=begin
		tmp=0
		tmp=@distributed (+) for iter in num_list
			iter	
		end
		return tmp
	end
	num_list=Array{Int64}([rand(1:1000) for i=1:1000000])
end

#@time use1_multi()
=============================#
function 同步与异步演示()
	@sync begin
		for id=1:10
			@async begin sleep(rand(1:5));@info  "$id is  a thead id";	end
		end
	end
end
#同步与异步演示()


#
#	使用傅立叶变换进行分词
#		1.形成 字符,结果->数字化表示 转换
#		2.形成输入输出数据: 
#			2384,1903....
#			0	,1	,....
#		3.





#
#	使用递归方式的傅立叶函数
# 1.递归一次,表达式增加一项
# 2.复数表示:complex(x,y);数据存储使用 字典
# 3.正样本标注:分词:只标记词语的结束
#
#问题:
#	如何形成表达式?
#
function 万能表示函数(深度=10)
	参数=[] #n
	for i=1:深度
		push!(参数,(rand(-10:10),rand(-10:10),i))
	end
	result=0
	for (a,b,c) in 参数
		result+=a*exp(-2π*b*im/深度)
	end
end


function 随机数生成(c::Channel)
	while true
		put!(c,rand())
	end
end
function 计数(随机数管)
	计数=0
	加和=0
	for 随机数 in 随机数管
		加和+=随机数
		if 加和>1
			return 计数
		end
		计数+=1
	end
end
function 主函数()
	随机数管=Channel(随机数生成)
	单次结果=0
	结果=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	for i=1:1_0000_000
		单次结果=计数(随机数管)
		#print(单次结果)
		if 0<单次结果<20
			结果[单次结果]+=1
		else
			println(单次结果)
		end
	end
	for i=1:20
		println(i,"次 : ",结果[i])
	end
end
#主函数()
#====
1次 : 5000551
2次 : 3332264
3次 : 1250392
4次 : 333559
5次 : 69379
6次 : 11836
7次 : 1766
8次 : 215
9次 : 33
10次 : 4
11次 : 1

C++重写:

#include<cstdlib>
#include <QString>
#include<vector>
using namespace std;
double get_rand()
{
    double tmp=(rand()%10000) /10000.0;
    //qDebug()<< tmp; //#include<QDebug>
    return tmp ;
}
unsigned long get_count()
{
    vector<double> rand_result(30);
    unsigned long count=0;
    double sum=0.0;
    for(unsigned long j=0;j<30;j++)
    {
        rand_result[j]=get_rand();
    }
    for(auto iter:rand_result)
    {
        if(sum<=1.0){
            sum+=iter;
            count++;
        }
        else{
            break;
        }
    }
    return count ;
}
void call_other_func(vector<long>& result)
{
    /*
     * 计算x个随机数(0~1)相加后大于1
     * 的分布及 期望(均值)
     *
     *结果:vector<long>& result
     *
     *
     */
    //srand(123); //get_rand
    long cishu=1000000;

    for(int i=0;i<cishu;i++){
        unsigned long tmp=get_count();
        if(tmp<15)
            result[tmp]+=1;
    }
    double value=0.0;//期望;该结果未返回
    int i=0;
    for(auto val:result){
        value+=(val/1000000.0)*i;
        i++;
    }
}

====#

#湍流，又称为乱流、紊流或扰流
#当流速很小时，流体分层流动，互不混合，称为层流

#曲线的内接正方形
# 证明或推翻，在平面中的任意一条简单封闭曲线上，总能找到四个点，它们恰能组成一个正方形。


#环形跑道难题
#有一个环形跑道，总长为 1 个单位。n 个人从跑道上的同一位置出发，沿着跑道顺时针一直跑下去。每个人的速度都是固定的，但不同人的速度不同。证明或推翻，对于每一个人，总会有一个时刻，他与其他所有人的距离都不小于 1/n

#排序问题加强版
#有 n 个盒子，从左至右依次编号为 1, 2, …, n 。第 1 个盒子里放两个编号为 n 的小球，第 2 个盒子里放两个编号为 n – 1的小球，以此类推，第 n 个盒子里放两个编号为 1 的小球。每一次，你可以在相邻两个盒子中各取一个小球，交换它们的位置。为了把所有小球放进正确的盒子里，最少需要几次交换？

#多面体的展开
#证明或推翻，总可以把一个凸多面体沿着棱剪开，展开成一个简单的平面多边形。

#用平面镜拼成的多边形
# 证明或推翻，对于任意一个内壁全是镜面的多边形，总能在里面找到一个点，使得位于这个点的光源可以照亮整个多边形内部

#Thrackle 猜想
#如果一个图中，每条边都与其它所有边相交恰好一次（顶点处相接也算相交），这个图就叫做一个 thrackle 。问，是否存在边数大于顶点数的 thrackle 图？

#Venn 图
#是否随便什么样的 n 个集合的 Venn 图都可以扩展到 n + 1 个集合{的venn图}呢


#令 U 是一个有限集，S1 , S2 , … , Sn 都是 U 的非空子集，它们满足任意多个集合的并集仍然在这些集合里。证明，一定能找到某个元素，它出现在了至少一半的集合里。