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

int ROW = 4, COL = 4, SIZE=3;
cell matrix[16];
double tScore;
string path[4][4], fPath[4][4];

void initData() {
	for (int i = 0; i < 16; ++i){
		matrix[i].val = (value*)malloc(sizeof(value));
		matrix[i].val->post = (value*)malloc(sizeof(value));
		matrix[i].val->post->post = (value*)malloc(sizeof(value));
	}
}

//Consider probability
//void asgnData() {
//	for (int i = 0; i < 16; ++i){
//		matrix[i].val->score = 1;
//		matrix[i].val->post->score = 2;
//		matrix[i].val->post->post->score = 3;
//	}
//	double p;
//	srand((unsigned)time(NULL));
//	for (int i = 0; i<16; ++i){
//		p = rand()*1.0 / RAND_MAX;
//		matrix[i].val->prob = p / 2;
//		matrix[i].val->post->prob = p;
//		matrix[i].val->post->post->prob = 1;
//	}
//}

//Ignore probability
void asgnData() {
	for (int i = 0; i < 4; ++i){
		matrix[i].val->score = i+1;
		matrix[i+4].val->score = i+1;
		matrix[i + 8].val->score = i+1;
		matrix[i + 12].val->score = i+1;
		matrix[i].val->prob = 1;
		matrix[i + 4].val->prob = 1;
		matrix[i + 8].val->prob = 1;
		matrix[i + 12].val->prob = 1;
		//matrix[i].val->post->score = 2;
		//matrix[i].val->post->post->score = 3;
	}
	//double p;
	//srand((unsigned)time(NULL));
	//for (int i = 0; i<16; ++i){
	//	p = rand()*1.0 / RAND_MAX;
	//	matrix[i].val->prob = p / 2;
	//	matrix[i].val->post->prob = p;
	//	matrix[i].val->post->post->prob = 1;
	//}
}

void printData() {
	for (int i = 0; i < 16; ++i) {
		printf("(%d, %d): (%f, %f) (%f,%f) (%f, %f);\t", i / 4, i % 4, matrix[i].val->score, matrix[i].val->prob,
			matrix[i].val->post->score, matrix[i].val->post->prob, matrix[i].val->post->post->score, matrix[i].val->post->post->prob);
		printf("\n");
	}
}

double min(double a, double b) {
	return (a < b) ? a : b;
}
double MC_cell(int m){
	double tscore = 0, tmpscore=1000000, x;
	int count;
	value *tmp;
	//srand((unsigned)time(NULL));
	for (int i = 0; i < 100; ++i) {
		tmp = matrix[4 * (path[0][m][0]-48) + path[0][m][1]-48].val;
		count = 0;
		while (count+1<ROW){
			x = rand()*1.0 / RAND_MAX;
			for (; x>tmp->prob; tmp = tmp->post);
			tmpscore = min(tmpscore, tmp->score);
			tmp = matrix[4 * (path[count][m][0]-48) + path[count++][m][1]-48].val;
		}
		tscore += tmpscore;
	}
	tscore /= 100;
	return tscore;
}

void initChoice(){
	for (int i = 0; i < ROW; ++i){
		for (int j = 0; j < COL; ++j){
			//Connect to the cell below
			//path[i][j] = to_string(i) + to_string(j);
			//Connect the diagnal cell
			path[i][j] = to_string(i) + to_string(COL-j);
		}
	}
	for (int i = 0; i < ROW; ++i) tScore+=MC_cell(i);
}
void perm(string str[], int n, int m){
	double tmptScore = 0;
	if (n == m){
		for (int i = 0; i < ROW; ++i){
			tmptScore += MC_cell(i);
		}
		if (tScore < tmptScore){
			tScore = tmptScore;
			for (int i = 0; i < ROW; ++i){
				for (int j = 0; j < COL; ++j){
					fPath[i][j] = path[i][j];
				}
			}
		}
	}
	else {
		for (int i = n; i < m; i++){
			std::swap(str[i], str[n]);
			perm(str, n + 1, m);
			std::swap(str[i], str[n]);
		}
	}
}
void Choice(){
	for (int i = 0; i < ROW; ++i){
		perm(path[i], 0, COL);
	}
	cout << tScore;
}

int main()
{
	initData();
	asgnData();
	printData();
	initChoice();
	Choice();
	system("pause");
	return 0;
}




