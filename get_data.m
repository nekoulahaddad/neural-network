clear ; close all; clc
% get the data
X = xlsread('input.xlsx'); y = xlsread('output of p300.xlsx');
g = [X,y];