#!/usr/bin/perl -w

# this program creates a tab delimited file which contains the race information for all 6 years

use strict;

my @filename = ("Controls_2011", "Controls_2009", "Controls_2007", "Controls_2005", "Controls_2003", "Controls_2001");
my @year=(2011, 2009, 2007, 2005, 2003, 2001);
my %final_hash = (); 
my @miss=();
my @total=();
my $line=();
my $temp="";

# for 2011-2007: the race is in the first column (questions[0])
# 1:other, 2:other, 3:black, 4:other, 5:white, 6:hispanic, 7:hispanic, 8:other
for (my $i=0; $i<3; $i++)
{
	open (IN, "$filename[$i].txt") or die "can't open file";
	my $line1=<IN>; 
	while ($line1=<IN>)
	{
		my @questions=();
#		my @NEWquestions=();
		@questions = split ("\t", $line1);
		$temp=$questions[0];
		if ($temp!~/\w/)  #no answer
		{
			$questions[0]=0;
			$miss[$i]++;
		}
		elsif ($temp == 5) #whites
		{
			$questions[0]=1; 
		}
		elsif ($temp == 3) #blacks
		{
			$questions[0]=2;
		}
		elsif ($temp == 6 || $temp ==7 ) #hispanics
		{
			$questions[0]=3; 
		}
		elsif ($temp == 1 || $temp ==2 || $temp ==4 || $temp ==8) #other 
		{
			$questions[0]=4; 
		}
		else
		{
			$questions[0]="NaN";
		}
		$final_hash{$year[$i]}.="#$questions[0]#"; 
	$total[$i]++;
	}
	close IN;
}

# for 2005-2001: the race is in the fourth column (questions[3])
# 1:other, 2:other, 3:black, 4:hispanic, 5:other, 6:white: 7:hispanic, 8:other
for (my $i=3; $i<6; $i++)
{
	open (IN, "$filename[$i].txt") or die "can't open file";
	my $line2=<IN>; 
	while ($line2=<IN>)
	{
		my @questions=(); 
		@questions = split ("\t", $line2); 
		$temp=$questions[3];
		if ($temp!~/\w/) #no answer
		{
			$questions[3]=0;
			$miss[$i]++;
		}
		elsif ($temp == 6) #whites
		{
			$questions[3]=1; 
		}
		elsif ($temp == 3) #blacks
		{
			$questions[3]=2;
		}
		elsif ($temp == 4 || $temp ==7 ) #hispanics
		{
			$questions[3]=3; 
		}
		elsif ($temp == 1 || $temp ==2 || $temp ==5 || $temp ==8) #other 
		{
			$questions[3]=4; 
		}
		else
		{
			$questions[3]="NaN";
		}
		$final_hash{$year[$i]}.="#$questions[3]#"; 
	$total[$i]++;
	}
	close IN;
}

#put it all into a tab-delim file called race
open (OUT, ">race.txt") or die "cant't create file"; 
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

	
# # now take the race file and create a new tab_delim file called raceeth which contains
# # a 1 for whites, 2 for blacks, 3 for hispanics, 4 for others, and 0 for no response

# open (IN, "<race.txt") or die "cant open file"; 	
# open (OUT, ">raceeth.txt") or die "cant create file"; 
# while ($line =<IN>)
# {
	# while ($line=~s/^([^\t]*)\t//)
	# {
		# my $temp=$1; 
		# if ($temp == 5) #whites
		# {
			# print OUT "1\t"; 
		# }
		# elsif ($temp == 3) #blacks
		# {
			# print OUT "2\t";
		# }
		# elsif ($temp == 6 || $temp ==7 ) #hispanics
		# {
			# print OUT "3\t"; 
		# }
		# elsif ($temp == 1 || $temp ==2 || $temp ==4 || $temp ==8) #other 
		# {
			# print OUT "4\t"; 
		# }
		# else  #no answer
		# {
			# print OUT "$temp\t";
		# }
	# }
	# print OUT "\n";
# }
# close IN; 
# close OUT;	

	
#to create log of how many students were questioned and how many didn't give their race each year:

open (OUT, ">race-log.log") or die;
print OUT "Year \tTotal# \tMissing\n";
for (my $i=0; $i<6; $i++)
{
	print OUT "$year[$i]\t$total[$i]\t$miss[$i]\n"
}
close OUT