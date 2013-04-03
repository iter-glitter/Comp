#include <stdio.h>
#include <stdlib.h>

#define $ 000  	// Direct addressing
#define ($) 001	// Indirect addressing
#define # 010  	// Immediate addressing
#define < 000	// Left shift 0
#define << 001	// Left shift 1
#define > 010	// Right shift 0
#define >> 011	// Right shift 1


//16-bit instructions : uint16_t

int main()
{
	FILE * code; //Assembly code input file
	code = fopen ("assem_input.txt","r");
	
	
	while(code != EOF)
	{
		//parser function
	}
	return 0;
}