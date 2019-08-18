#linux日常使用日志


[TOC]

---
##经验
- 文件操作前先备份！！！！！！！！！
- 长期运行的程序一定要有进度提示{file,terminal,notify均可}
- 

---
##  2019





- 基本系统操作
	- / 目录下有61_2999个文件,70678个目录  [不包括无妨问权限的]
	- last reboot || last shutdown :查看重启,关机日志
	- iftop -i 网络名 {可以用ifconfig得到}
	- shred : 安全删除文件
	- 系统上的语言环境列表: locale -a
---
- linux系统启动分析:systemd-analyze
	- systemd-analyze :时间分析
	- systemd-analyze blame:启动时长统计
	- systemd-analyze dot >file.dot
	- systemd-analyze plot >file.svg //使用浏览器打开
---
- 时间:timedatectl:时钟同步
	- time:程序运行时间
	- timeout:类似time
	- times: 获取进程时间
	- time-admin: 时间管理工具(GUI)
- 发送桌面通知:
	-  notify-send -i 图标路径  "主题" "内容"
---

- usb:
	- 安装usbrelay,usbauth,usbview
	- 卸载usbauth,usbview
- u盘格式化命令:
	- sudo mkfs.vfat  /dev/sdb1
	- 注意:格式化之前要umount (xfce右键卸载)
		- 否则出现:mkfs.vfat: /dev/sdb1 contains a mounted filesystem.
	- 格式化添加用户权限:chmod 777 u盘名/
	- 查看设备名:sudo fdisk -l
	- 查看usb : lsusb
---
	
- C++:错误:未定义的引用;
	- 在make 文件中的添加lib库 例如 -lboost_regex
	- 自编译的库要添加路径: 例如 install_path/boost/lib/
---
- markdown文件编辑器:
	- retext:功能不全，没有toc
	- remarkable：中间插入反应迟钝
		- 没有中文界面
		- 无法直接导入css
	- 导出为pdf时换页：
		- <div STYLE="page-break-after: always;"\></div\>
		
---		
		
- pyplot 无法显示中文？
```
conda安装路径=/lib/python3.6/site-packages/matplotlib/mpl-data/

1.下载*.ttf字体;将ttf放到 conda安装路径/fonts/ 下

2.删除  ~/.cache/matplotlib 目录
3.运行pyplot程序,形成新的 上一步的目录

4.打开  ~/.cache/matplotlib/fontlist-v300.json
5.修改 "defaultFont": 下的 "ttf" :conda安装路径/fonts/下载文件名.ttf
6.在"ttflist":中寻找 "下载文件名.ttf " 所对应的 "name" 键的值(如HYYanKaiW)
	
7.修改  conda安装路径/matplotlubrc
	#(去掉#号)font.family          : sans-serif
	#(去掉#号)font.sans-serif     : HYYanKaiW (此处为你安装的字体名)

```

---


- 6-6:
	- 周期查看机器温度: watch -d -n 1 sensors
1. 4-26:安装uget

1. 3-9：
	- 文件解锁：sudo chattr -i filenamne
	- 文件枷锁：sudo chattr +i filename
	- 查看安装的软件数量：
		- apt list --installed | wc -l
	- 查看安装的软件内容：
		- dpkg-query -l > tmp.tx
1. 2-2:  
	- 安装graphviz
	
---
	
##2018
1. 2018-12-17：
	- upower 查看电源状态
	- 安装aria2c
- 2018-12-13： 
	- typora 和retext 的菜单栏不见了？
		- retext通过重启解决，typora未解决
	- ------有用的命令--------  
	sudo netstat -antp  //查看建立的网络连接  
	df -h //查看分区使用状况  
	last -1   //查看开关机信息  
	 crontab -l   //查看当前用户的计划任务服务  
	 du -sh /home/asen   //查看指定目录大小  
	 lspci    lscpu   lsmod  
	lastlog //登陆日志  
	
	- -----防火墙------  
	service ufw status verbose  
	service ufw start  
	sudo ufw enable  //开启ubuntu fairwall   
	sudo ufw default deny  //关闭所有外部访问本机  
	sudo ufw allow 53 允许外部访问53端口(tcp/udp)  
	sudo  ufw logging on|off  //开关日志  
	/etc /ufw/：里面是一些ufw的环境设定文件， \  
		如 before.rules、及 for ip6 的 before6.rule 及 after6.rules。\  
		这些文件一般按照默认的设置进行就ok  
	sudo ufw allow ssh    
	sudo systemctl start ufw  /.开机自动启动  
	sudo ufw logging low|medium|high  //指定日志级别  
	日志文件在/var/log/ufw.log  
	sudo ufw allow in port #允许port入站  
	sudo ufw allow out port #允许port出站

- 2018-12-11： git使用： 

	git add . //添加更改  
	git commit -m “注释”  //提交更改  
	git push  + 密码  //同步到远程仓库   
	
- 2018-12-8：
linux 下 firefox安装flash player  

	下载压缩包  
	解压libflashplayer.so  
	移动so文件到 ～/.mozlia/plugins/  
	重启firefox  
	
- 2018-12-5：git 链接github方便工程管理
	- install git
	-  ssh-keygen -t rsa -C "3075921643@qq.com"    //生成密钥
	-  git config --global user.name "Jonson-Sun"
	-  git config --global user.email "3075921643@qq.com"
	- ssh -T -v git@github.com  //查看链接是否成功
	- 注意1：公钥里面的内容全部复制 包括邮箱
	- 注意2：加密钥匙的文件名字就叫 id_rsa.
	- git config --global core.editor mousepad  //配置默认的文本编辑器
	- 甜食是装在另一个胃里的。
	- 

1. 12-5:   
	- 查看ubuntu版本号： lsb_release -a
- 11-23
	- sudo apt install libgl1-mesa-dev
- 11-22：
	- man info help
	-  type time file
- 2018-11-18：
	- systemctl mask saned
	- sudo systemctl disable cron
	- sudo cp /var/log/*  /home/asen/tmp  //日志备份
- TypeError: 'numpy.ndarray' object is not callable
	 - you used [ object.name() ] as a function
	 - but it should be like this : [ object.name ]
1. 10-16：
	- install cloc ：代码行统计
1. 10-14:
	- 重启网络服务
	- service network-manager restart
	- ifconfig enp3s0 down && ifconfig enp2s0 up：
1. 10-5:
	1. 六种查看端口信息的方式:
		- ss
		- netstat
		- lsof
		- fuser
		- nmap
		- systemctl
	- ubuntu截图快捷键:
		- 整个屏幕:prtsc
		- 某个区域截图:shift+prtsc
		- 当前窗口的截图:alt + prtsc
		- ctrl+上述命令保存到剪贴板
		- 无ctrl保存到默认目录
1. 9-20：
	lshw：list hardware
	lsof: list open file
	ltrace:  dynamic link trace
	mlocate:   文件定位
	strace：system call trace
	

- 4-3:
	编译tensorflow的方法:
		优点:可以去除FMA提示
		https://www.jianshu.com/p/b1faa10c9238
- 4-1:
	大文件的思考:
		1\100G远超内存的文件
		2\ read ,readlines 全都失效
		3解决方法:每次都处理定长的数据.
- 文献资源查找:
	http://sci-hub.tw
	http://sci-hub.hk
	80.82.77.83/84

	必应学术
	谷歌学术
	搜狗学术
	百度学术

	中国知网
		非学生链接: http://61.178.127.9:8080/auth/welcome.do
				帐号密码:bylib
	小木虫
	http://en.booksee.org
	http://booksc.org
	http://libgen.io    update everyday
	http://avxhm.se 
	http://ebookee.org 


- 3-31:
```
	检查linux硬件信息
		uname -a
		lshw
		lsblk :usful
		lscpu
		lspci
		lsusb
		lsscsi
		fdisk -l
	gdb  -p  process id
	python的视频编辑模块: moviepy
	python使用sqlite3:
		使用批量操作:executemany
		大部分时间你不需要使用游标
		游标可被迭代
		使用上下文管理器
		使用编译指示 pragmas
		推迟索引创建
		使用占位符来插入python值
	二进制数据处理:bitstream python
		c语言扩展的python模块
	bash快捷键清单:
		ctrl + A :移动光标到行首
		ctrl+B :光标向前移动一个字符
		ctrl+C :停止当前运行的命令
		ctrl +d: delete
		ctrl+ e :移动到行末
		ctrl+f:光标向后移动一个字符
		ctrl+ G :退出历史搜索模式
		ctrl+h: backspace
		ctrl+j:enter  === ctrl+M
		ctrl+k:删除光标厚的所有字符
		ctrl+l:清空屏幕
		ctrl+n:历史命令中的下一行
		ctrl+o: 运行反向搜索时发现的命令
		ctrl+p:显示历史命令的上一条
		ctrl+r:向后搜索历史记录
		ctrl+s:向前搜索历史记录
		ctrl+t:交换最厚的两个字符
		ctrl+u:删除光标前的所有字符
		ctrl+v:逐字显示输入的下一字符
		ctrl+w:删除光标前的一个单词
		ctrl+x:列出当前单词的文件名补全
		ctrl+y:回复上一个删除或剪切的条目
		ctrl+z"停止当前命令ctrl+[ ===esc
		!! 重复上一命令
		esc +t :交换最后两个单词
```
- 6-2:
	- earlyoom: 杀死占用内存最多的进程。
	- 在电脑内存站满，无相应的状态下,适用于电脑內村经常站满，
	- 系统无相应，必须重启的状态。

- 3-30：
```
	uptime命令：
		load average 最近一分钟的平均负载，五分钟，15分钟。
	linux系统监测工具：
		top || glances || cat /proc/loadavg
	nproc ：查看cpu核心数
	lscpu：
```
- 3-27:
	- 回力标
	- iftop 安装使用; sudo iftop -B
- 3-26:
	- gdb调试python程序:
		- 安装python-gdb :查看python的栈信息
		- gdb python 
		- run name.py
		- attach thread-id   #程序得运行中
		- thread gdb命令:线程间转换
- 3-24:
	- 修复fcitx输入法
		- have bug in ibus:gi no glib  
		- 一个输入法三个小时才调整到完美!!
	- 安装texstudio:中文尚未实现
	- xfce文档:http://docs.xfce.org/xfce/start
	- [月色真美,你真皮]
	- 安装apt graphviz 可视化cnn 的model
		- pip install pylot graphviz 


#经验总结
1. info目录误删：
```
	E: python-gobject-2: installed python-gobject-2 package post-installation script subprocess returned error exit status 127
	E: python-cairo: 0.0000:installed python-cairo:amd64 package post-installation script subprocess returned error exit status 127
	E: python-gtk2: 依赖关系问题 - 仍未被配置
	E: gimp: 依赖关系问题 - 仍未被配置
```
到/var/lib/dpkg/info目录下，删除以上出现包名字开头的文件执行：sudo apt-get -f install

- 视频会议：jitsi meet
	https://jitsi.org/what-is-jitsi/
- 查看系统内存：
	cat /proc/meminfo
	vmstat -s
- 归档压缩文件夹：
	压缩：tar -zcvf newfile dir-name //c-创建；
	解压：tar -zxvf newfile  //x-解压；v-显示过程；z-压缩；
- 查看网络配置：
	nmcli
	netstat -s
	route
	ip neighbor
	ip route
	
- 字符编码转换：
	file filename  //查看文件类型信息
	iconv -l  //已知的字符编码
	iconv -f gbk -t utf-8  file1 > file2
	
- python包：
	2D游戏：pygame
	3D动画，游戏：pyglet
	数据包探测分析：scapy
	windows交互：pywin32
	http库：requests
	python图形库：pillow
	
- gpg 验证软件包的完整性：
	- 1、 gpg --verify   *.xz.sig   *.xz     #获得钥匙号
	- 2、添加公钥：
		sudo apt-key adv --keyserver keyserver.ubuntu.com --recv ID
		sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys  ID  #OK
		gpg --keyserver subkeys.pgp.net --recv-keys （8bit钥匙号）
	- 3、gpg --armor --export （8bit钥匙号） | apt-key add -     #导入密钥  NO USED
		gpg --keyserver keys.gnupg.net  --search C3C45C06
	- 4、验证：
		gpg --verify --verbose  *.sig  *
- linux跟踪器:
		ftrace \  perf_events  \  eBPF \ systemtap
		LTTng \ ktap  \dtrace4linux \ OEL Dtrace \ sysdig
- python时间处理库:delorean
- debian安全配置:
	https://www.debian.org/doc/manuals/securing-debian-howto/index.en.html
- sklearn 中文文档:
	https://github.com/apachecn/scikit-learn-doc-zh
	sklearn.apachecn.org
- tensorflow中文文档
	http://cwiki.apachecn.org/pages/viewpage.action?pageId=10030122
- pytorch中文文档:
	http://pytorch.apachecn.org/cn/0.3.0/apachecn-learning-group.html
- AI：人工智能：acknowledge + inference:知识推断
- 随机数：
	/dev/urandom :伪随机数生成器
	/dev/random: 真随机数生成器，缺乏熵的时候停止
	查看熵池的大小：
		cat /proc/sys/kernel/random/poolsize
	池中熵的数量
		cat /proc/sys/kernel/random/entropy_avail
	命令行下：echo $RANDOM
- arp -a 
	查看arp协议的高速缓存
- netstat -rn
    查看本机的内核IP路由表：
- 段错误:
	内存访问被拒绝
- prefect language understand is AI-complete
- 物以类聚,人以群分: 在理解词语意思的时候,词语的上下就决定了词语的意思吗?
- 进程间通信：
	1、信号： kill -9  id
	2、管道： ls | tail -10
	3、逃接字：socket通信
	4、消息队列：windows 鼠标单击事件
	5、信号量
	6、共享内存
- 当强linux内核使用的模块：
	lsmod ： ls modules
- dpkg: 处理软件包 cups-browsed (--configure)时出错：
 			子进程 已安装 post-installation 脚本 返回错误状态 5
	解决方案：
	 sudo mv /var/lib/dpkg/info /var/lib/dpkg/info_backup
	 sudo mkdir /var/lib/dpkg/info/
	·「info_backup文件夹还没有删除·」
# systemd
---
	systemctl list-unit-files --type=service  //查看服务
	systemctl status：//激活的单元
	systemctl list-units //现在运行中的服务
	systemctl list-units --type=target //所有的目标文件
	systemctl enable httpd  //启用服务
	systemctl disable httpd  //禁用服务
	systemctl is-enabled httpd  //查看服务状态
	systemd-analyze blame //系统服务启动时间分析
	systemd-analyze  //系统启动时间
	systemd-analyze critical-chain   //关键链
- systemctl start httpd.service
- systemctl restart httpd.service
- systemctl stop httpd.service
- systemctl reload httpd.service
- systemctl status httpd.service
---
	systemctl list-unit-files --type=mount  //系统挂载服务
	systemctl mask/unmask  service //屏蔽或者启用服务
	acpid：电源服务
	avahi：查找网络
	cups：打印系统
	systemctl get-default ：获取当前运行等级
	journalctl -b ；显示本次登陆的全部日志
	sudo journalctl --vacuum-size=100M //使全部日志大小小于100m
	journalctl -fp err  //获取error 日志消息
	systemctl status systemd-modules-load //查看启动失败

---
	查看当前用户的crontab，输入 crontab -l；
	编辑crontab，输入 crontab -e；
	删除crontab，输入 crontab -r
---
## 补录
--------
- 2017-10-6 下午
-命名及去除重命名
	- alias cls=clear
	- alias la='ls -la'
	- unalias cls
-----------------------------------
### 不要在系统目录使用{否则会宕机}
- 删除空目录
	- find -type d -empty | xargs -n 1 rm -d
- 删除空文件
	- find -type d -empty | xargs -n 1 rm -f
- 查找空目录
	- find -type d -empty
- 查找空文件并删除空文件
	- find . -name "*" -type f -size 0c | xargs -n 1 rm -f
- Man Page Sections:
	-     man1/ Section 1: General commands
	-     man2/ Section 2: System calls
	-  man3/ Section 3: Library functions
	-     man4/ Section 4: Special files
	-     man5/ Section 5: File formats and conventions
	-     man6/ Section 6: Games and screensavers
	-     man7/ Section 7: Miscellaneous
	-     man8/ Section 8: System administration commands and daemons
	- ***************
- gprof 分析工具


---


#end