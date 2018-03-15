#include <vector>
#include <stdlib.h>
#include <string>
#include <iostream>
#include <algorithm>
#include <ctime>
#include <cmath>
#include <stdio.h>
using namespace std;

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
	bool block;
	double score;
}typedef cell;

int ROW = 4, COL = 4;
cell matrix[16];

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
	for (int i = 0; i<16; ++i){
		p = rand()*1.0 / RAND_MAX;
		matrix[i].val->prob = p / 2;
		matrix[i].val->post->prob = p;
		matrix[i].val->post->post->prob = 1;
	}
}
void printData() {
	for (int i = 0; i < 16; ++i) {
		printf("(%d, %d): (%f, %f) (%f,%f) (%f, %f);\t", i / 4, i % 4, matrix[i].val->score, matrix[i].val->prob,
			matrix[i].val->post->score, matrix[i].val->post->prob, matrix[i].val->post->post->score, matrix[i].val->post->post->prob);
		printf("\n");
	}
}

double Min(double a, double b) {
	return (a < b) ? a : b;
}
double MC(cell input) {
	double tscore = 0, x;
	int count = 0, j = 0, k = 0;
	value *tmp;
	//srand((unsigned)time(NULL));
	for (int i = 0; i < 100; ++i) {
		tmp = input.val;
		x = rand()*1.0 / RAND_MAX;
		for (; x>tmp->prob; tmp = tmp->post);
		input.score += tmp->score;
	}
	input.score /= 100;
	return input.score;
}

int main(){
	double cost, min[4] = { 100000, 100000, 100000, 100000 }, x = 100000;
	printf("Enter the cost: ");
	scanf("%lf", &cost);
	initData();
	asgnData();
	printData();
	for (int i = 0; i < ROW; ++i){
		for (int j = 0; j < COL; ++j){
			min[i] = Min(min[i], MC(matrix[4*i+j]));
		}
		x = Min(x, min[i]);
	}
	printf((cost + x)>0 ? "Accept" : "Reject");
	system("pause");
	return 0;
}



