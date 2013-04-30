#!/usr/bin/perl -w
#
use strict;

my $filename1 = "YRBS2011_TD"; 
my $filename2 = "YRBS2009_TD"; 
my $filename3 = "YRBS2007_TD";
my $filename4 = "YRBS2005_TD";
my $filename5 = "YRBS2003_TD";
my $filename6 = "YRBS2001_TD";
my $q1=""; 
my $q2=""; 
my $q3=""; 
my $q4=""; 
my $q5=""; 
my $q6=""; 
my @questions=(); 
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
if ($ARGV[1]=~/\w/) { $q1=$ARGV[1];} else { $error1=1; }
if ($ARGV[2]=~/\w/) { $q2=$ARGV[2];} else { $error2=1; }
if ($ARGV[3]=~/\w/) { $q3=$ARGV[3];} else { $error3=1; }
if ($ARGV[4]=~/\w/) { $q4=$ARGV[4];} else { $error4=1; }
if ($ARGV[5]=~/\w/) { $q5=$ARGV[5];} else { $error5=1; }
if ($ARGV[6]=~/\w/) { $q6=$ARGV[6];} else { $error6=1; }

if ($error1==0)
{
	open (IN, "<$filename1.dat") or die "can't open file";
	while ($line=<IN>)
	{
		@questions = split ("\t", $line); 
		if ($questions[$q1-1]!~/\w/) {$questions[$q1-1]=0;}
		$final_hash{2011}.="#$questions[$q1-1]#"; 
	}
	close IN;
}

if ($error2==0)
{
	my @questions=(); 
	open (IN, "<$filename2.dat") or die "can't open file";
	$line = <IN>;
	while ($line=<IN>)
	{
		@questions = split ("\t", $line); 
		if ($questions[$q2-1]!~/\w/) {$questions[$q2-1]=0;}
		$final_hash{2009}.="#$questions[$q2-1]#"; 
	}
	close IN;
}

if ($error3==0)
{
	my @questions=(); 
	open (IN, "<$filename3.dat") or die "can't open file";
	$line = <IN>;
	while ($line=<IN>)
	{
		@questions = split ("\t", $line); 
		if ($questions[$q3-1]!~/\w/) {$questions[$q3-1]=0;}
		$final_hash{2007}.="#$questions[$q3-1]#"; 
	}
	close IN;
}

if ($error4==0)
{
	my @questions=(); 
	open (IN, "<$filename4.dat") or die "can't open file";
	$line = <IN>;
	while ($line=<IN>)
	{
		@questions = split ("\t", $line); 
		if ($questions[$q4-1]!~/\w/) {$questions[$q4-1]=0;}
		$final_hash{2005}.="#$questions[$q4-1]#"; 
	}
	close IN;
}

if ($error5==0)
{
	my @questions=(); 
	open (IN, "<$filename5.dat") or die "can't open file";
	$line = <IN>;
	while ($line=<IN>)
	{
		@questions = split ("\t", $line); 
		if ($questions[$q5-1]!~/\w/) {$questions[$q5-1]=0;}
		$final_hash{2003}.="#$questions[$q5-1]#"; 
	}
	close IN;
}

if ($error6==0)
{
	my @questions=(); 
	open (IN, "<$filename6.dat") or die "can't open file";
	$line = <IN>;
	while ($line=<IN>)
	{
		@questions = split ("\t", $line); 
		if ($questions[$q6-1]!~/\w/) {$questions[$q6-1]=0;}
		$final_hash{2001}.="#$questions[$q6-1]#"; 
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

