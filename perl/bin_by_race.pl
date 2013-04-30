#!/usr/bin/perl -w
#
use strict;
my $dir=""; 
my $filename = ""; 
my $ones = "";  
my $error = 0; 
my $j=0; 


open (IN, "<RACE.txt") or die "can't open file!"; 	
open (OUT, ">RACE_bin.txt") or die "can't open file!"; 
open (OUT2, ">RACE_bin_hispanic.txt") or die "can't open file"; 
while (my $line =<IN>)
{
	while ($line=~s/^([^\t]*)\t//)
	{
		my $temp=$1; 
		if ($j==0)
		{
			my $year = $temp; 
			print OUT "$year\t";
			print OUT2 "$year\t"; 
			$j=1; 
		}
		else 
		{
			if ($temp == 0)
			{
				print OUT "9\t"; #indicates the data is missing 
				print OUT2 "9\t"; 
			}
			elsif ($temp == 3)
			{
				print OUT "0\t"; #black
				print OUT2 "0\t"; 
			}
			elsif ($temp == 5)
			{
				print OUT "1\t"; #white 
				print OUT2 "0\t"; 
			}
			elsif (($temp==6) or ($temp==7))
			{
				print OUT "2\t"; #hispanic
				print OUT2 "1\t"; 
			}
			else
			{
				print OUT "3\t"; #other
				print OUT2 "0\t"; 
			}
		}
	}
	$j=0; 
	print OUT "\n"; 
	print OUT2 "\n"; 
}
close IN; 
close OUT;
close OUT2; 

