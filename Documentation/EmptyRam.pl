#!/usr/local/bin/perl
open (FILE, ">>", "ram_empty.txt");

for ($i=0; $i<256; $i++){
	$memString = "memory[$i] = 16\'b0000000000000000;\n";
	print FILE $memString;
}

close(FILE);