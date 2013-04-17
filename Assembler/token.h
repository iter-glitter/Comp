#ifndef _TOKEN_H_
#define _TOKEN_H_

#include <stdlib.h>
#include <string>

using namespace std;

struct FLAG
{
	string direct;
	string indir;
	string immed;
	string leftSzero;
	string leftSone;
	string rightSzero;
	string rightSone;
	string equal;
	string notEqual;
	string null;
	FLAG(){
		direct = "000"; //$
		indir = "001"; //($)
		immed = "010"; //#
		leftSzero = "000"; //<
		leftSone = "001"; //<<
		rightSzero = "010"; //>
		rightSone = "011"; //>>
		equal = "000"; //=
		notEqual = "001"; //!=
		null = "000"; // for cmds with no flags
	}
};


struct OPCODE
{
	string ADD;
	string SUB;
	string MUL;
	string DIV;
	string OR;
	string AND;
	string SHFT;
	string BRA;
	string JMP;
	string RTS;
	string RTI;
	string LOAD;
	string STOR;
	string INPUT;
	string OUTPUT;
	string LMSK;
	string NOP;
	string COMP;
	string LDA;
	string STA;
	string LDB;
	string STB;
	string BSR;
	OPCODE(){
		ADD = "00000"; //1
		SUB = "00001"; //2
		MUL = "00010"; //3
		DIV = "00010"; //4
		OR = "00011"; //5
		AND = "00100"; //6
		SHFT = "00101"; //7
		BRA = "00110"; //8
		JMP = "00111"; //9
		RTS = "01000"; //10
		RTI = "01001"; //11
		LOAD = "01010"; //12
		STOR = "01011"; //13
		INPUT = "01100"; //14
		OUTPUT = "01101"; //15
		LMSK = "01110"; //16
		NOP = "01111"; //17
		COMP = "10000"; //18
		LDA = "10001"; //19
		STA = "10010"; //20
		LDB = "10011"; //21
		STB = "10100"; //22
		BSR = "10101"; //23
	}
};

struct token
{
	string opcode;
	string flag;
	int operand;
	token(){
		opcode = "UNDEF";
		flag = "UNDEF";
	}
};

#endif