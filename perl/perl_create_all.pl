#!/usr/bin/perl -w

# This program is used to make 2 tab delimited files for each year from the CDC questions which contains the same question 
# for each of the 6 years: one "non-binary" and one binary.  NO ARGUMENTS.
# The first output is a new file with all of the information, each year is a row each column is a subject.
# The second output is a new file with the binary information for that question which has a 1 for a "yes" and 0 for a "no" answer. 
# Also creates a 3rd file (log) with how many students answered the given question each year and how many didn't.

use strict;

my $results='results_061514'; 
mkdir $results; 
my @filename = ("Data_2013", "Data_2011", "Data_2009", "Data_2007", "Data_2005", "Data_2003", "Data_2001");
my @year=(2013, 2011, 2009, 2007, 2005, 2003, 2001);
my @q=();
my @questions=(); 
my %final_hash = (); 
my $error0=0; 
my $error1=0; 
my $quest_name = ""; 
my $zero = "";
my $line = ""; 
my $line2 = "";
my $j=0 ;

my @miss=();
my @total=();

my $k=0;
my @arr=();
my @ans=();
my $lines="";

my $l=0;

# The program now looks thru every line in the tab-delim text file "QUESTIONS"
# The tab-delim text file contains 8 columns: 1- the name for the output file.
# 2- the answer that means no. 3to8- the question number for 2011 2009 2007 2005 2003 2001.
# For each line, the program creates an array "ans", with 8 elements (unless the given question wasn't asked every year,
# then it'll be less), matching the columns of the array


open (IN, "<QUESTIONS_061514.txt") or die; 	
while ($lines=<IN>)
{
	if ($lines=~ /\w/)
	{
		@ans= split ("\t", $lines);

		$l=9;
		@q=();
		
		if ($ans[0]=~/\w/) { $quest_name=$ans[0];} else { $error0=1; }
		if ($ans[1]=~/\w/) { $zero=$ans[1];} else { $error1=1; }
		
		if ($error0==0 && $error1==0)
		{
		
			for (my $i=2; $i<$l; $i++)
			{
				if ($ans[$i]=~/\w/)
				{
					$q[$i]=$ans[$i];
				}
				else
				{
					$q[$i]=0; 
				}
			}
			
			@total=(); #resets total each round
			@miss=(); #resets miss
			%final_hash=(); #resets final_hash
			
			for (my $i=2; $i<$l; $i++)
			{
				my $j=$i-2;
				print "$filename[$j]\t$j\n"; 
				open (IN2, "$filename[$j].txt") or die "can't open file $filename[$j]";
				$line=<IN2>; 
				while ($line=<IN2>)
				{
					my @questions=(); 
					@questions = split ("\t", $line);
					if ($q[$i]>0)
					{
						if ($questions[$q[$i]-8]!~/\w/)
						{
							$questions[$q[$i]-8]=0;
							$miss[$i]++;
						}
						$final_hash{$year[$i-2]}.="#$questions[$q[$i]-8]#";
						$total[$i]++;
					}
				}
				close IN2;
			}

			open (OUT, ">$results/$quest_name.txt") or die; 
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

			#to create binary file:
			
			open (IN3, "<$results/$quest_name.txt"); 	
			open (OUT, ">$results/$quest_name-binary.txt") or die; 
			while ($line2 =<IN3>)
			{
				while ($line2=~s/^([^\t]*)\t//)
				{
					my $temp=$1; 
					if ($j==0)
					{
						my $yr = $temp; 
						print OUT "$yr\t"; 
						$j=1; 
					}
					else 
					{
						if ($temp == 0)
						{
							print OUT "9\t"; #indicates the data is missing 
						}
						elsif ($temp eq $zero)
						{
							print OUT "0\t"; 
						}
						else 
						{
							print OUT "1\t"; 
						}
					}
				}
				$j=0; 
				print OUT "\n";
			}
			close IN3; 
			close OUT;
			
			#to create log of how many students were questioned and how many didn't answer: 
			
			open (OUT, ">$results/$quest_name-log.log") or die;
			print OUT "Year \tTotal# \tMissing\n";
			for (my $i=2; $i<$l; $i++)
			{
				print OUT "$year[$i-2]\t$total[$i]\t$miss[$i]\n"
			}

		}
		
	}
}
close IN; 