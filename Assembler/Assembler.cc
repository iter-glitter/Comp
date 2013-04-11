#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <cstring>
#include <iostream>
#include <fstream>
#include <vector>
#include <stdint.h>
//#include "token.h"


using namespace std;

//16-bit instructions : uint16_t
struct FLAG
{
	string direct;
	string indir;
	string immed;
	string leftSzero;
	string leftSone;
	string rightSzero;
	string rightSone;
	FLAG(){
		direct = "000"; //$
		indir = "001"; //($)
		immed = "010"; //#
		leftSzero = "000"; //<
		leftSone = "001"; //<<
		rightSzero = "010"; //>
		rightSone = "011"; //>>
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

vector<token> scanner(vector<string>);
void decTobin( int n, ofstream&);

int main()
{
	string in;
	string out;
	cout << "Name of input file: ";
	cin >> in;
	cout << endl << "Desired name of output file: ";
	cin >> out;
	cout << endl;
	
	const char* file =  in.c_str(); //"assem_input.txt";
	const char* ofile = out.c_str(); //"assem_binary.txt";
	
	ifstream inFile;
	ofstream outFile;
	inFile.open (file, ios::in);

	string line;
	vector<string> lines;
	
	if(inFile.is_open()){
		while(inFile.good())
		{
			getline(inFile,line);
			//Chomp the newline and any other gibberish off the end of the input string
			string whitespaces (" \t\n\r");	
			int here = line.find_last_not_of(whitespaces);
			if (here != std::string::npos)
				line.erase(here+1);
			lines.push_back(line);
		}
	}
	else
		cout << file << " Did not open\n";
	inFile.close();
	
	vector<token> tokens = scanner(lines);
	
	outFile.open(ofile);
	for(unsigned i=0; i < tokens.size(); ++i){
		outFile << "memory[" << i << "] = 8'b" << tokens[i].opcode << tokens[i].flag;
		decTobin(tokens[i].operand, outFile);
		outFile << ";" << endl;
	}
	outFile.close();
	
	return 0;
}


void decTobin( int n, ofstream &outFile ){
  int c, k;
 
  for (c = 7; c >= 0; c--)
  {
    k = n >> c;
 
    if (k & 1)
      outFile << "1";
    else
      outFile << "0";
  }
}
 
vector<token> scanner(vector<string> lines)
{

	vector<token> toks;

	for(unsigned i=0; i < lines.size(); ++i){

		//cout << "line = " << lines[i] << endl; 

		OPCODE opcode;
		FLAG flag;
		token t;
		//vector<token> toks;


		//breakdown token
		int found = lines[i].find(" "); 
		if(found != string::npos){
			t.opcode = lines[i].substr(0,found);
			lines[i] = lines[i].substr(found+1);
		}
		found = lines[i].find(" "); 
		if(found != string::npos){
			t.flag = lines[i].substr(0,found);
			string temp = lines[i].substr(found+1);
			const char* tmpCstr = temp.c_str();
			t.operand = atoi(tmpCstr);
		}

		//handle opcode
		if(t.opcode == "ADD" || t.opcode == "add")
			t.opcode = opcode.ADD;
		else if (t.opcode == "SUB" || t.opcode == "sub")
			t.opcode = opcode.SUB;
		else if (t.opcode == "MUL" || t.opcode == "mul")
			t.opcode = opcode.MUL;
		else if (t.opcode == "DIV" || t.opcode == "div")
			t.opcode = opcode.DIV;
		else if (t.opcode == "OR" || t.opcode == "or")
			t.opcode = opcode.OR;
		else if (t.opcode == "AND" || t.opcode == "and")
			t.opcode = opcode.AND;
		else if (t.opcode == "SHFT" || t.opcode == "shft")
			t.opcode = opcode.SHFT;
		else if (t.opcode == "BRA" || t.opcode == "bra")
			t.opcode = opcode.BRA;
		else if (t.opcode == "JMP" || t.opcode == "jmp")
			t.opcode = opcode.JMP;
		else if (t.opcode == "RTS" || t.opcode == "rts")
			t.opcode = opcode.RTS;
		else if (t.opcode == "RTI" || t.opcode == "rti")
			t.opcode = opcode.RTI;
		else if (t.opcode == "LOAD" || t.opcode == "load")
			t.opcode = opcode.LOAD;
		else if (t.opcode == "STOR" || t.opcode == "stor")
			t.opcode = opcode.STOR;
		else if (t.opcode == "INPUT" || t.opcode == "input")
			t.opcode = opcode.INPUT;
		else if (t.opcode == "OUTPUT" || t.opcode == "output")
			t.opcode = opcode.OUTPUT;
		else if (t.opcode == "LMSK" || t.opcode == "lmsk")
			t.opcode = opcode.LMSK;
		else if (t.opcode == "NOP" || t.opcode == "NOP")
			t.opcode = opcode.NOP;
		else if (t.opcode == "COMP" || t.opcode == "comp")
			t.opcode = opcode.COMP;
		else if (t.opcode == "LDA" || t.opcode == "lda")
			t.opcode = opcode.LDA;
		else if (t.opcode == "STA" || t.opcode == "sta")
			t.opcode = opcode.STA;
		else if (t.opcode == "LDB" || t.opcode == "ldb")
			t.opcode = opcode.LDB;
		else if (t.opcode == "STB" || t.opcode == "stb")
			t.opcode = opcode.STB;
		else if (t.opcode == "BSR" || t.opcode == "bsr")
			t.opcode = opcode.BSR;
	
		//handle flag
		if(t.flag == "$" )
			t.flag = flag.direct;
		else if(t.flag == "($)" )
			t.flag = flag.indir;
		else if(t.flag == "#" )
			t.flag = flag.immed;
		else if(t.flag == "<" )
			t.flag = flag.leftSzero;
		else if(t.flag == "<<" )
			t.flag = flag.leftSone;
		else if(t.flag == ">" )
			t.flag = flag.rightSzero;
		else if(t.flag == ">>" )
			t.flag = flag.rightSone;

		toks.push_back(t);
	}
	

	return toks;
}
