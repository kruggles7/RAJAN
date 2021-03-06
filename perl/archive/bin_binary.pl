#!/usr/bin/perl -w
#
use strict;
my $dir=""; 
my $filename = ""; 
my $zero = "";  
my $error = 0; 
my $j=0; 

if ($ARGV[0]=~/\w/) { $dir=$ARGV[0];} else { $error=1; }
if ($ARGV[1]=~/\w/) { $zero=$ARGV[1];} else { $error=1; }
my $path = "C:/Users/Kelly/Documents/MATLAB/Rajan"; 

if ($error ==0)
{
	opendir (DIR, "$path/$dir") or die "can't open directory"; 
	my @list= grep(/\.txt$/,readdir(DIR)); 
	closedir(DIR); 
	foreach my $file (@list)
	{
		print "$file\n"; 
		open (IN, "<$path/$dir/$file") or die "can't open file!"; 	
		$file =~s/(.*).txt/$1/; 
		open (OUT, ">$path/$dir/binary_results/$file.binary.txt") or die "can't open file!"; 
		while (my $line =<IN>)
		{
			while ($line=~s/^([^\t]*)\t//)
			{
				my $temp=$1; 
				if ($j==0)
				{
					my $year = $temp; 
					print OUT "\n$year\t"; 
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
		}
		close IN; 
		close OUT;
	}		
}
