install.packages("keras")
install_tensorflow()
library(keras)
library(dslabs)
library(tensorflow)

read_mnist()

#the code for finding out
mnist <- dataset_mnist()
x_train <- mnist$train$x
dim(x_train)
