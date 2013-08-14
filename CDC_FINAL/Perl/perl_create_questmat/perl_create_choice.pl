#!/usr/bin/perl -w

# This program is used to make 2 tab delimited files from the CDC questions which contains the same question 
# for each of the 6 years: one "non-binary" and one binary.  THE ONLY ARGUMENT IS THE QUESTION NUMBER.
# The first output is a new file with all of the information, each year is a row each column is a subject.
# The second output is a new file with the binary information for that question which has a 1 for a "yes" and 0 for a "no" answer. 
# Also creates a 3rd file (log) with how many students answered the question each year and how many didn't.

# If you want the files being created to go somewhere specific, you must add it in. Otherwise they'll just be put into
# the folder you are running the script from

use strict;

my @filename = ("Data_2011","Data_2009", "Data_2007", "Data_2005", "Data_2003", "Data_2001");
my @year=(2011, 2009, 2007, 2005, 2003, 2001);
my @q=();
my @questions=(); 
my %final_hash = (); 
my $error0=0; 
my $error1=0; 
my $error=0; 
my $quest_name = ""; 
my $zero = "";
my $line = ""; 
my $line2 = "";
my $j=0 ;
my @miss=();
my @total=();

my $quest_choice=0;
my $k=0;
my @arr=();
my @ans=();
my $lines="";

my $l=0;
my $L=0;

if ($ARGV[0]=~/\w/) { $quest_choice=$ARGV[0];} else { $error=1; }

# The program now looks thru every line in the tab-delim text file "QUESTIONS" to find the line which contains the desired question.
# The tab-delim text file contains 8 columns: 1- the name for the output file.
# 2- the answer that means no. 3to8- the question number for 2011 2009 2007 2005 2003 2001.
# The program creates an array "ans", with 8 elements, matching the columns of the array

if ($error==0)
{
	open (IN, "<QUESTIONS.txt") or die; 	
	while ($lines=<IN>)
	{
		if ($lines=~ /^([^\t]+)\t([^\t]+)\t([^\t]+)/)
		{
			@arr= split ("\t", $lines);
			if ($1 eq "Q$quest_choice")
			{
				@ans=@arr;
			}
		}
	}
	close IN; 
}		

$l=@ans;
$L=$l-2;

$quest_name=$ans[0];
$zero=$ans[1];
 
for (my $i=0; $i<$L; $i++)
{
	if ($ans[$i+2]=~/\w/)
	{
		$q[$i]=$ans[$i+2];
	}
}

$L=@q; 

for (my $i=0; $i<$L; $i++)
{
	open (IN, "$filename[$i].txt") or die "can't open file";
	$line=<IN>; 
	while ($line=<IN>)
	{
		my @questions=(); 
		@questions = split ("\t", $line); 
		if ($questions[$q[$i]-8]!~/\w/)
		{
			$questions[$q[$i]-8]=0;
			$miss[$i]++;
		}
		$final_hash{$year[$i]}.="#$questions[$q[$i]-8]#"; 
	$total[$i]++;
	}
	close IN;
}


open (OUT, ">$quest_name.txt") or die; 
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

#to create binary files:

if ($error0==0 && $error1==0)
	{
		open (IN, "<$quest_name.txt"); 	
		open (OUT, ">$quest_name-binary.txt") or die; 
		while ($line2 =<IN>)
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
			print OUT "\n"
		}
		close IN; 
		close OUT;
		
		# to create NaN files:
		
		my $counter=0;

		my $newfilename="$quest_name-binary.txt";
		open (IN, "<$newfilename") or die "can't open file";
		$newfilename=~s/binary.txt$//; 
		open (OUT, ">$newfilename-NaN.txt") or die "cant create file";
		while (my $line=<IN>)
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

	}		
	
open (OUT, ">$quest_name-log.log") or die;
print OUT "Year \tTotal# \tMissing\n";
for (my $i=0; $i<$L; $i++)
{
	print OUT "$year[$i]\t$total[$i]\t$miss[$i]\n"
}
