﻿//#include "stdafx.h"
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
#include <stdio.h>
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
	bool block;
	double score;
}typedef cell;

//Global variable
const int ROW = 7, COL = 5, SCORESIZE = 3, COSTSIZE = 2, MCIter = 100;


cell matrix[ROW*COL];
double /*randScore, optScore,*/ fChain[COL], otherCost = 0.1, totalSC = 0;;
string path[ROW][COL], fPath[ROW][COL];

void initData() {
	int size = SCORESIZE;
	value *tmp;
	for (int i = 0; i < ROW*COL; ++i) {
		matrix[i].val = (value*)malloc(sizeof(value));
		matrix[i].block = false;
		tmp = matrix[i].val;
		size = SCORESIZE;
		while (size>0) {
			tmp->post = (value*)malloc(sizeof(value));
			tmp = tmp->post;
			--size;
		}
	}
}
void asgnData(double p) {
	for (int i = 0; i < COL; ++i) {
		for (int r = 0; r < ROW; r++)
		{
			//Assign a score to each cell. The score equals the column
			matrix[i + r * COL].val->score = i + 1;
			//Assign possibility
			matrix[i + r * COL].val->prob = 1;

		}

	}

	for (int col = 1; col <= COL; col++)
	{
		//Cylinder block
		//Assign the price of buying new components
		matrix[col - 1 + 0 * COL].cost.score = 0.42;
		//Assign the probability the part will be missing
		matrix[col - 1 + 0 * COL].cost.prob = p;
		matrix[col - 1 + 0 * COL].block = true;

		//Cylinder head
		matrix[col - 1 + 1 * COL].cost.score = 0.25;
		matrix[col - 1 + 1 * COL].cost.prob = p;
		matrix[col - 1 + 1 * COL].block = true;

		//Flywhell housing
		matrix[col - 1 + 2 * COL].cost.score = 0.03;
		matrix[col - 1 + 2 * COL].cost.prob = p;
		matrix[col - 1 + 2 * COL].block = true;

		//Gearbox
		matrix[col - 1 + 3 * COL].cost.score = 0.03;
		matrix[col - 1 + 3 * COL].cost.prob = p;
		matrix[col - 1 + 3 * COL].block = true;

		//COnnecting-rod
		matrix[col - 1 + 4 * COL].cost.score = 0.07;
		matrix[col - 1 + 4 * COL].cost.prob = p;
		matrix[col - 1 + 4 * COL].block = true;

		//Crankshaft
		matrix[col - 1 + 5 * COL].cost.score = 0.17;
		matrix[col - 1 + 5 * COL].cost.prob = p;
		matrix[col - 1 + 5 * COL].block = true;

		//Fly whell
		matrix[col - 1 + 6 * COL].cost.score = 0.02;
		matrix[col - 1 + 6 * COL].cost.prob = p;
		matrix[col - 1 + 6 * COL].block = true;
	}

}

void printData() {
	for (int i = 0; i < ROW*COL; ++i) {
		printf("(%d, %d): (%f, %f);\t", i / 4, i % 4, matrix[i].val->score, matrix[i].val->prob);
		////cout << matrix[i].block;
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
	srand((unsigned)time(NULL));
	for (i = 0; i < MCIter; ++i) {
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
	tscore /= MCIter;
	count = 0;
	while (count < ROW) {
		x = rand()*1.0 / RAND_MAX;
		if (x <= matrix[COL*(path[count][m][0] - 48) + path[count][m][1] - 48].cost.prob) {
			tscore -= matrix[COL*(path[count][m][0] - 48) + path[count][m][1] - 48].cost.score;
			////cout << matrix[COL*(path[count][m][0] - 48) + path[count][m][1] - 48].cost.score;
		}
		count++;
	}
	return tscore;
}
void initChoice(double& optScore, double& randScore)
{
	for (int i = 0; i < ROW; ++i) {
		for (int j = 0; j < COL; ++j) {
			fPath[i][j] = path[i][j] = to_string(i) + to_string(j);
		}
	}
	srand((unsigned)time(NULL));
	for (int i = 0; i < COL; i++) {
		int pre = rand() % (COL), pos = rand() % (COL);
		swap(matrix[pre], matrix[pos]);
	}
	for (int i = 0; i < COL; ++i) {
		double scost = 0;
		fChain[i] = MC_cell(i);
		randScore += fChain[i];
		if (fChain[i] < 0) {
			for (int j = 0; j < ROW; ++j) {
				scost += matrix[(path[i][j][0] - 48)*COL + path[i][j][1] - 48].block == false ? otherCost : 0;
			}
		}
		////cout << i << ": " << fChain[i] << endl;
		optScore = 0 - scost;
		optScore += (fChain[i]>0) ? fChain[i] : 0;
	}
	////cout << "Initial: " << optScore << endl;
}
void perm(string str[], int n, int m, double& optScore, double& randScore) {
	double otmpt = 0, tmptScore = 0, tmpScore, *tmpChain = (double*)malloc(COL * sizeof(double)), scost = 0, tmpscost = 0;
	if (n == m) {
		for (int i = 0; i < COL; ++i) {
			tmpscost = 0;
			tmpChain[i] = tmpScore = MC_cell(i);
			otmpt += tmpScore;
			tmptScore += tmpScore>0 ? tmpScore : 0;
			if (tmpChain[i] < 0) {
				for (int j = 0; j < ROW; ++j) {
					tmpscost += matrix[(path[i][j][0] - 48)*COL + path[i][j][1] - 48].block == false ? otherCost : 0;
				}
			}
			scost += tmpscost;
			tmptScore -= tmpscost;
		}
		if (optScore < tmptScore) {
			optScore = tmptScore;
			randScore = otmpt;
			totalSC = scost;
			if (scost == 0.4) {
				for (int i = 0; i < COL; ++i) {
					////cout << fChain[i] << endl;
				}
			}
			for (int i = 0; i < ROW; ++i) {
				for (int j = 0; j < COL; ++j) {
					fPath[i][j] = path[i][j];
				}
				fChain[i] = tmpChain[i];
			}
		}
		optScore = (optScore < tmptScore) ? tmptScore : optScore;
	}
	else {
		for (int i = n; i < m; i++) {
			std::swap(str[i], str[n]);
			perm(str, n + 1, m, optScore, randScore);
			std::swap(str[i], str[n]);
		}
	}
}
void Choice(double& optScore, double& randScore) {
	//printData();
	for (int i = 0; i < ROW; ++i) {
		perm(path[i], 0, COL, optScore, randScore);
	}
	double tmpZ = 0;
	for (int i = 0; i < COL; ++i) {
		////cout << i << ": " << fChain[i] << endl;
	}
	////cout << "Total score with optimization: " << optScore << endl;
	////cout << "Total score without optimization: " << randScore << endl;
	////cout << "Possible total storage cost: " << totalSC << endl;
}

void  choiceAverageN(const int N, double& AvgtScoreOpt, double& AvgtScoreNonOpt)
{
	//Do the optimization for N times, and average the total score of these N times 

	double tScoreNonOpt = 0;
	double tScoreOpt = 0;
	for (int j = 1; j <= N; j++)
	{
		//Total score with optimization
		double optScore = 0;
		//Total score without optimization
		double randScore = 0;
		initChoice(optScore, randScore);
		tScoreNonOpt += optScore;
		Choice(optScore, randScore);
		tScoreOpt += optScore;

	}
	//Average the total score of these N times
	AvgtScoreOpt = tScoreOpt / double(N);
	AvgtScoreNonOpt = tScoreNonOpt / double(N);

}
void testN(int totalIteraNumber, int step)
{
	ofstream myfileOpt;
	ofstream myfileNonOpt;
	myfileOpt.open("opt.txt");
	myfileNonOpt.open("nonOpt.txt");
	//Total iteration numbers
	//int totalIteraNumber = 201;
	//Total score without optimization
	double tScoreNonOpt = 0;
	//Total score with optimization
	double tScoreOpt = 0;
	//step for number of summation
	//int step = 10;
	double prob = 0.2;
	//Do the optimization for N times, and average the total score of these N times 
	for (int N = 1; N <= totalIteraNumber; )
	{
		tScoreOpt = 0;
		tScoreNonOpt = 0;
		//Sum the total score for N times
		for (int j = 1; j <= N; j++)
		{
			//Total score with optimization
			double optScore = 0;
			//Total score without optimization
			double randScore = 0;
			initData();
			asgnData(prob);
			initChoice(optScore, randScore);
			tScoreNonOpt += optScore;
			Choice(optScore, randScore);
			tScoreOpt += optScore;

		}
		//Average the total score of these N times
		double AvgtScoreOpt = tScoreOpt / double(N);
		double AvgtScoreNonOpt = tScoreNonOpt / double(N);
		N += step;
		myfileOpt << AvgtScoreOpt << endl;
		myfileNonOpt << AvgtScoreNonOpt << endl;

	}

	myfileOpt.close();
	myfileNonOpt.close();

}

void asgnDataTestP(double p)
{
	for (int i = 0; i < COL; ++i) {
		for (int r = 0; r < ROW; r++)
		{
			//Assign a score to each cell. The score equals the column
			matrix[i + r * COL].val->score = i + 1;
			//Assign possibility
			matrix[i + r * COL].val->prob = 1;
		}

	}

	for (int col = 1; col <= COL; col++)
	{
		//Cylinder block
		//Assign the price of buying new components
		matrix[col - 1 + 0 * COL].cost.score = 0.42;
		//Assign the probability the part will be missing
		matrix[col - 1 + 0 * COL].cost.prob = p;
		matrix[col - 1 + 0 * COL].block = true;

		//Cylinder head
		matrix[col - 1 + 1 * COL].cost.score = 0.25;
		matrix[col - 1 + 1 * COL].cost.prob = p;
		matrix[col - 1 + 1 * COL].block = true;

		//Flywhell housing
		matrix[col - 1 + 2 * COL].cost.score = 0.03;
		matrix[col - 1 + 2 * COL].cost.prob = p;
		matrix[col - 1 + 2 * COL].block = true;

		//Gearbox
		matrix[col - 1 + 3 * COL].cost.score = 0.03;
		matrix[col - 1 + 3 * COL].cost.prob = p;
		matrix[col - 1 + 3 * COL].block = true;

		//COnnecting-rod
		matrix[col - 1 + 4 * COL].cost.score = 0.07;
		matrix[col - 1 + 4 * COL].cost.prob = p;
		matrix[col - 1 + 4 * COL].block = true;

		//Crankshaft
		matrix[col - 1 + 5 * COL].cost.score = 0.17;
		matrix[col - 1 + 5 * COL].cost.prob = p;
		matrix[col - 1 + 5 * COL].block = true;

		//Fly whell
		matrix[col - 1 + 6 * COL].cost.score = 0.02;
		matrix[col - 1 + 6 * COL].cost.prob = p;
		matrix[col - 1 + 6 * COL].block = true;
	}
}

void testP(double step, int N)
{
	//N is the number of summation

	ofstream myfileOpt;
	ofstream myfileNonOpt;
	myfileOpt.open("opt.txt");
	myfileNonOpt.open("nonOpt.txt");
	//Total score with optimization
	double AvgtScoreOpt = 0;
	//Total score without optimization
	double AvgtScoreNonOpt = 0;
	myfileOpt << "Analyze Probability of missing, iteration time N=" << N << "Processing Cost="<<otherCost << endl;
	myfileNonOpt << "Analyze Probability of missing, iteration time N=" << N << "Processing Cost=" << otherCost << endl;
	double p = 0;
	while (p <= 1)
	{
		initData();
		asgnDataTestP(p);
		choiceAverageN(N, AvgtScoreOpt, AvgtScoreNonOpt);
		p += step;
		myfileOpt << AvgtScoreOpt << endl;
		myfileNonOpt << AvgtScoreNonOpt << endl;
	}

	myfileOpt.close();
	myfileNonOpt.close();
}

void testOtherCost(int N, double step, double maxOtherCost, double minOtherCost)
{
	ofstream myfileOpt;
	ofstream myfileNonOpt;
	myfileOpt.open("opt.txt");
	myfileNonOpt.open("nonOpt.txt");
	//Total score with optimization
	double AvgtScoreOpt = 0;
	//Total score without optimization
	double AvgtScoreNonOpt = 0;

	double prob = 0.2;
	otherCost = minOtherCost;
	myfileOpt << "Analyze Processing Cost, iteration time N="<<N<<" Probability of missing P="<< prob << endl;
	myfileNonOpt << "Analyze Processing Cost, iteration time N=" << N << " Probability of missing P=" << prob << endl;
	while (otherCost<=maxOtherCost)
	{
		initData();
		asgnData(prob);
		choiceAverageN(N, AvgtScoreOpt, AvgtScoreNonOpt);
		myfileOpt << AvgtScoreOpt << endl;
		myfileNonOpt << AvgtScoreNonOpt << endl;
		otherCost += step;
	}
}

int main()
{

	////Test Iteration Number
	//int totalIteraNumber = 10;
	//int step = 2;
	//testN(totalIteraNumber,step);

	int N = 20;

	////Test probability
	//int N = 20;
	//testP(0.1,);

	////Test Other cost
	double step = 0.2;
	double maxOtherCost = 2;
	double minOtherCost = 0.2;
	testOtherCost(N,step, maxOtherCost,minOtherCost);
	system("pause");
	return 0;
}