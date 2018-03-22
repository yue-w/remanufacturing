//#include "stdafx.h"
#include <vector>
#include <stdlib.h>
#include <string>
#include <iostream>
#include <algorithm>
#include <ctime>
#include <random>
#include <chrono>
#include <array>
#include <fstream>
using namespace std;

struct value {
	double score;
	double prob;
	value *post;
	value *pre;
}typedef value;
struct cell {
	struct value *val, cost;
	int size;
	int id;
	double score;
}typedef cell;
 
//Global variable
const int ROW = 7, COL = 5, SCORESIZE = 3, COSTSIZE = 2, iter = 100;


cell matrix[ROW*COL];
double /*oScore, tScore,*/ fChain[COL], storeCost = 0, totalSC = 0;;
string path[ROW][COL], fPath[ROW][COL];

void initData() {
	int size = SCORESIZE;
	value *tmp;
	for (int i = 0; i < ROW*COL; ++i) {
		matrix[i].val = (value*)malloc(sizeof(value));
		tmp = matrix[i].val;
		size = SCORESIZE;
		while (size>0) {
			tmp->post = (value*)malloc(sizeof(value));
			tmp = tmp->post;
			--size;
		}
	}
}
void asgnData() {
	for (int i = 0; i < COL; ++i) {
		for (int r = 0; r < ROW; r++)
		{
			//Assign a score to each cell. The score equals the column
			matrix[i + r * COL].val->score = i + 1;
			//Assign possibility
			matrix[i + r * COL].val->prob = 1;
			/*
			if (r == 1) {
			matrix[i*COL + r].val->score = 1;
			matrix[i*COL + r].val->prob = 0.8;
			matrix[i*COL + r].val->post->score = 2;
			matrix[i*COL + r].val->post->prob = 0.9;
			matrix[i*COL + r].val->post->post->score = 3;
			matrix[i*COL + r].val->post->post->prob = 1;
			}*/
			//cost
			/*
			matrix[i*COL+r].cost.score=1;
			matrix[i*COL+r].cost.prob=0.9;*/
		}

	}/*
	 for (int i = 0; i < ROW*COL; ++i) {
	 matrix[i].cost = 0;
	 }
	 matrix[7].cost = 3;
	 matrix[9].cost = 3;
	 //matrix[10].cost =1.1;
	 matrix[14].cost = 1;
	 //matrix[9].cost = 3.1;*/
}
void printData() {
	for (int i = 0; i < ROW*COL; ++i) {
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
		tmp = matrix[COL * k + l].val;
		count = 0;
		while (count + 1<ROW) {
			x = rand()*1.0 / RAND_MAX;
			for (; x>tmp->prob; tmp = tmp->post);
			tmpscore = min(tmpscore, tmp->score);
			count++;
			tmp = matrix[COL * (path[count][m][0] - 48) + path[count][m][1] - 48].val;
		}
		tscore += tmpscore;
	}
	tscore /= 100;
	tmp = matrix[COL * k + l].val;
	count = 0;
	while (count + 1 < ROW) {
		tscore -= matrix[COL * (path[count][m][0] - 48) + path[count][m][1] - 48].cost.score*matrix[COL * (path[count][m][0] - 48) + path[count][m][1] - 48].cost.prob;
		count++;
	}
	return tscore;
}

void initChoice(double& tScore, double& oScore) {
	array<int, COL> ranNum;
	int ct;
	for (int k = 0; k < ROW; ++k) {
		ct = 0;
		for (int i = k*COL; i < COL*(k + 1); ++i) {
			ranNum[ct++] = i;
		}
		ct = 0;
		shuffle(ranNum.begin(), ranNum.end(), default_random_engine(chrono::system_clock::now().time_since_epoch().count()));
		for (int j = 0; j < COL; ++j) {
			fPath[k][j] = path[k][j] = to_string(ranNum[ct] / ROW) + to_string(ranNum[ct] % ROW);
			ct++;
		}
	}
	for (int i = 0; i < COL; ++i) {
		fChain[i] = MC_cell(i);
		oScore += fChain[i];
		tScore += (fChain[i]>0) ? fChain[i] : 0;
	}
}
void perm(string str[], int n, int m, double& tScore, double& oScore) {
	double otmpt = 0, tmptScore = 0, tmpScore, *tmpChain = (double*)malloc(COL * sizeof(double));
	if (n == m) {
		for (int i = 0; i < COL; ++i) {
			tmpChain[i] = tmpScore = MC_cell(i);
			otmpt += tmpScore;
			tmptScore += tmpScore>0 ? tmpScore : 0;
		}
		if (tScore < tmptScore) {
			tScore = tmptScore;
			oScore = otmpt;
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
			perm(str, n + 1, m, tScore, oScore);
			std::swap(str[i], str[n]);
		}
	}
}
void Choice(double& tScore, double& oScore) {
	for (int i = 0; i < ROW; ++i) {//Should't this ROW be COLUMN?
		perm(path[i], 0, COL, tScore, oScore);
	}
	for (int i = 0; i < ROW; ++i) {
		cout << i << ": " << fChain[i] << endl;
	}
	cout << "Total score with optimization: " << tScore << endl;
	cout << "Total score without optimization: " << oScore << endl;
	for (int i = 0; i < COL; ++i) {
		if (fChain[i] < 0) {
			for (int j = 0; j < ROW; ++j) {
				totalSC += storeCost*matrix[j*COL + i].cost.prob;
			}
		}
	}
	cout << "Possible total storage cost: " << totalSC << endl;
}

int main()
{
	//initData();
	//asgnData();
	//printData();
	//initChoice();
	//Choice();
	//for (int i = 0; i < ROW; ++i) {
	//	for (int j = 0; j < COL; ++j) {
	//		cout << fPath[i][j] << " ";
	//	}
	//	cout << endl;
	//}

	ofstream myfileOpt;
	ofstream myfileNonOpt;
	myfileOpt.open("opt.txt");
	myfileNonOpt.open("nonOpt.txt");

	//Total iteration numbers
	int totalIteraNumber = 1;
	//Total score without optimization
	double tScoreNonOpt = 0;
	//Total score with optimization
	double tScoreOpt = 0;
	//step for number of summation
	int step = 1;

	//Do the optimization for N times, and average the total score of these N times 
	for (int N = 1; N <= totalIteraNumber; )
	{
		tScoreOpt = 0;
		tScoreNonOpt = 0;
		//Sum the total score for N times
		for (int j = 1; j <= N; j++)
		{
			//Total score with optimization
			double tScore = 0;
			//Total score without optimization
			double oScore = 0;
			initData();
			asgnData();
			initChoice(tScore,  oScore);
			Choice(tScore,  oScore);
			tScoreOpt += tScore;
			tScoreNonOpt += oScore;
		}
		//Average the total score of these N times
		double AvgtScoreOpt = tScoreOpt / N;
		double AvgtScoreNonOpt = tScoreNonOpt / N;
		N += step;
		myfileOpt << AvgtScoreOpt << endl;
		myfileNonOpt << AvgtScoreNonOpt << endl;

	}
	myfileOpt.close();
	myfileNonOpt.close();
	system("pause");
	return 0;
}