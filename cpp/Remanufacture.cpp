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
	double cost;
	double score;
}typedef cell;

int ROW = 4, COL = 4, SIZE = 3, COSTSIZE = 2;
cell matrix[16];
double tScore, fChain[4];
string path[4][4], fPath[4][4];

void initData() {
	for (int i = 0; i < 16; ++i) {
		matrix[i].val = (value*)malloc(sizeof(value));
		matrix[i].val->post = (value*)malloc(sizeof(value));
		matrix[i].val->post->post = (value*)malloc(sizeof(value));
	}
}
void asgnData() {
	for (int i = 0; i < 4; ++i) {
		matrix[i].val->score = i + 1;
		matrix[i + 4].val->score = i + 1;
		matrix[i + 8].val->score = i + 1;
		matrix[i + 12].val->score = i + 1;
		matrix[i].val->prob = 1;
		matrix[i + 4].val->prob = 1;
		matrix[i + 8].val->prob = 1;
		matrix[i + 12].val->prob = 1;
	}
	for (int i = 0; i < 16; ++i) {
		matrix[i].cost = 0;
	}
	matrix[6].cost = 3.1;
	matrix[9].cost = 3.1;
	//matrix[10].cost = 1.1;
	matrix[11].cost = 3.1;
	//matrix[9].cost = 3.1;
}
void printData() {
	for (int i = 0; i < 16; ++i) {
		printf("(%d, %d): (%f, %f);\t", i / 4, i % 4, matrix[i].val->score, matrix[i].val->prob);
		//matrix[i].val->post->score, matrix[i].val->post->prob, matrix[i].val->post->post->score, matrix[i].val->post->post->prob);
		printf("\n");
	}
}
double min(double a, double b) {
	return (a < b) ? a : b;
}
double MC_cell(int m) {
	double tscore = 0, tmpscore = 1000000, x;
	int count = 0, j = 0, i = 0, k = path[0][m][0] - 48, l = path[0][m][1] - 48;
	value *tmp;
	//srand((unsigned)time(NULL));
	for (i = 0; i < 100; ++i) {
		tmp = matrix[4 * k + l].val;
		count = 0;
		while (count + 1<ROW) {
			x = rand()*1.0 / RAND_MAX;
			for (; x>tmp->prob; tmp = tmp->post);
			tmpscore = min(tmpscore, tmp->score);
			count++;
			tmp = matrix[4 * (path[count][m][0] - 48) + path[count][m][1] - 48].val;
		}
		tscore += tmpscore;
	}
	tscore /= 100;
	tmp = matrix[4 * k + l].val;
	count = 0;
	double pad, buf = tscore;
	while (count + 1 < ROW) {
		tscore -= matrix[4 * (path[count][m][0] - 48) + path[count][m][1] - 48].cost;
		count++;
	}
	return tscore;
}

void initChoice() {
	for (int i = 0; i < ROW; ++i) {
		for (int j = 0; j < COL; ++j) {
			fPath[i][j] = path[i][j] = to_string(i) + to_string(j);
		}
	}
	for (int i = 0; i < ROW; ++i) {
		fChain[i] = MC_cell(i);
		tScore += fChain[i];
	}
}
void perm(string str[], int n, int m) {
	double tmptScore = 0, tmpScore, tmpChain[4];
	if (n == m) {
		for (int i = 0; i < ROW; ++i) {
			tmpChain[i] = tmpScore = MC_cell(i);
			tmptScore += tmpScore>0 ? tmpScore : 0;
		}
		if (tScore < tmptScore) {
			tScore = tmptScore;
			for (int i = 0; i < ROW; ++i) {
				for (int j = 0; j < COL; ++j) {
					fPath[i][j] = path[i][j];
				}
				fChain[i] = tmpChain[i];
			}
		}
		tScore = (tScore < tmptScore) ? tmptScore : tScore;
	}
	else {
		for (int i = n; i < m; i++) {
			std::swap(str[i], str[n]);
			perm(str, n + 1, m);
			std::swap(str[i], str[n]);
		}
	}
}
void Choice() {
	for (int i = 0; i < ROW; ++i) {
		perm(path[i], 0, COL);
	}
	for (int i = 0; i < ROW; ++i) {
		cout << i << ": " << fChain[i] << endl;
	}
	cout << "Total score with optimization: " << tScore << endl;
}

int main()
{
	initData();
	asgnData();
	printData();
	initChoice();
	Choice();
	for (int i = 0; i < ROW; ++i) {
		for (int j = 0; j < COL; ++j) {
			cout << fPath[i][j] << " ";
		}
		cout << endl;
	}
	system("pause");
	return 0;
}