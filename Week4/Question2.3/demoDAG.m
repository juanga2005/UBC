%Demo to fit a DAG on the Minst Data using the 8 sorrounding nodes as parents

clear all;
load MNIST_images.mat

d=size(X,1);
n=size(X,3);
