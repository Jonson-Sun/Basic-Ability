
# 本文件为Julia程序设计预言源文件 
using Flux,  Statistics
using Flux: onehotbatch, onecold, crossentropy, throttle
using Base.Iterators: repeated

# Classify MNIST digits with a simple multi-layer-perceptron

imgs = images()
# Stack images into one large batch
X = hcat(float.(reshape.(imgs, :))...) 

labels = MNIST.labels()
# One-hot-encode the labels
Y = onehotbatch(labels, 0:9) 

m = Chain(
  Dense(28^2, 32, relu),
  Dense(32, 10),
  softmax
) #定义的模型

loss(x, y) = crossentropy(m(x), y)  #损失函数
accuracy(x, y) = mean(onecold(m(x)) .== onecold(y))  #准确率
dataset = repeated((X, Y), 200)
evalcb = () -> @show(loss(X, Y))
opt = ADAM()
#训练开始
Flux.train!(loss, params(m), dataset, opt, cb = throttle(evalcb, 10))

accuracy(X, Y)

# Test set 
tX = hcat(float.(reshape.(MNIST.images(:test), :))...) 
tY = onehotbatch(MNIST.labels(:test), 0:9) 

accuracy(tX, tY)