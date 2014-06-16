#!/usr/bin/perl -w

# this program creates a tab delimited file which contains the race information for all 6 years

use strict;

my @filename = ("Data_2013", "Data_2011", "Data_2009", "Data_2007", "Data_2005", "Data_2003", "Data_2001");
my @year=(2013, 2011, 2009, 2007, 2005, 2003, 2001);
my @n=(199,195,191,190,192,193,88); 
my %final_hash = (); 
my @miss=();
my @total=();
my $line=();
my $temp="";
my $out="Controls_061514";
mkdir "$out"; 

# for 2013-2007: the race is in the first column (questions[0])
# 1:other, 2:other, 3:black, 4:other, 5:white, 6:hispanic, 7:hispanic, 8:other
for (my $i=0; $i<7; $i++)
{
	open (IN, "$filename[$i].txt") or die "can't open file $filename[$i].txt\n";
	my $line1=<IN>; 
	while ($line1=<IN>)
	{
		my @questions=();
		@questions = split ("\t", $line1);
		my $n=$n[$i]; 
		$temp=$questions[$n];
		#deal with race----------------
		if ($temp!~/\w/)  #no answer
		{
			$questions[$n]=0;
			$miss[$i]++;
		}
		$final_hash{$year[$i]}.="#$questions[$n]#";
	}
	close IN;
}



#put it all into a tab-delim file called race
open (OUT, ">$out/weights.txt") or die "cant't create file"; 
my $ans=""; 
foreach my $key (sort keys %final_hash)
{
	print OUT "$key\t"; 
	my $temp = $final_hash{$key}; 
	while ($temp=~s/^#([^#]+)#//)
	{
		$ans=$1; 
		print OUT "$ans\t"; 
	}
	print OUT "\n"; 
}
close OUT;

my $counter=0;

open (IN, "$out/weights.txt") or die "can't open file";
open (OUT, ">$out/weights-NaN.txt") or die "cant create file"; 
while ($line=<IN>)
{
	while ($line=~s/^([^\t]*)\t//)
	{
		print OUT "$1\t";
		$counter++;
	}
	while ($counter<=16410)
	{
		print OUT "NaN\t";
		$counter++;
	}
	print OUT "\n";
	$counter=0;
}
close IN;
close OUT;



