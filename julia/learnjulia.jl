
# (#号表示单行注释)Single line comments start with a hash (pound) symbol.
#= Multiline comments can be written
   by putting '#=' before the text  and '=#'
   after the text. They can also be nested.
   (多行注释)
=#

####################################################
## 1. Primitive Datatypes and Operators
## (基本数据类型和操作符)
####################################################

# Everything in Julia is an expression.(Julia中的一切都是表达式)

# There are several basic types of numbers.(几个基本的数字类型)
typeof(3)       #(整数) => Int64
typeof(3.2)     # (浮点数)=> Float64
typeof(2 + 1im) #(复数) => Complex{Int64}
typeof(2 // 3)  #(分数) => Rational{Int64}

# All of the normal infix operators are available.(所有的普通中綴运算符可用)
1 + 1      # => 2
8 - 1      # => 7
10 * 2     # => 20
35 / 5     # => 7.0
10 / 2     # => 5.0  # dividing integers always results in a Float64(整型除法的结果一直是浮点数)
div(5, 2)  # => 2    # for a truncated result, use div  (对于截断(去小数位)的结果使用div()函数)
5 \ 35     # => 7.0
2^2        # => 4    # power, not bitwise xor  (幂运算,而不是按位异或)
12 % 10    # => 2

# Enforce precedence with parentheses (用括号强制执行优先级)
(1 + 3) * 2  # => 8

# Julia (unlike Python for instance) has integer under/overflow  (julia有整型的下溢/上溢)
10^19      # => -8446744073709551616
# use bigint or floating point to avoid this   (使用大  整型数或者浮点数 来避免上述情况)
big(10)^19 # => 10000000000000000000
1e19       # => 1.0e19
10.0^19    # => 1.0e19

# Bitwise Operators   (位运算)
~2         # => -3 # bitwise not  (按位取反)
3 & 5      # => 1  # bitwise and  (按位"与")
2 | 4      # => 6  # bitwise or  (按位"或")
xor(2, 4)  # => 6  # bitwise xor (按位异或)
2 >>> 1    # => 1  # logical shift right  (逻辑右移)
2 >> 1     # => 1  # arithmetic shift right  (算数右移)
2 << 1     # => 4  # logical/arithmetic shift left  (逻辑/算数左移)

# Use the bitstring function to see the binary representation of a number.
# 使用bitstring 函数来查看数值的二进制表示
bitstring(12345)
# => "0000000000000000000000000000000000000000000000000011000000111001"
bitstring(12345.0)
# => "0100000011001000000111001000000000000000000000000000000000000000"

# Boolean values are primitives  (布尔值是基元)
true
false

# Boolean operators
# 布尔运算
!true   # => false
!false  # => true
1 == 1  # => true
2 == 1  # => false
1 != 1  # => false
2 != 1  # => true
1 < 10  # => true
1 > 10  # => false
2 <= 2  # => true
2 >= 2  # => true
# Comparisons can be chained  (链式比较)
1 < 2 < 3  # => true
2 < 3 < 2  # => false

# Strings are created with "  (使用引号" 创建字符串)
"This is a string."

# Character literals are written with '  (单字符使用单引号')
'a'

# Strings are UTF8 encoded. Only if they contain only ASCII characters can
# they be safely indexed.
#字符串使用utf-8编码,只有它存储ASCII字符时能够被安全索引
ascii("This is a string")[1]  
# 结果=> 'T': ASCII/Unicode U+0054 (category Lu: Letter, uppercase)
# Julia indexes from 1  (julia索引从1开始)
# Otherwise, iterating over strings is recommended (map, for loops, etc).
#另外,迭代字符串推荐使用map,for循环等等
# String can be compared lexicographically (字符串可以按照词典顺序比较)
"good" > "bye" # => true
"good" == "good" # => true
"1 + 2 = 3" == "1 + 2 = $(1 + 2)" # => true

# $ can be used for string interpolation:  
# $可以用于串内插
"2 + 2 = $(2 + 2)" # => "2 + 2 = 4"
# You can put any Julia expression inside the parentheses.
#你可以把julia表达式放到圆括号内
# Printing is easy  (打印输出是简单的)
println("I'm Julia. Nice to meet you!") # => I'm Julia. Nice to meet you!

# Another way to format strings is the printf macro from the stdlib Printf.
#另一种格式化字符串的方式是来自stdlib Printf中的printf宏
using Printf
@printf "%d is less than %f\n" 4.5 5.3  # => 5 is less than 5.300000


####################################################
## 2. Variables and Collections
## 变量和集合(广义)
####################################################

# You don't declare variables before assigning to them.
# 你不能在赋值之前声明变量
someVar = 5  # => 5
someVar  # => 5

# Accessing a previously unassigned variable is an error
#访问之前未赋值的变量是一个错误
try
    someOtherVar  # => ERROR: UndefVarError: someOtherVar not defined
catch e
    println(e)
end

# Variable names start with a letter or underscore.
#使用字母或下划线作为变量名的开始
# After that, you can use letters, digits, underscores, and exclamation points.
#之后可以连接字母\数字\下划线和感叹号!
SomeOtherVar123! = 6  # => 6

# You can also use certain unicode characters  (你也可以使用unicode字符)
☃ = 8  # => 8
# These are especially handy for mathematical notation
# 这些都是特别方便的数学符号
2 * π # => 6.283185307179586

# A note on naming conventions in Julia:
#Julia中有关命名约定的注释：
#
# * Word separation can be indicated by underscores ('_'), but use of
#   underscores is discouraged unless the name would be hard to read
#   otherwise.
#	可以使用下划线类来连接独立的词语
#	但不鼓励使用下划线除非名字读起来困难
#
# * Names of Types begin with a capital letter and word separation is shown
#   with CamelCase instead of underscores.
#	类型名使用大写字母开头并且独立的词语使用驼峰命名法来代替下划线连接
# * Names of functions and macros are in lower case, without underscores.
#	函数名和宏名是小写,没有下划线
# * Functions that modify their inputs have names that end in !. These
#   functions are sometimes called mutating functions or in-place functions.
#	修改输入的函数使用!结尾;这些函数有时叫做可变函数或者in-place函数

# Arrays store a sequence of values indexed by integers 1 through n:
# Array存储一个从1到n的可索引的值序列
a = Int64[] # => 0-element Array{Int64,1}

# 1-dimensional array literals can be written with comma-separated values.
# 一维array量可以用逗号分隔 值
b = [4, 5, 6] # => 3-element Array{Int64,1}: [4, 5, 6]
b = [4; 5; 6] # => 3-element Array{Int64,1}: [4, 5, 6]
b[1]    # => 4
b[end]  # => 6

# 2-dimensional arrays use space-separated values and semicolon-separated rows.
#二维array使用空格分隔值且分号分隔行
matrix = [1 2; 3 4] # => 2×2 Array{Int64,2}: [1 2; 3 4]

# Arrays of a particular type  (特定类型的array)
b = Int8[4, 5, 6] # => 3-element Array{Int8,1}: [4, 5, 6]

# Add stuff to the end of a list with push! and append!
#使用push!和append!在列表的末尾添加成员
# By convention, the exclamation mark '!'' is appended to names of functions
# that modify their arguments
#按照惯例,感叹号!放在函数名的后面来修改他们的参数
push!(a, 1)    # => [1]
push!(a, 2)    # => [1,2]
push!(a, 4)    # => [1,2,4]
push!(a, 3)    # => [1,2,4,3]
append!(a, b)  # => [1,2,4,3,4,5,6]

# Remove from the end with pop  (使用pop从尾部删除)
pop!(b)  # => 6
b # => [4,5]

# Let's put it back  (放到后面)
push!(b, 6)  # => [4,5,6]
b # => [4,5,6]

a[1]  # => 1  # remember that Julia indexes from 1, not 0!  (julia索引从1开始,不是0)

# end is a shorthand for the last index. It can be used in any
# indexing expression
# end是最后一个索引适用任何索引表达式
a[end]  # => 6

# we also have popfirst! and pushfirst!  (我们也有弹出第一个和压入第一个)
popfirst!(a)  # => 1 
a # => [2,4,3,4,5,6]
pushfirst!(a, 7)  # => [7,2,4,3,4,5,6]
a # => [7,2,4,3,4,5,6]

# Function names that end in exclamations points indicate that they modify
# their argument.
#函数名使用感叹号表明修改其参数
arr = [5,4,6]  # => 3-element Array{Int64,1}: [5,4,6]
sort(arr)   # => [4,5,6]
arr         # => [5,4,6]
sort!(arr)  # => [4,5,6]
arr         # => [4,5,6]

# Looking out of bounds is a BoundsError (越界错误BoundsError)
try
    a[0] 
    # => ERROR: BoundsError: attempt to access 7-element Array{Int64,1} at 
    # index [0]
    # => Stacktrace:
    # =>  [1] getindex(::Array{Int64,1}, ::Int64) at .\array.jl:731
    # =>  [2] top-level scope at none:0
    # =>  [3] ...
    # => in expression starting at ...\LearnJulia.jl:180
    a[end + 1] 
    # => ERROR: BoundsError: attempt to access 7-element Array{Int64,1} at 
    # index [8]
    # => Stacktrace:
    # =>  [1] getindex(::Array{Int64,1}, ::Int64) at .\array.jl:731
    # =>  [2] top-level scope at none:0
    # =>  [3] ...
    # => in expression starting at ...\LearnJulia.jl:188
catch e
    println(e)
end

# Errors list the line and file they came from, even if it's in the standard
# library. You can look in the folder share/julia inside the julia folder to
# find these files.
#错误列出了行号和所在文件即便是独立的库; 您可以在文件夹share/julia中的julia文件夹中查找这些文件 
# You can initialize arrays from ranges  (你可以按照范围初始化数组)
a = [1:5;]  # => 5-element Array{Int64,1}: [1,2,3,4,5]
a2 = [1:5]  # => 1-element Array{UnitRange{Int64},1}: [1:5]

# You can look at ranges with slice syntax.  (你可以使用slice语法查看范围)
a[1:3]  # => [1, 2, 3]
a[2:end]  # => [2, 3, 4, 5]

# Remove elements from an array by index with splice!  (用splice!来删除array中的元素)
arr = [3,4,5]
splice!(arr, 2) # => 4 
arr # => [3,5]

# Concatenate lists with append!  (使用append!连接列表)
b = [1,2,3]
append!(a, b) # => [1, 2, 3, 4, 5, 1, 2, 3]
a # => [1, 2, 3, 4, 5, 1, 2, 3]

# Check for existence in a list with in  (使用in类检查存在性)
in(1, a)  # => true

# Examine the length with length  (用length来求长度)
length(a)  # => 8

# Tuples are immutable.(元组是不可变的)
tup = (1, 2, 3)  # => (1,2,3)
typeof(tup) # => Tuple{Int64,Int64,Int64}
tup[1] # => 1
try
    tup[1] = 3  
    # => ERROR: MethodError: no method matching 
    # setindex!(::Tuple{Int64,Int64,Int64}, ::Int64, ::Int64)
catch e
    println(e)
end

# Many array functions also work on tuples(许多array函数也用于元组)
length(tup) # => 3
tup[1:2]    # => (1,2)
in(2, tup)  # => true

# You can unpack tuples into variables (你也可以解包元组到变量中)
a, b, c = (1, 2, 3)  # => (1,2,3)  
a # => 1
b # => 2
c # => 3

# Tuples are created even if you leave out the parentheses  (不用圆括号也可以创建元组)
d, e, f = 4, 5, 6  # => (4,5,6)
d # => 4
e # => 5
f # => 6

# A 1-element tuple is distinct from the value it contains (单元素元组不同于其包含的值)
(1,) == 1 # => false
(1) == 1  # => true

# Look how easy it is to swap two values  (交换两个值多容易)
e, d = d, e  # => (5,4) 
d # => 5
e # => 4

# Dictionaries store mappings (字典存储映射)
emptyDict = Dict()  # => Dict{Any,Any} with 0 entries

# You can create a dictionary using a literal  (可以使用文字创建字典)
filledDict = Dict("one" => 1, "two" => 2, "three" => 3)
# => Dict{String,Int64} with 3 entries:
# =>  "two" => 2, "one" => 1, "three" => 3

# Look up values with []  (使用[]查找值)
filledDict["one"]  # => 1

# Get all keys  (得到所有的键)
keys(filledDict)
# => Base.KeySet for a Dict{String,Int64} with 3 entries. Keys:
# =>  "two", "one", "three"
# Note - dictionary keys are not sorted or in the order you inserted them.

# Get all values  (得到所有的值)
values(filledDict)
# => Base.ValueIterator for a Dict{String,Int64} with 3 entries. Values: 
# =>  2, 1, 3
# Note - Same as above regarding key ordering.

# Check for existence of keys in a dictionary with in, haskey
#使用in和haskey检查健的存在性
in(("one" => 1), filledDict)  # => true
in(("two" => 3), filledDict)  # => false
haskey(filledDict, "one")     # => true
haskey(filledDict, 1)         # => false

# Trying to look up a non-existent key will raise an error
# 尝试找一个不存在的健将抛出异常
try
    filledDict["four"]  # => ERROR: KeyError: key "four" not found
catch e
    println(e)
end

# Use the get method to avoid that error by providing a default value
# 使用通过提供默认值的get方法来避免上面的错误
# get(dictionary, key, defaultValue)
get(filledDict, "one", 4)   # => 1
get(filledDict, "four", 4)  # => 4

# Use Sets to represent collections of unordered, unique values
# 使用 Sets 来表示无序唯一值的集合
emptySet = Set()  # => Set(Any[])
# Initialize a set with values  (用值初始化集合)
filledSet = Set([1, 2, 2, 3, 4])  # => Set([4, 2, 3, 1])

# Add more values to a set  (向集合添加元素)
push!(filledSet, 5)  # => Set([4, 2, 3, 5, 1])

# Check if the values are in the set  (检查值是否在集合中)
in(2, filledSet)   # => true
in(10, filledSet)  # => false

# There are functions for set intersection, union, and difference. (集合的交\并\差函数)
otherSet = Set([3, 4, 5, 6])         # => Set([4, 3, 5, 6])
intersect(filledSet, otherSet)      # => Set([4, 3, 5])
union(filledSet, otherSet)          # => Set([4, 2, 3, 5, 6, 1])
setdiff(Set([1,2,3,4]), Set([2,3,5])) # => Set([4, 1])

####################################################
## 3. Control Flow  (流程控制)
####################################################

# Let's make a variable  (定义变量)
someVar = 5

# Here is an if statement. Indentation is not meaningful in Julia.
# 这是if语句,julia中的缩进没有意义
if someVar > 10
    println("someVar is totally bigger than 10.")
elseif someVar < 10    # This elseif clause is optional.  (elseif语句可选)
    println("someVar is smaller than 10.")
else                    # The else clause is optional too.  (else语句也是可选的)
    println("someVar is indeed 10.")
end
# => prints "some var is smaller than 10"

# For loops iterate over iterables.  (for 循环迭代 可迭代项)
# Iterable types include Range, Array, Set, Dict, and AbstractString.
# 可迭代类型包括 range,array,set,dict,abstractstring
for animal = ["dog", "cat", "mouse"]
    println("$animal is a mammal")
    # You can use $ to interpolate variables or expression into strings
    #你也可以用$来插入变量和表达式到字符串中
end
# => dog is a mammal
# => cat is a mammal
# => mouse is a mammal

# You can use 'in' instead of '='.  (你可以使用in来代替=)
for animal in ["dog", "cat", "mouse"]
    println("$animal is a mammal")
end
# => dog is a mammal
# => cat is a mammal
# => mouse is a mammal

for pair in Dict("dog" => "mammal", "cat" => "mammal", "mouse" => "mammal")
    from, to = pair
    println("$from is a $to")
end
# => mouse is a mammal
# => cat is a mammal
# => dog is a mammal

for (k, v) in Dict("dog" => "mammal", "cat" => "mammal", "mouse" => "mammal")
    println("$k is a $v")
end
# => mouse is a mammal
# => cat is a mammal
# => dog is a mammal

# While loops loop while a condition is true (while条件为真,进行循环)
let x = 0
    while x < 4
        println(x)
        x += 1  # Shorthand for x = x + 1  (x=x+1 的简便写法)
    end
end
# => 0
# => 1
# => 2
# => 3

# Handle exceptions with a try/catch block  (try/catch块捕获异常)
try
    error("help")
catch e
    println("caught it $e")
end
# => caught it ErrorException("help")

####################################################
## 4. Functions (函数)
####################################################

# The keyword 'function' creates new functions (关键字function创建新函数)
# function name(arglist)
#   body...
# end
function add(x, y)
    println("x is $x and y is $y")

    # Functions return the value of their last statement  (函数返回最后一个语句的值)
    x + y
end

add(5, 6)
# => x is 5 and y is 6
# => 11

# Compact assignment of functions  (函数的紧凑赋值)
f_add(x, y) = x + y  # => f_add (generic function with 1 method)
f_add(3, 4)  # => 7

# Function can also return multiple values as tuple (函数也可以用元组返回多个值)
fn(x, y) = x + y, x - y # => fn (generic function with 1 method)
fn(3, 4)  # => (7, -1)

# You can define functions that take a variable number of positional arguments
# 你可以定义接受不定数量位置参数的函数
function varargs(args...)
    return args
    # use the keyword return to return anywhere in the function (在函数任意位置使用return返回)
end
# => varargs (generic function with 1 method)

varargs(1, 2, 3)  # => (1,2,3)

# The ... is called a splat.  (...被称为splat(劈啪声)   )
# We just used it in a function definition.  (我们只把它用于函数定义)
# It can also be used in a function call, (它也可以用在函数调用)
# where it will splat an Array or Tuple's contents into the argument list.
# 它将把数组或元组的内容展开到参数列表中。
add([5,6]...)  # this is equivalent to add(5,6)  (等价于add(5,6))

x = (5, 6)  # => (5,6)
add(x...)  # this is equivalent to add(5,6)


# You can define functions with optional positional arguments  (可以使用可选位置参数定义函数)
function defaults(a, b, x=5, y=6)
    return "$a $b and $x $y"
end
# => defaults (generic function with 3 methods)

defaults('h', 'g')  # => "h g and 5 6"
defaults('h', 'g', 'j')  # => "h g and j 6"
defaults('h', 'g', 'j', 'k')  # => "h g and j k"
try
    defaults('h')  # => ERROR: MethodError: no method matching defaults(::Char)
    defaults()  # => ERROR: MethodError: no method matching defaults()
catch e
    println(e)
end

# You can define functions that take keyword arguments  (也可以使用关键字参数)
function keyword_args(;k1=4, name2="hello")  # note the ;
    return Dict("k1" => k1, "name2" => name2)
end
# => keyword_args (generic function with 1 method)

keyword_args(name2="ness")  # => ["name2"=>"ness", "k1"=>4]
keyword_args(k1="mine")     # => ["name2"=>"hello", "k1"=>"mine"]
keyword_args()              # => ["name2"=>"hello", "k1"=>4]

# You can combine all kinds of arguments in the same function  (你也可以把各种参数放到同一个函数中)
function all_the_args(normalArg, optionalPositionalArg=2; keywordArg="foo")
    println("normal arg: $normalArg")
    println("optional arg: $optionalPositionalArg")
    println("keyword arg: $keywordArg")
end
# => all_the_args (generic function with 2 methods)

all_the_args(1, 3, keywordArg=4)
# => normal arg: 1
# => optional arg: 3
# => keyword arg: 4

# Julia has first class functions (julia 有一级函数(可在任何其他语言结构的地方出现) )
function create_adder(x)
    adder = function (y)
        return x + y
    end
    return adder
end
# => create_adder (generic function with 1 method)

# This is "stabby lambda syntax" for creating anonymous functions (匿名函数)
(x -> x > 2)(3)  # => true

# This function is identical to create_adder implementation above. (与上面实现相同)
function create_adder(x)
    y -> x + y
end
# => create_adder (generic function with 1 method)

# You can also name the internal function, if you want  (内部函数可用)
function create_adder(x)
    function adder(y)
        x + y
    end
    adder
end
# => create_adder (generic function with 1 method)

add_10 = create_adder(10) # => (::getfield(Main, Symbol("#adder#11")){Int64}) 
                          # (generic function with 1 method)
add_10(3) # => 13


# There are built-in higher order functions  (内置高阶函数)
map(add_10, [1,2,3])  # => [11, 12, 13]
filter(x -> x > 5, [3, 4, 5, 6, 7])  # => [6, 7]

# We can use list comprehensions  (列表推导)
[add_10(i) for i = [1, 2, 3]]   # => [11, 12, 13]
[add_10(i) for i in [1, 2, 3]]  # => [11, 12, 13]
[x for x in [3, 4, 5, 6, 7] if x > 5] # => [6, 7]

####################################################
## 5. Types  (类型)
####################################################

# Julia has a type system.  (julia是一个类型系统)
# Every value has a type; variables do not have types themselves.(每一个值都有类型,变量自身没有类型)
# You can use the `typeof` function to get the type of a value.(typeof函数得到值的类型)
typeof(5)  # => Int64

# Types are first-class values  (类型是一级值)
typeof(Int64)     # => DataType
typeof(DataType)  # => DataType
# DataType is the type that represents types, including itself.(DataType是表示类型的类型,包含自己)

# Types are used for documentation, optimizations, and dispatch.(类型用于文档\优化\分派)
# They are not statically checked. (其不进行静态检查)

# Users can define types  (用户可以定义类型)
# They are like records or structs in other languages. (类似其他语言的records 和structs)
# New types are defined using the `struct` keyword.  (新类型使用struct定义)

# struct Name
#   field::OptionalType
#   ...
# end
struct Tiger
    taillength::Float64
    coatcolor  # not including a type annotation is the same as `::Any`(无类型批注等价于"::Any")
end

# The default constructor's arguments are the properties
# of the type, in the order they are listed in the definition
# 默认构造函数的参数是该类型的属性，它们按定义中列出的顺序排列
tigger = Tiger(3.5, "orange")  # => Tiger(3.5,"orange")

# The type doubles as the constructor function for values of that type (双类型用作类型值)
sherekhan = typeof(tigger)(5.6, "fire")  # => Tiger(5.6,"fire")

# These struct-style types are called concrete types  (struct风格类型称作具体类型)
# They can be instantiated, but cannot have subtypes.  (可以实例化,但不能有子类型)
# The other kind of types is abstract types. (另一种类型是抽象类)

# abstract Name
abstract type Cat end  # just a name and point in the type hierarchy (只是层次结构中的名字和点)

# Abstract types cannot be instantiated, but can have subtypes. (抽象类不能实例化,但有子类)
# For example, Number is an abstract type (例如Number是一个抽象类)
subtypes(Number)  # => 2-element Array{Any,1}:
                  # =>  Complex
                  # =>  Real
subtypes(Cat)  # => 0-element Array{Any,1}

# AbstractString, as the name implies, is also an abstract type
# AbstractString顾名思义是一个抽象类型
subtypes(AbstractString)  # => 4-element Array{Any,1}:
                          # =>  String
                          # =>  SubString
                          # =>  SubstitutionString
                          # =>  Test.GenericString

# Every type has a super type; use the `supertype` function to get it.
#每一个类型都有一个父类 使用'supertype'来得到
typeof(5) # => Int64
supertype(Int64)    # => Signed
supertype(Signed)   # => Integer
supertype(Integer)  # => Real
supertype(Real)     # => Number
supertype(Number)   # => Any
supertype(supertype(Signed))  # => Real
supertype(Any)      # => Any
# All of these type, except for Int64, are abstract. (所有这些类型除了Int64都是抽象类)
typeof("fire")      # => String
supertype(String)   # => AbstractString
# Likewise here with String  (String同样)
supertype(SubString)  # => AbstractString

# <: is the subtyping operator  (<:是子类运算符)
struct Lion <: Cat  # Lion is a subtype of Cat  (lion是cat的子类)
    maneColor
    roar::AbstractString
end

# You can define more constructors for your type  (也可以定义更多的构造函数)
# Just define a function of the same name as the type
# and call an existing constructor to get a value of the correct type
# 只需定义与类型同名的函数，并调用现有构造函数以获取正确类型的值
Lion(roar::AbstractString) = Lion("green", roar)
# This is an outer constructor because it's outside the type definition
# 这是一个外部构造函数,因为它定义在类型定义之外
struct Panther <: Cat  # Panther is also a subtype of Cat  (Panther也是cat的子类)
    eyeColor
    Panther() = new("green")
    # Panthers will only have this constructor, and no default constructor.
    #Panther将只有这个构造函数,并没有默认的构造函数
end
# Using inner constructors, like Panther does, gives you control
# over how values of the type can be created.
# When possible, you should use outer constructors rather than inner ones.
# 使用内部构造函数可以控制该类型的值的创建方式
####################################################
## 6. Multiple-Dispatch  (多分派)
####################################################

# In Julia, all named functions are generic functions (julia中所有命名的函数是通用函数)
# This means that they are built up from many small methods (这意味着它们由许多小函数构成)
# Each constructor for Lion is a method of the generic function Lion. 
# (每一个Lion的构造函数都是泛型函数Lion的方法)

# For a non-constructor example, let's make a function meow: (对一个无构造函数的例子,写一个meow)

# Definitions for Lion, Panther, Tiger
function meow(animal::Lion)
    animal.roar  # access type properties using dot notation
end

function meow(animal::Panther)
    "grrr"
end

function meow(animal::Tiger)
    "rawwwr"
end

# Testing the meow function  (测试meow函数)
meow(tigger)  # => "rawwwr"
meow(Lion("brown", "ROAAR"))  # => "ROAAR"
meow(Panther()) # => "grrr"

# Review the local type hierarchy  (本地类型层次结构)
Tiger   <: Cat  # => false
Lion    <: Cat  # => true
Panther <: Cat  # => true

# Defining a function that takes Cats  (cats作为参数的函数定义)
function pet_cat(cat::Cat)
    println("The cat says $(meow(cat))")
end
# => pet_cat (generic function with 1 method)

pet_cat(Lion("42")) # => The cat says 42
try
    pet_cat(tigger) # => ERROR: MethodError: no method matching pet_cat(::Tiger)
catch e
    println(e)
end

# In OO languages, single dispatch is common; (在面向对象语言,单分派是常见的)
# this means that the method is picked based on the type of the first argument.
#  这意味着该方法是根据第一个参数的类型选择的。 
# In Julia, all of the argument types contribute to selecting the best method.
#在Julia中，所有参数类型都有助于选择最佳方法
# Let's define a function with more arguments, so we can see the difference
# 我们来定义一个有多个参数的函数,以便于我们可以看到不同
function fight(t::Tiger, c::Cat)
    println("The $(t.coatcolor) tiger wins!")
end
# => fight (generic function with 1 method)

fight(tigger, Panther())  # => The orange tiger wins!
fight(tigger, Lion("ROAR")) # => The orange tiger wins!

# Let's change the behavior when the Cat is specifically a Lion
# 当猫科动物里的狮子时,我们改变行为
fight(t::Tiger, l::Lion) = println("The $(l.maneColor)-maned lion wins!")
# => fight (generic function with 2 methods)

fight(tigger, Panther())  # => The orange tiger wins!
fight(tigger, Lion("ROAR")) # => The green-maned lion wins!

# We don't need a Tiger in order to fight (我们不需要老虎来打架)
fight(l::Lion, c::Cat) = println("The victorious cat says $(meow(c))")
# => fight (generic function with 3 methods)

fight(Lion("balooga!"), Panther())  # => The victorious cat says grrr
try
    fight(Panther(), Lion("RAWR"))  
    # => ERROR: MethodError: no method matching fight(::Panther, ::Lion)
    # => Closest candidates are:
    # =>   fight(::Tiger, ::Lion) at ...
    # =>   fight(::Tiger, ::Cat) at ...
    # =>   fight(::Lion, ::Cat) at ...
    # => ...
catch e
    println(e)
end

# Also let the cat go first  (让猫上)
fight(c::Cat, l::Lion) = println("The cat beats the Lion")
# => fight (generic function with 4 methods)

# This warning is because it's unclear which fight will be called in:
# 本提醒是因为该调用哪个fight是不清晰的
try
    fight(Lion("RAR"), Lion("brown", "rarrr"))
    # => ERROR: MethodError: fight(::Lion, ::Lion) is ambiguous. Candidates:
    # =>   fight(c::Cat, l::Lion) in Main at ...
    # =>   fight(l::Lion, c::Cat) in Main at ...
    # => Possible fix, define
    # =>   fight(::Lion, ::Lion)
    # => ...
catch e
    println(e)
end
# The result may be different in other versions of Julia (其他版本的julia结果可能不同)

fight(l::Lion, l2::Lion) = println("The lions come to a tie") 
# => fight (generic function with 5 methods)
fight(Lion("RAR"), Lion("brown", "rarrr"))  # => The lions come to a tie


# Under the hood  (在底层)
# You can take a look at the llvm  and the assembly code generated.
#你可以查看LLVM和生成的汇编代码。
square_area(l) = l * l  # square_area (generic function with 1 method)

square_area(5)  # => 25

# What happens when we feed square_area an integer?(当我们给square_area提供一个整型会发生什么?)
code_native(square_area, (Int32,), syntax = :intel)
	#         .text
	# ; Function square_area {
	# ; Location: REPL[116]:1       # Prologue
	#         push    rbp
	#         mov     rbp, rsp
	# ; Function *; {
	# ; Location: int.jl:54
	#         imul    ecx, ecx      # Square l and store the result in ECX
	# ;}
	#         mov     eax, ecx
	#         pop     rbp           # Restore old base pointer
	#         ret                   # Result will still be in EAX
	#         nop     dword ptr [rax + rax]
	# ;}

code_native(square_area, (Float32,), syntax = :intel)
    #         .text
    # ; Function square_area {
    # ; Location: REPL[116]:1
    #         push    rbp
    #         mov     rbp, rsp
    # ; Function *; {
    # ; Location: float.jl:398
    #         vmulss  xmm0, xmm0, xmm0  # Scalar single precision multiply (AVX)
    # ;}
    #         pop     rbp
    #         ret
    #         nop     word ptr [rax + rax]
    # ;}

code_native(square_area, (Float64,), syntax = :intel)
    #         .text
    # ; Function square_area {
    # ; Location: REPL[116]:1
    #         push    rbp
    #         mov     rbp, rsp
    # ; Function *; {
    # ; Location: float.jl:399
    #         vmulsd  xmm0, xmm0, xmm0  # Scalar double precision multiply (AVX)
    # ;}
    #         pop     rbp
    #         ret
    #         nop     word ptr [rax + rax]
    # ;}

# Note that julia will use floating point instructions if any of the arguments are floats.
# 有浮点参数那julia将会使用浮点指令
# Let's calculate the area of a circle
circle_area(r) = pi * r * r     # circle_area (generic function with 1 method)
circle_area(5)  # 78.53981633974483

code_native(circle_area, (Int32,), syntax = :intel)
    #         .text
    # ; Function circle_area {
    # ; Location: REPL[121]:1
    #         push    rbp
    #         mov     rbp, rsp
    # ; Function *; {
    # ; Location: operators.jl:502
    # ; Function *; {
    # ; Location: promotion.jl:314
    # ; Function promote; {
    # ; Location: promotion.jl:284
    # ; Function _promote; {
    # ; Location: promotion.jl:261
    # ; Function convert; {
    # ; Location: number.jl:7
    # ; Function Type; {
    # ; Location: float.jl:60
    #         vcvtsi2sd       xmm0, xmm0, ecx     # Load integer (r) from memory
    #         movabs  rax, 497710928              # Load pi
    # ;}}}}}
    # ; Function *; {
    # ; Location: float.jl:399
    #         vmulsd  xmm1, xmm0, qword ptr [rax] # pi * r
    #         vmulsd  xmm0, xmm1, xmm0            # (pi * r) * r
    # ;}}
    #         pop     rbp
    #         ret
    #         nop     dword ptr [rax]
    # ;}

code_native(circle_area, (Float64,), syntax = :intel)
    #         .text
    # ; Function circle_area {
    # ; Location: REPL[121]:1
    #         push    rbp
    #         mov     rbp, rsp
    #         movabs  rax, 497711048
    # ; Function *; {
    # ; Location: operators.jl:502
    # ; Function *; {
    # ; Location: promotion.jl:314
    # ; Function *; {
    # ; Location: float.jl:399
    #         vmulsd  xmm1, xmm0, qword ptr [rax]
    # ;}}}
    # ; Function *; {
    # ; Location: float.jl:399
    #         vmulsd  xmm0, xmm1, xmm0
    # ;}
    #         pop     rbp
    #         ret
    #         nop     dword ptr [rax + rax]
    # ;}
