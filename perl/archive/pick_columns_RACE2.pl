#!/usr/bin/perl -w
#
use strict;

my $filename1 = "YRBS2011_TD"; 
my $filename2 = "YRBS2009_TD"; 
my $filename3 = "YRBS2007_TD";
my $filename4 = "YRBS2005_TD";
my $filename5 = "YRBS2003_TD";
my $filename6 = "YRBS2001_TD";
my $q1_1="";
my $q1_2=""; 
my $q2_1="";
my $q2_2=""; 
my $q3_1="";
my $q3_2=""; 
my $q4=""; 
my $q5=""; 
my $q6=""; 
my @questions=();
my @questions2=(); 
my %final_hash = (); 
my $error1=0; 
my $error2=0; 
my $error3=0; 
my $error4=0; 
my $error5=0; 
my $error6=0;
my $error7=0; 
my $quest_name = ""; 
my $line = ""; 

if ($ARGV[0]=~/\w/) { $quest_name=$ARGV[0];} else { $error7=1; }
#do 2001-2005 normally with question 4 
if (($ARGV[1]=~/\w/) and ($ARGV[1]!=0)){ $q4=$ARGV[1];} else { $error4=1; }
if (($ARGV[2]=~/\w/)and ($ARGV[2]!=0)) { $q5=$ARGV[2];} else { $error5=1; }
if (($ARGV[3]=~/\w/) and ($ARGV[3]!=0)){ $q6=$ARGV[3];} else { $error6=1; }

if ($error4==0)
{
	my @questions=();
	my $a=0;
	open (IN, "<$filename4.dat") or die "can't open file";
	$line = <IN>;
	while ($line=<IN>)
	{
		@questions = split ("\t", $line); 
		if ($questions[$q4-1]!~/\w/) {$a=0;}
		elsif ($questions[$q4-1]==4)
		{
			$a=6; 
		}
		elsif ($questions[$q4-1]==5)
		{
			$a=4; 
		}
		elsif ($questions[$q4-1]==6)
		{
			$a=5; 
		}
		else
		{
			$a=$questions[$q4-1]; 
		}
		$final_hash{2005}.="#$a#"; 
	}
	close IN;
}

if ($error5==0)
{
	my @questions=();
	my $a=0; 
	open (IN, "<$filename5.dat") or die "can't open file";
	$line = <IN>;
	while ($line=<IN>)
	{
		@questions = split ("\t", $line); 
		if ($questions[$q5-1]!~/\w/) {$questions[$q5-1]=0;}
		elsif ($questions[$q5-1]==4)
		{
			$a=6; 
		}
		elsif ($questions[$q5-1]==5)
		{
			$a=4; 
		}
		elsif ($questions[$q5-1]==6)
		{
			$a=5; 
		}
		else
		{
			$a=$questions[$q5-1]; 
		}
		$final_hash{2003}.="#$a#"; 
	}
	close IN;
}

if ($error6==0)
{
	my @questions=();
	my $a=0; 
	open (IN, "<$filename6.dat") or die "can't open file";
	$line = <IN>;
	while ($line=<IN>)
	{
		@questions = split ("\t", $line); 
		if ($questions[$q6-1]!~/\w/) {$questions[$q6-1]=0;}
		elsif ($questions[$q6-1]==4)
		{
			$a=6; 
		}
		elsif ($questions[$q6-1]==5)
		{
			$a=4; 
		}
		elsif ($questions[$q6-1]==6)
		{
			$a=5; 
		}
		else
		{
			$a=$questions[$q6-1]; 
		}
		$final_hash{2001}.="#$a#"; 
	}
	close IN;
}

#now deal with 2007-2011
if (($ARGV[4]=~/\w/) and ($ARGV[4]!=0)) { $q1_1=$ARGV[4];} else { $error1=1; }
if (($ARGV[5]=~/\w/)and ($ARGV[5]!=0)) { $q1_2=$ARGV[5];} else { $error1=1; }

if (($ARGV[6]=~/\w/)and ($ARGV[6]!=0)) { $q2_1=$ARGV[6];} else { $error2=1; }
if (($ARGV[7]=~/\w/) and ($ARGV[7]!=0)) { $q2_2=$ARGV[7];} else { $error2=1; }

if (($ARGV[8]=~/\w/)and ($ARGV[8]!=0)) { $q3_1=$ARGV[8];} else { $error3=1; }
if (($ARGV[9]=~/\w/)and ($ARGV[9]!=0)) { $q3_2=$ARGV[9];} else { $error3=1; }

if ($error1==0)
{
	open (IN, "<$filename1.dat") or die "can't open file";
	while ($line=<IN>)
	{
		@questions = split ("\t", $line);
		if ($questions[$q1_1-1]!~/\w/) {$questions[$q1_1-1]=0;}
		if ($questions[$q1_2-1]!~/\w/) {$questions[$q1_2-1]=0;}
		my $i=$questions[$q1_1-1];
		my $j=$questions[$q1_2-1];
		#print "$i\t$j\n";
		my $k="";
		$j =~ s/\s+//g;
		#print "$j\n";
		if ($i==1) #A
		{
			if ($j eq '0')
			{
				$k=6; 
			}
			else
			{
				$k=7; 
			}
			
		}
		elsif ($i==2) #B
		{
			my $Lj=length($j);
			if ($Lj > 1)#more than one letter
			{
				$k=8; 
			}
			elsif ($j eq 'A')
			{
				$k=1; 
			}
			elsif ($j eq 'B')
			{
				$k=2; 
			}
			elsif ($j eq 'C')
			{
				$k=3; 
			}
			elsif ($j eq 'D')
			{
				$k=4; 
			}
			elsif ($j eq 'E')
			{
				$k=5; 
			}
			else
			{
				$k=0; 
			}
		}
		else
		{
			$k=0; 
		}
		$final_hash{2011}.="#$k#"; 
	}
	close IN;
}

if ($error2==0)
{
	open (IN, "<$filename2.dat") or die "can't open file";
	$line=<IN>; 
	while ($line=<IN>)
	{
		@questions = split ("\t", $line);
		if ($questions[$q2_1-1]!~/\w/) {$questions[$q2_1-1]=0;}
		if ($questions[$q2_2-1]!~/\w/) {$questions[$q2_2-1]=0;}
		my $i=$questions[$q1_1-1];
		my $j=$questions[$q2_2-1];
		my $k="";
		$j =~ s/\s+//g;
		#print "$j\n";
		if ($i==1) #A
		{
			if ($j eq '0')
			{
				$k=6; 
			}
			else
			{
				$k=7; 
			}
			
		}
		elsif ($i==2) #B
		{
			my $Lj=length($j);
			if ($Lj > 1)#more than one letter
			{
				$k=8; 
			}
			elsif ($j eq 'A')
			{
				$k=1; 
			}
			elsif ($j eq 'B')
			{
				$k=2; 
			}
			elsif ($j eq 'C')
			{
				$k=3; 
			}
			elsif ($j eq 'D')
			{
				$k=4; 
			}
			elsif ($j eq 'E')
			{
				$k=5; 
			}
			else
			{
				$k=0; 
			}
		}
		else
		{
			$k=0; 
		}
		$final_hash{2009}.="#$k#"; 
	}
close IN;
}

if ($error3==0)
{
	open (IN, "<$filename3.dat") or die "can't open file";
	$line=<IN>; 
	while ($line=<IN>)
	{
		@questions = split ("\t", $line);
		if ($questions[$q3_1-1]!~/\w/) {$questions[$q3_1-1]=0;}
		if ($questions[$q3_2-1]!~/\w/) {$questions[$q3_2-1]=0;}
		my $i=$questions[$q3_1-1];
		my $j=$questions[$q3_2-1];
		my $k="";
		$j =~ s/\s+//g;
		#print "$j\n";
		if ($i==1) #A
		{
			if ($j eq '0')
			{
				$k=6; 
			}
			else
			{
				$k=7; 
			}
			
		}
		elsif ($i==2) #B
		{
			my $Lj=length($j);
			if ($Lj > 1)#more than one letter
			{
				$k=8; 
			}
			elsif ($j eq 'A')
			{
				$k=1; 
			}
			elsif ($j eq 'B')
			{
				$k=2; 
			}
			elsif ($j eq 'C')
			{
				$k=3; 
			}
			elsif ($j eq 'D')
			{
				$k=4; 
			}
			elsif ($j eq 'E')
			{
				$k=5; 
			}
			else
			{
				$k=0; 
			}
		}
		else
		{
			$k=0; 
		}
		$final_hash{2007}.="#$k#"; 
	}
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

