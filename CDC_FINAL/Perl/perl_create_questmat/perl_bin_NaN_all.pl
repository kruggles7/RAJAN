#/usr/bin/perl -w

# This program goes through all the binary files in the folder 'binary_files'
# and adds in NaN to the end of each row into the empty spots (so the file can then be turned into a matrix)

use strict;

my $counter=0;
my $directory="C:/Users/Rachel/Dropbox/Perl_Matlab";

opendir (DIR, "$directory/binary_files_NEW") or die; #where the binary files are
my @files = readdir DIR; #creates an array 'files' with he names of all the files in that folder
close DIR;

foreach my $filename(@files) #now goes through each binary file
{

	if($filename=~/binary.txt$/) #makes sure it didnt pick up anything else, only want the binary files
	{
		open (IN, "<$directory/binary_files_NEW/$filename") or die "can't open file";
		$filename=~s/binary.txt$//;  #takes out 'binary.txt' from the filename (so now it looks like "Q1-")
		
		# Now create a new file called Q1--NaN and specify where youw ant it to go:
		open (OUT, ">$directory/matlab_create_all_NEW/binary_NaN_files/$filename-NaN.txt") or die "cant create file";
		while (my $line=<IN>)
		{
			while ($line=~s/^([^\t]*)\t//)
			{
				print OUT "$1\t";  
				$counter++; 
			}
			# ^ reprint the whole line, while keeping track of how many answers there are in that line
			# Then, until the line reaches the max (16410), keep adding 'NaN' separated by tabs
			while ($counter<=16410)
			{
				print OUT "NaN\t";
				$counter++;
			}
			#Once you reach the max, go to the next line, reset teh counter, and start again
			print OUT "\n";
			$counter=0;
		}
		close IN;
		close OUT;
	}
}
