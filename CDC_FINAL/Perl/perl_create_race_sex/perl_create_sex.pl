#!/usr/bin/perl -w

# this program creates a tab delimited file which contains the sex information for all 6 years
# 1 means female, 2 means male, and 0 means no answer

use strict;

my @filename = ("Controls_2011", "Controls_2009", "Controls_2007", "Controls_2005", "Controls_2003", "Controls_2001");
my @year=(2011, 2009, 2007, 2005, 2003, 2001);
my %final_hash = (); 
my @miss=();
my @total=();

# for 2011-2009 the race is in the 3rd column (questions[2])
for (my $i=0; $i<2; $i++)
{
	open (IN, "$filename[$i].txt") or die "can't open file";
	my $line1=<IN>; 
	while ($line1=<IN>)
	{
		my @questions=(); 
		@questions = split ("\t", $line1); 
		if ($questions[2]!~/\w/)
		{
			$questions[2]=0;
			$miss[$i]++;
		}
		$final_hash{$year[$i]}.="#$questions[2]#"; 
	$total[$i]++;
	}
	close IN;
}

# for 2007-2001 the race is in the second column (questions[1])
for (my $i=2; $i<6; $i++)
{
	open (IN, "$filename[$i].txt") or die "can't open file";
	my $line2=<IN>; 
	while ($line2=<IN>)
	{
		my @questions=(); 
		@questions = split ("\t", $line2); 
		if ($questions[1]!~/\w/)
		{
			$questions[1]=0;
			$miss[$i]++;
		}
		$final_hash{$year[$i]}.="#$questions[1]#"; 
	$total[$i]++;
	}
	close IN;
}

#put it all into a tab-delim file called sex
open (OUT, ">sex.txt") or die "cant't create file"; 
my $ans=""; 
foreach my $key (sort keys %final_hash)
{
	print OUT "$key\t"; 
	my $temp = $final_hash{$key}; 
	while ($temp=~s/#([^#]+)#//)
	{
		$ans=$1; 
		print OUT "$ans\t"; 
	}
	print OUT "\n"; 
}
close OUT;


#to create log file of how many students were questioned and how many didn't give their sex each year:
open (OUT, ">sex-log.log") or die;
print OUT "Year \tTotal# \tMissing\n";
for (my $i=0; $i<6; $i++)
{
	print OUT "$year[$i]\t$total[$i]\t$miss[$i]\n"
}
close OUT