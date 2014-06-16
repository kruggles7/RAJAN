#!/usr/bin/perl -w

# this program creates a tab delimited file which contains the race information for all 6 years

use strict;

my @filename = ("Controls_2013", "Controls_2011", "Controls_2009", "Controls_2007", "Controls_2005", "Controls_2003", "Controls_2001");
my @year=(2013, 2011, 2009, 2007, 2005, 2003, 2001);
my %final_hash = (); 
my @miss=();
my @total=();
my $line=();
my $temp="";
my %final_sex=();
my %final_grade=();
my $out="Controls_061514";
mkdir "$out"; 

# for 2013-2007: the race is in the first column (questions[0])
# 1:other, 2:other, 3:black, 4:other, 5:white, 6:hispanic, 7:hispanic, 8:other
for (my $i=0; $i<4; $i++)
{
	open (IN, "$filename[$i].txt") or die "can't open file $filename[$i].txt\n";
	my $line1=<IN>; 
	while ($line1=<IN>)
	{
		my @questions=();
		@questions = split ("\t", $line1);
		$temp=$questions[0];
		my $sex=$questions[2];
		my $grade=$questions[3];
		#deal with race----------------
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
		#deal with sex---------------------------
		if ($sex!~/\w/)
		{
			$questions[2]=0; 
		}
		$final_sex{$year[$i]}.="#$questions[2]#"; 
		#deal with grade---------------------------
		if ($grade!~/\w/)
		{
			$questions[3]=0; 
		}
		$final_grade{$year[$i]}.="#$questions[3]#"; 
		$total[$i]++;
	}
	close IN;
}

# for 2005-2001: the race is in the fourth column (questions[3])
# 1:other, 2:other, 3:black, 4:hispanic, 5:other, 6:white: 7:hispanic, 8:other
for (my $i=4; $i<7; $i++)
{
	open (IN, "$filename[$i].txt") or die "can't open file";
	my $line2=<IN>; 
	while ($line2=<IN>)
	{
		my @questions=(); 
		@questions = split ("\t", $line2); 
		$temp=$questions[3];
		my $sex=$questions[1];
		my $grade=$questions[2]; 
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
		#deal with sex---------------------------
		if ($sex!~/\w/)
		{
			$questions[1]=0; 
		}
		$final_sex{$year[$i]}.="#$questions[1]#"; 
		#deal with grade---------------------------
		if ($grade!~/\w/)
		{
			$questions[2]=0; 
		}
		$final_grade{$year[$i]}.="#$questions[2]#"; 
	$total[$i]++;
	}
	close IN;
}

#put it all into a tab-delim file called race
open (OUT, ">$out/race.txt") or die "cant't create file"; 
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


open (OUT, ">$out/sex.txt") or die "cant't create file"; 
$ans=""; 
foreach my $key (sort keys %final_sex)
{
	print OUT "$key\t"; 
	my $temp = $final_sex{$key}; 
	while ($temp=~s/^#([^#]+)#//)
	{
		$ans=$1; 
		print OUT "$ans\t"; 
	}
	print OUT "\n"; 
}
close OUT;


open (OUT, ">$out/grade.txt") or die "cant't create file"; 
$ans=""; 
foreach my $key (sort keys %final_grade)
{
	print OUT "$key\t"; 
	my $temp = $final_grade{$key}; 
	while ($temp=~s/^#([^#]+)#//)
	{
		$ans=$1; 
		print OUT "$ans\t"; 
	}
	print OUT "\n"; 
}
close OUT;


open (OUT, ">$out/race-log.log") or die;
print OUT "Year \tTotal# \tMissing\n";
for (my $i=0; $i<6; $i++)
{
	print OUT "$year[$i]\t$total[$i]\t$miss[$i]\n"
}
close OUT