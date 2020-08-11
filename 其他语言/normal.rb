#coding = utf-8
# $KCODE = 'u'   #功能同上


# 本文件为ruby基本知识点
=begin
 gem 是ruby 的包管理器  gem help
 查看版本 ruby -v
	 ruby的性能和python差不多,julia更快
 	语法不如python简洁;琐碎的地方太多.
 	但有python不具备的多线程
 结论:
 	点到为止,了解就行了	
=end
Aa=100_000  #大写字母开头 常量:不能放在函数中
def first_func()
	puts"hello word ! ! ! "
	puts "你好 世界！"

	puts Aa,0x12,0123,12 #分割线，十六进制，八进制，十进制

	$colors = { "red" => 0xf00, "green" => 0x0f0, "blue" => 0x00f }
	#$ 开头全局变量
	$colors.each do |key, value|
		print key, " is ", value, ";"
	end
end

class Customer
   @@no_of_customers=0  # 类变量
   def initialize(id, name, addr)
      @cust_id=id  #实例变量
      @cust_name=name
      @cust_addr=addr
     end
   def display_details()
      puts "Customer id #@cust_id"
      puts "Customer name #@cust_name"
      puts "Customer address #@cust_addr"
   	  end
   def total_no_of_customers()
      @@no_of_customers += 1
      puts "Total number of customers: #@@no_of_customers"
     end
end
def obj_use() 
	# 创建对象
	cust1=Customer.new("1", "John", "Wisdom Apartments, Ludhiya")
	cust2=Customer.new("2", "Poul", "New Empire road, Khandala")
	 
	# 调用方法
	cust1.display_details()
	cust1.total_no_of_customers()
	cust2.display_details()
	cust2.total_no_of_customers()
end
def special_use()
	#two point  or three point
	(0..15).each do |asd|
		print asd ,","
		end
	print"\n"
	(0...15).each do |asd|
		print asd ,","
		end
end
def condition()	
	(defined? variable) ? (puts"已定义") : ( puts"none define!")

	x=1
	if x > 2
	   puts "x 大于 2"
	elsif x <= 2 and x!=0
	   puts "x 是 1"
	else
	   puts "无法得知 x 的值"
	end

	$age =  5
	case $age
	when 0 .. 2
		puts "婴儿"
	when 3 .. 6
		puts "小孩"
	when 7 .. 12
		puts "child"
	when 13 .. 18
		puts "少年"
	else
		puts "其他年龄段的"
	end

	foo = false
	bar = true
	quu = false
	 
	case
	when foo then puts 'foo is true'
	when bar then puts 'bar is true'
	when quu then puts 'quu is true'
	end
end

def three_loop()
	$i = 0
	$num = 5
	 
	while $i < $num/2  do
	   puts("在while循环语句中 i = #$i" )
	   $i +=1
	end
	until $i > $num  do
	   puts("在until循环语句中 i = #$i" )
	   $i +=1;
	end
	for i in 0..5
	   puts "局部变量的值为 #{i}"
	end
end
#break 正常。continue-》next
#redo 回到块内首行继续执行
def test1(a1="Ruby", a2="Perl")
   puts "编程语言为 #{a1}"
   puts "编程语言为 #{a2}"
end  #函数最后的一个语句即为返回值
#undef test  #取消定义
#test "C", "C++"
alias bart test1   #重命名
#bart
module Mokuaiming   #定义一个模块
	def test
	   yield 5
	   puts "在 test 方法内"
	   yield 100
	end
#test {|i| puts "你在块 #{i} 内"}	
end
#require 'moral'  #导入模块
#include 在类内倒入模块

BEGIN { 
	  # BEGIN 代码块
	  #puts "程序开始时执行的代码块"
} 
	 
END { 
	  # END 代码块
	  #puts "程序结束时执行的代码块"
}
def some_thing()
	name1 = "Joe"
	name2 = "Mary"
	puts "你好 #{name1},  #{name2} 在哪?"

	desc2 = %q|Ruby 的字符串可以使用 '' 和 ""。|
	puts desc2

	names = Array.new(4, "mac") 
	puts "#{names}"

	hash1 = Hash["a" => 100, "b" => 200]
	puts "#{hash1['a']}"

	time2 = Time.now
	puts "当前时间 : " + time2.inspect
end
=begin
    # 这段代码抛出的异常将被下面的 rescue 子句捕获
    raise 'A test exception.'
rescue
    # 这个块将捕获所有类型的异常
    retry  # 这将把控制移到 begin 的开头
else
   #.. 如果没有异常则执行
ensure 
   #.. 最后确保执行
   #.. 这总是会执行
=end

def func1
   i=0
   while i<=2
      puts "thread-1"
      sleep(2)
      i=i+1
   end
end
 
def func2
   j=0
   while j<=2
      puts "thread-2"
      sleep(1)
      j=j+1
   end
end


def multi_thread() 
	t1=Thread.new{func1()}
	t2=Thread.new{func2()}
	t1.join
	t2.join
end
#multi_thread()



#if __FILE__=$0   #？？？

#！/home/asen/ruby253/bin/ruby
#根据book 《ruby programming》学习ruby程序设计语言
#单行注释
=begin 
	不能放在程序里，end 必须单独一行
	多行注释的方法
=end
def first_function()
	#基本概念
	puts  "hello word"
	print "hello world"," nothing","\n"
	#($name) 全局变量标志
	#you can't define const in function
	# Asd=Asd+1 #error: dynamic constant assignment
	#capital letters(upcase) is constant value
	name=gets.chomp  #输入
	puts name.upcase!  # 叹号改变原对象，否则不改变（传参）
	puts "your name is #{name} "
	#ruby will return the last expression evaluated
end

def condition()
	numbe_a= 10*rand
	#condition case 1
	if numbe_a < 5 
		puts "low five #{numbe_a}"
	elsif  numbe_a > 6
		puts "big six #{numbe_a}"
	else
		puts "five or six #{numbe_a}"
	end
	#condition case 2:need notice 
	unless numbe_a > 5
		puts "number is <= 5,#{numbe_a}"
	else
		puts "number is >5,#{numbe_a}"
	end
	#condition case 3 : one line
	if numbe_a < 3 then puts"number is less 3" end
	#condition 4
	num=numbe_a.round
	case 
		when num < 5 then puts"num < 5"
		when num > 5 then puts"num > 5"
		when num == 5 then puts "num is 5"
	end
	case num
		when 0..3 then puts"<4" 
		when 3..7 then puts"num between 3-7"
		when 7..8 then puts">7"
		else
			puts"except"
	end
end

def loopcase()
	numbe_a=(10*rand).round
  #loop case 1
	while numbe_a > 1 #item=array.next
		puts"first loop #{numbe_a}",' '
		numbe_a -= 1
		#break
	end
  #loop case 2
	until numbe_a > 9
		puts"second loop #{numbe_a}",' '
		numbe_a += 1
	end
  #loop case 3
  	(1..8).each do |item|
  		puts item																																																																																									
  	end
end

def use_yield()
	yield
	yield #use code block example
end
#use_yield {puts"your yield used}

def data_type()
  #Everything is an object
  	asd = 1234435
  	puts asd.object_id
  	print 1.class,'asqwed'.class,(:+.class),nil.class,"\n"
  #array
  	array1=[1,2,3,4,5,6,7,8]
  	puts array[1..3]
  #hash
	ash = { :leia => "Princess from Alderaan", :han => "Rebel without acause", 
		:luke => "Farmboy turned Jedi"}
	ash1={"a":1,"b":2,"c":3}
	puts ash[:leia]
  # mod:%,+=,-=,*=,/=,**=
	1.upto(5) {|x| print x,","}
  	5.downto(1) {|x| print x ,"-"}
  	5.step(50, 5) {|x| print x," "}
  	puts""
  	puts 123.to_s ,4.5.to_i,5.to_f
  #String
  	if "jieba is ok !".match("jieba")
		puts "regular expression".sub("regular","regex")#first occurrence to sub
	end
	puts"sun jonson".hash  #hash value
	puts 'A'.ord ,66.chr  #65:ascii
  	puts "待连接"+"字符串"
	puts "reverse".reverse,"AAAAA".sum
  	puts 'a'<'z'
  #operate:and or
	bool_1=true
	bool_1== true ? (puts"true"):(puts"false")

end	



#ruby class 
class Grape
	@@number=55  #class variable
	def initialize(p)
		@@number=p
		@heavy=6
	end
	def eat
		puts "good"
	end
	def self.color
		return "red"
	end
	def num
		puts @@number
	end
	
end
class My_grape < Grape
	def eat
		super
		puts"just so so!"
	end
end


def class_used()
	Grape.color
	asd=Grape.new(66)
	puts asd.num
	qwe=My_grape.new(55)
	qwe.eat

end



def test_speed()
	last_num=100000000
	tmp=1.01
	for i in (1..last_num)
		tmp+=i
		#tmp*=i
		tmp/=i
	end
	puts "result is  ",tmp
end
#test_speed()

#first_function()
#condition()
#loopcase()
#data_type()
#class_used()
=begin
	module: File ,Dir,marshal(serializing),
		regexp,
=end
