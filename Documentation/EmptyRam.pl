#!/usr/local/bin/perl
open (FILE, ">", "data_ram_empty.txt");

for ($i=0; $i<256; $i++){
	$memString = "memory[$i] = 8\'b00000000;\n";
	print FILE $memString;
}

close(FILE);