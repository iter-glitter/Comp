//////////////////////////////////////////////////////////////////////////////////
// Alex Hendren
// Sean McFeely
// EE480 - Spring 2013 - Heath
// Accumulator Based Processor
//
// Description: This program acts as the Assembler for for our Processors ISA
//
//		Execution: ./assem <input file> <output file name> 		
//  
//////////////////////////////////////////////////////////////////////////////////
#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <cstring>
#include <iostream>
#include <fstream>
#include <vector>
#include <stdint.h>
#include "token.h"

using namespace std;

vector<token> scanner(vector<string>);
void decTobin( int n, ofstream&);

int main(int argc, char *argv[])
{
	if (argc != 3){ // Test for correct number of arguments
		printf("Parameter(s): <input file> <output file name>\n");
		exit(0);
	}
	
	const char* file = argv[1];
	const char* ofile = argv[2];		
	
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
			size_t here = line.find_last_not_of(whitespaces);
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
		outFile << "memory[" << i << "] = 16'b" << tokens[i].opcode << tokens[i].flag;
		decTobin(tokens[i].operand, outFile);
		outFile << "; // " << tokens[i].cmdLine << endl;
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
	
		string theLine = lines[i];
		OPCODE opcode;
		FLAG flag;
		token t;
		bool nullFlag = false;
		bool nop = false;
		bool divide = false;

		//breakdown token
		size_t comFind = lines[i].find("//");
		size_t found = lines[i].find(" "); 
		if( (comFind != string::npos) && (comFind <= 2) ){ // comment
			continue;
		}
	
		
		if(found != string::npos){
			t.opcode = lines[i].substr(0,found);
			lines[i] = lines[i].substr(found+1);
			
			found = lines[i].find(" "); 
			if(found != string::npos){
				t.flag = lines[i].substr(0,found);
				string temp = lines[i].substr(found+1);
				comFind = temp.find("//");
				if(comFind != string::npos){
					// any comments are completely ignored
					temp = temp.substr(0,comFind);
				}
				//Chomp gibberish off the end of string
				string whitespaces (" \t");	
				size_t here = temp.find_last_not_of(whitespaces);
				if (here != std::string::npos)
					temp.erase(here+1);
				const char* tmpCstr = temp.c_str();
				t.operand = atoi(tmpCstr);
			}
			else{ //Flags are NULL?
				const char* tmpCstr = lines[i].c_str();
				t.operand = atoi(tmpCstr);
				nullFlag = true;
			}
		}
		else{ //NOP
			if (lines[i].size() < 2){
				continue; // empty line
			}
			else{
				t.opcode = lines[i];
				nop = true;				
			}
		}	

		//handle opcode
		if(t.opcode == "ADD" || t.opcode == "add")
			t.opcode = opcode.ADD;
		else if (t.opcode == "SUB" || t.opcode == "sub")
			t.opcode = opcode.SUB;
		else if (t.opcode == "MUL" || t.opcode == "mul")
			t.opcode = opcode.MUL;
		else if (t.opcode == "DIV" || t.opcode == "div"){
			t.opcode = opcode.DIV;
			divide = true;
		}
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
		else if (t.opcode == "NOP" || t.opcode == "nop")
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
		else{
			cout << "Error: '" << t.opcode << "' not recognized instruction @ line " << i+1 << endl;
			exit(1);
		}
	
		//handle flag
		if(t.flag == "$" )
			if(divide)
				t.flag = "010";
			else
				t.flag = flag.direct;
		else if(t.flag == "($)" )
			if(divide)
				t.flag = "011";
			else
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
		else if(t.flag == "=" )
			t.flag = flag.equal;
		else if(t.flag == "!=" )
			t.flag = flag.notEqual;	
		else if(nullFlag)
			t.flag = flag.null;
		else if(nop)
			t.flag = flag.null;
		else{
			cout << "Error: '" << t.flag << "' not valid flag option @ line " << i+1 << endl;
			exit(1);
		}
		
		t.cmdLine = theLine;
		toks.push_back(t);
	}
	

	return toks;
}
