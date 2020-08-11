function hanshu(a, b, c) {
	c = 1
	if (c = 0)
	{
		print("条件语句执行!")
	}
	while(c < 10)
	{
		print "循环输出 " c
		c = c + 1
		a*=1
		b-=2
		
	}
	return (a-b+c);
}
function for_used()
{
	my_array[0] = "Partridge";
	my_array[1] = "pear";
	my_array[2] = "tree";
	my_array["David"] = "Cassidy";

	for ( my_index in my_array ) {
		print my_index "=" my_array[my_index];
	}
	
	print "排序:"
	my_array[0] = "Partridge";
	my_array[1] = "pear";
	my_array[2] = "tree";
	my_array[13] = "Cassidy";

	min = 0; max = 0;
	for ( my_index in my_array ) {
		if (my_index+0 < min) min = my_index;
		if (my_index+0 > max) max = my_index;
	}
	for (i=min; i<= max; i++) {
		if (i in my_array) {
			print i "=" my_array[i];
		}
		if (!(i in my_array)) {
			print i " is unset.";
		}
	}
}
#============================================================
function count_elements(input_array)
{
    counter=0;
    for (word in input_array) {
        counter++;
    }
    return counter;
}

function join1(input_array, separator) {
        string = "";        first = 1;

        # Note: this preserves order, but does not
        # work with nonnumeric or sparse arrays.

        for (i=1; i<=count_elements(input_array); i++) {
                if (first) first = 0;
                else string = string separator;
                string = string input_array[i];
        }

	# This works on Mac OS X, but is not fully portable
	# because of bugs in GNU Awk's implementation of length().
        # for (i=1; i<=length(input_array); i++) {
                # if (first) first = 0;
                # else string = string separator;
                # string = string input_array[i];
        # }
        return string;
}
function join2(input_array, separator) {
	string = "";
	first = 1;
	for (i in input_array) {
		if (first) first = 0;
		else string = string separator;
		string = string input_array[i];
	}
	return string;
}
#=========================================================
function shuzu() #数组操作
{
	arr_len = split( "Mary lamb freezer good nothing.", my_array, / / );
	for (word in my_array) {
		copy_array[word] = my_array[word];
	}
	for (word in copy_array) {print copy_array[word];}
	
	#join 连接
	print join1(my_array,"-")
	print "另一种join:"
	print join2(my_array,"*")
	
	#数组删除
	my_1array["purple"] = "Partridge";
	my_1array["good"] = "pear";
	my_1array["majesties"] = "tree";
	my_1array["fruited"] = "Cassidy";
	
	mykey = "ed";
	delete my_1array["good"];
	delete my_1array[mykey];
	print join2(my_1array,"+")
}

function io()
{
#写
	print "This is a test." | "/usr/bin/tail -n 1";
	print "This is only a test." | "/usr/bin/tail -n 1";
	close("/usr/bin/tail -n 1");
	print "Yikes!" | "/usr/bin/tail -n 1";

	print "This is another test" > "/tmp/testfile-awk"
	print "This is yet another test entirely" > "/tmp/testfile-awk"
	
#读

	getline < "/tmp/testfile-awk";
	print "The record was " $0;

	"/bin/echo 'This is a test line'" | getline
	print "The second record was " $0;
}

#命令行传入的参数
function canshu()
{
	for (i=0; i<ARGC; i++) {
        print "ARGUMENT " i " is " ARGV[i];
    }
}

BEGIN {
	#执行处 注释
	#print hanshu(3, 200);
	#for_used();
	#shuzu()
	canshu()
	print "PATH IS: " ENVIRON["PATH"]; #打印环境变量
	
}
