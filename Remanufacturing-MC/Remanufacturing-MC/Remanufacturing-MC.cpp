// Remanufacturing-MC.cpp: 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <vector>
#include <stdlib.h>
#include <string>
#include <iostream>
#include <algorithm>
#include <ctime>
#include <cmath>
#include <stdio.h>
using namespace std;

#pragma region DataStructure
struct value {
	double score;
	double prob;
	value *post;
	value *pre;
}typedef value;
struct cell {
	struct value *val;
	int size;
	int id;
	double tScore;
}typedef cell;
#pragma endregion

#pragma region GlobalData
cell matrix[16];
double tScore[4];
string path[4][4];
#pragma endregion

#pragma region DataManipulation
//static initialization
void initData() {
	for (int i = 0; i < 16; ++i){
		matrix[i].val = (value*)malloc(sizeof(value));
		matrix[i].val->post = (value*)malloc(sizeof(value));
		matrix[i].val->post->post = (value*)malloc(sizeof(value));
	}
}
void asgnData() {
	for (int i = 0; i < 16; ++i){
		matrix[i].val->score = 1;
		matrix[i].val->post->score = 2;
		matrix[i].val->post->post->score = 3;
	}
	double p;
	srand((unsigned)time(NULL));
	for(int i=0;i<16;++i){
		p = rand()*1.0 / RAND_MAX;
		matrix[i].val->prob = p / 2;
		matrix[i].val->post->prob = p / 2;
		matrix[i].val->post->post->prob = 1 - p;
	}
}
void printData() {
	for (int i = 0; i < 16; ++i) {
		printf("(%d, %d): (%f, %f) (%f,%f) (%f, %f);\t", i/4, i%4, matrix[i].val->score, matrix[i].val->prob, 
			matrix[i].val->post->score, matrix[i].val->post->prob, matrix[i].val->post->post->score, matrix[i].val->post->post->prob);
		printf("\n");
	}
}
#pragma endregion

#pragma region Tools
double min(double a, double b) {
	return (a < b) ? a : b;
}
int factorial(int x) {
	return (x == 1 ? x : x * factorial(x - 1));
}
//Combination for score
double *combS(double *s1, double *s2, int size) {
	double *rst=(double*)malloc(pow(size, 2) * sizeof(double));
	int ctr = 0;
	for (int i = 0; i < size;++i)
		for (int j = 0; j < size; ++j) 
			rst[ctr] = s1[i] + s2[j];
	return rst;
}
//Combination for prob
double *combP(double *p1, double *p2, int size) {
	double *rst = (double*)malloc(pow(size, 2)*sizeof(double));
	int ctr = 0;
	for (int i = 0; i < size; ++i)
		for (int j = 0; j < size; ++j)
			rst[ctr] = p1[i] * p2[j];
	return rst;
}
//Integrate duplicated scores
void *integrate(double *s, double *p, int size) {
	int ctr;
	double *rst = (double*)malloc(sizeof(double)*size);
	for (int i = 0; i < size; ++i)
		for (int j = 0; j < size; ++j)
			if (s[i] == s[j]) {
				p[i] += p[j];
				ctr = j;
				while (p[ctr + 1]) {
					p[ctr] = p[ctr+1];
					s[ctr] = s[++ctr];
				}
			}
}
#pragma endregion

#pragma region MonteCarlo
double MC(double *score, double *prob) {
	double tScore = 0, x;
	int count = 0, j = 0, k = 0;
	srand((unsigned)time(NULL));
	for (int i = 0; i < 100; ++i) {
		while (score) {
			x = rand()*1.0 / RAND_MAX;
			while (x > prob[j]) ++j;
			tScore += score[j];
		}
	}
	tScore /= 100;
	return tScore;
}
#pragma endregion

#pragma region Choice
//1-1
void Choice1() {
	int list[4][4] = { {0,1,2,3},{4,5,6,7},{8,9,10,11},{12,13,14,15} };

}
//complete chain
void Choice2() {

}
#pragma endregion

int main()
{
	initData();
	asgnData();
	printData();
	Choice1();
	system("pause");
    return 0;
}

