#！ -*- utf8 -*-

import matplotlib.pyplot as plt
import numpy as np

# Fixing random state for reproducibility
np.random.seed(19680801)

def 四叶草():
	x = np.arange(0.0, 50.0, 2.0)
	y = x ** 1.3 + np.random.rand(*x.shape) * 30.0
	s = np.random.rand(*x.shape) * 800 + 500

	plt.scatter(x, y, s, c="g", alpha=0.5, marker=r'$\clubsuit$',
				label="Luck")
	plt.xlabel("Leprechauns")
	plt.ylabel("Gold")
	plt.legend(loc='upper left')
	plt.show()

def 工具栏():
	fig, axs = plt.subplots(2, 2)

	axs[0, 0].imshow(np.random.random((100, 100)))

	axs[0, 1].imshow(np.random.random((100, 100)))

	axs[1, 0].imshow(np.random.random((100, 100)))

	axs[1, 1].imshow(np.random.random((100, 100)))

	plt.subplot_tool()
	plt.show()

	
def 公式():
	fig, ax = plt.subplots()

	ax.plot([1, 2, 3], 'r', label=r'$\sqrt{x^2}$')
	ax.legend()

	ax.set_xlabel(r'$\Delta_i^j$', fontsize=20)
	ax.set_ylabel(r'$\Delta_{i+1}^j$', fontsize=20)
	ax.set_title(r'$\Delta_i^j \hspace{0.4} \mathrm{versus} \hspace{0.4} '
				 r'\Delta_{i+1}^j$', fontsize=20)

	tex = r'$\mathcal{R}\prod_{i=\alpha_{i+1}}^\infty a_i\sin(2 \pi f x_i)$'
	ax.text(1, 1.6, tex, fontsize=20, va='bottom')

	fig.tight_layout()
	plt.show()
	
公式()








'''
	对文本进行分词

'''

from jieba import cut
def 一行分词(lines):
	tmp=""
	for line in lines:
		tmp+=" ".join(cut(line))
		#tmp+='\n'
	return tmp

def test():
	filename="baidutext.txt"
	result_str=""
	
	file_io=open(filename,"r")
	lines_str=file_io.readlines()
	result_str= 一行分词(lines_str)
	file_io.close()
	with open("bsidu_sep.txt","w") as io:
		io.write(result_str)
	print("文件分词完成!")

#test()





def test_speed():
	last_num=100000000
	tmp=1.0
	for i in range(1,last_num+1):
		tmp+=i
		tmp*=i
		tmp/=i
	print("result is ",tmp)

#test_speed()


#import nltk
def NLP_use():
	#nltk.corpus.gutenberg.fileids()
	# from nltk.corpus import webtext #聊天文本
	text = nltk.word_tokenize("And now for something completely different")#分词
	nltk.pos_tag(text)  #标注

	tree1 = nltk.Tree('NP', ['it','done'])
	tree2 = nltk.Tree('NP', ['the', 'rabbit'])
	tree3 = nltk.Tree('VP', ['chased', tree2])
	tree4 = nltk.Tree('root',[tree1,tree3])
	print(tree4)
	tree4.draw()


	#nltk.help.upenn_brown_tagset('NN')  method 1
	#nltk. name .readme  method 2
	#nltk.app.wordnet()
"""
	python module:
		spacy:NLP
		inspect:理解代码
		sh:python中的bash
		UUID:唯一标识
		better-excepotion:异常美化
		livepython:可视化追踪python代码
		Gain:web爬虫框架
		ipyvolume:3D可视化

"""




from math import log2
def  file_deal(dir_name):
	with open(dir_name,'r',encoding="utf8") as F:
		File_line=F.readlines()  # readlines don't forget "s"
		for line in File_line:
			if len(line)<5:
				continue
			yield line[9:-11]

def compute_entropy_less_memory():
	print("start...")
	#dir_name="/media/asen/软件/PROJECT/pynlp/词向量/corpus.txt"
	dir_name="/home/asen/下载/enwiki.xml"
	str_list=[]
	word_freq_table=dict()
	Global_entropy,all_num=0,0

	print("table build start ...;")
	for line in file_deal(dir_name):
		for word in line:
			if word is '':
				continue
			if word in word_freq_table:
				word_freq_table[word]+=1
			else:
				word_freq_table[word]=1

	word_num=len(word_freq_table)
	print("词频表的长度为",word_num)
	print("计算分母...")
	for i in word_freq_table.values():
		all_num+=i
	print("计算熵...")	
	entropy=lambda freq :-(freq/all_num)*log2(freq/all_num)
	for freq_num in word_freq_table.values():
		Global_entropy+=entropy(freq_num)
	print("the entropy is : ",Global_entropy)

#compute_entropy_less_memory()







import matplotlib.pyplot as plt 
import matplotlib
from scipy.interpolate import spline
import numpy as np
from math import sqrt

def huatu():
	print("draw graph:")
	num=100
	x=np.array([i for i in range(50,num)])
	#y=np.array([-(i*i-10*i-30) for i in x])
	y=np.array([ 1/sqrt(1-i**2/num**2)for i in x])
	#plt.title('product-get')
	plt.xlabel("product out")
	plt.ylabel("get")
	
	xnew = np.linspace(x.min(),x.max(),100)
	power_smooth = spline(x,y,xnew)
	plt.plot(xnew,power_smooth)
	plt.show()
	
# huatu()






def get_y(end):
	tmp=0
	while end !=0:
		tmp+=1/(end*end)
		end-=1
	return tmp
	
from math import pi
def math_problem():
	''' pi^2/6=1/1+1/4+1/9+1/16 ...  巴塞尔问题'''
	infine=(pi*pi)/6
	print("start ...",infine)
	END_num=300
	x=np.array([i for i in range(1,END_num)])
	y1=np.array([get_y(i) for i in range(1,END_num)]) 
	y2=np.array([infine for i in range(1,END_num)])
	y3=np.array(y2-y1)
	plt.plot(x,y1,linestyle = '--',label="y1=sum")
	plt.plot(x,y2,label="y2=(pi^2)/2")
	plt.plot(x,y3,label="y2-y1")
	plt.legend()
	plt.show()
	
	return True
#math_problem()	







#显示特殊字符:
# 启发:int('2600',base=16) int('26ff',base=16)
#chr(9728-9983) :html中的特殊符号
def show_utf8_chr(num):
	num=int(num,base=16)
	return chr(num)
def test():
	count=0
	while count<10:
		count+=1
		num=input('输入16进制数:')
		char_one=show_utf8_chr(num)
		print(char_one)

def test2():
	#遍历所有的字符并保存到文件
	all=('0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f')
	tmp=''
	count=0
	for a in all:
		for b in all:
			for c in all:
				for d in all:
					#if count > 3000:
					#	break
					tmp=a+b+c+d;
					char_one=show_utf8_chr(tmp)
					print(char_one,end=' ')
					tmp='';count+=1;

#test2()








from ctypes import cdll
import os

def first_used():
    #参数为生成的.so文件所在的绝对路径
    ab_path=os.getcwd() + '/obj1.so'
    libtest = cdll.LoadLibrary(ab_path)
    print('直接用方法名进行调用')
    asd='Hello,I am qs ,!@#$%^&,琼森查看不语言符号'
    libtest.cprint(asd,len(asd) )
    print(libtest.add(2011,2010) ,asd)


#first_used()

#sqlite3 used learn the detail of database

from sqlite3 import connect
def common_operate():
    link1=connect('phone.db')  # ':memory：' the DB is live in the RAM
    l1_csr=link1.cursor()
    l1_csr.execute("create table phone_table (label real,opinion text)")
        #l1_csr.executemany("(?,?,?)",iter_obj)
    l1_csr.commit()  #save your change
    l1_csr.close()  # release the connect

'''
    http://www.w3schools.com/sql/
    https://www.sqlite.org
    1、高效率：不用cursor
    2、使用 with
'''