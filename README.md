# TADW
This is the lab code for paper "Network Representation Learning with Rich Text Information". (To be appeared at IJCAI2015)

The code requires a 64-bit linux machine with MATLAB installed.

The main program is TADW.m. More details about parameters can be found in the comments.

# Dataset Description

Cora contains 2, 708 machine learning papers from seven classes and 5, 429 links between them. The links are citation relationships between the documents. Each document is described by a binary vector of 1, 433 dimensions indicating the presence of the corresponding word.

Citeseer contains 3, 312 publications from six classes and 4, 732 links between them. Similar to Cora, the links are citation relationships between the documents and each paper is described by a binary vector of 3, 703 dimensions.

Wiki contains 2, 405 documents from 19 classes and 17, 981 links between them. The TFIDF matrix of this dataset has 4, 973 columns.

graph.txt: 
Each line contains two paper Ids which indicates the citation relationship between them. ID begins from 0.

group.txt: 
Each line contains two numbers: Paper Id and Group Id. For Cora and Citeseer, group Id begins from 0; For Wiki, group Id begins from 1.

feature.txt for Cora and Citeseer: 
This is the Paper-Word relationship matrix. Each line contains a binary vector of 1, 433 dimensions indicating the presence of the corresponding word.

tfidf.txt for Wiki: 
This is the TFIDF matrix of Wiki dataset. 4, 973 columns correspond to 4, 973 different words.

#About the mex file
The source code of train.mexa64 comes from LibLinear which can be found at http://www.csie.ntu.edu.tw/~cjlin/liblinear/.
train_ml.mexa64 comes from the work "Inductive matrix completion for predicting gene-disease associations" which can be found at http://bigdata.ices.utexas.edu/project/gene-disease/. The authors provide only mex file on the site and I don't have the source code either.
