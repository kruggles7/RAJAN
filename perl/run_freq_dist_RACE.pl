#!/usr/bin/perl -w
#
use strict;

my $dir="parsed_questions"; 
#my $dir="test"; 

foreach my $filename2 ("RACE")
{
	opendir (DIR,$dir) or die "can't open directory"; 
	my @files= grep(/\.txt$/,readdir(DIR)); 
	foreach my $filename (@files)
	{
		print "$filename"; 
		my $error=0;
		my $variable=0;
		my $line = "";
		my %hash1=();
		my %hash2=();
		my $maxv1=0;
		my %val1=();
		my $maxv2=0;
		my %sum1=(); 
		my %combo=();
		my %sum2=();
		my %total1=();
		my %total2=(); 
		open (IN, "<$dir/$filename") or die "can't open file";
		$filename=~s/.txt$//; 
		while ($line=<IN>)
		{
			if ($line=~s/^([^\t]*)\t*//)
			{
				my $year = $1;
				$hash1{$year}=$line;
				my $value=0; 
				for (my $j=0; $j<9; $j++)
				{
					$value=$hash1{$year}=~/$j/gi; 
					if ($value>0)
					{
						$maxv1=$j; 
					}
				}
			}
		}
		close IN;
		open (OUT, ">$dir/results/$filename.freq.txt") or die "can't open file";
		print OUT "TOTAL SAMPLE SIZE BY YEAR\nYear\tTotal Sample Size\n"; 
		foreach my $key (sort {$a<=>$b} keys %hash1) #for each year
		{
			$total1{$key}=0; 
			print OUT "$key\t";
			#count the number of times each number is found in the line
			my $missing1=0;
			for (my $j=0; $j<=$maxv1; $j++)
			{
				$sum1{$j}=()=$hash1{$key}=~/$j/gi;
				if ($j==0)
				{
					$missing1=$sum1{$j}; 
				}
				else
				{
					$total1{$key}=$total1{$key}+$sum1{$j}; #gives us the total sample size 
				}
			}
			print OUT "$total1{$key}\n";
			%sum1=(); 
		}
		print OUT "\nPREVELANCE (PERCENTAGE)\nYear\t";
		for (my $j=0; $j<=$maxv1; $j++)
		{
			if ($j!=0)
			{
				print OUT "$j\t"; #0 means missing 
			} 
		}
		print OUT "\n";
		foreach my $key (sort {$a<=>$b} keys %hash1) #for each year
		{
			print OUT "$key\t";
			for (my $j=1; $j<=$maxv1; $j++)
			{
			   $sum1{$j}=()=$hash1{$key}=~/$j/gi; 
			}
			foreach my $key2 (sort {$a<=>$b} keys %sum1) #print out the percentage and number 
			{
				my $percent=$sum1{$key2}/$total1{$key}*100;
				print OUT "$percent\t";
			}
			print OUT "\n";
		}
		print OUT "\nPREVELANCE (Number)\nYear\t";
		for (my $j=0; $j<=$maxv1; $j++)
		{
			if ($j!=0)
			{
				print OUT "$j\t"; #0 means missing 
			} 
		}
		print OUT "\n";
		foreach my $key (sort {$a<=>$b} keys %hash1) #for each year
		{
			print OUT "$key\t";
			for (my $j=1; $j<=$maxv1; $j++)
			{
			   $sum1{$j}=()=$hash1{$key}=~/$j/gi; 
			}
			foreach my $key2 (sort {$a<=>$b} keys %sum1) #print out the percentage and number 
			{
				print OUT "$sum1{$key2}\t"; 
			}
			print OUT "\n";
			%sum1=(); 
		}
		if ($filename2 =~/\w/)
		{
			open (IN, "<controls/$filename2.txt") or die "can't open file";
			print "-$filename2\n"; 
			while ($line=<IN>)
			{
				if ($line=~s/^([^\t]*)\t*//)
				{
					my $year = $1;
					$hash2{$year}=$line; 
					my $value=0; 
					for (my $j=0; $j<9; $j++)
					{
						$value=$hash2{$year}=~/$j/gi; 
						if ($value>0)
						{
							$maxv2=$j; 
						}
					}
				}
			}
			close IN;
			open (OUT, ">$dir/results/$filename.$filename2.freq.txt") or die "can't open file";
			for (my $k=1; $k<=$maxv2; $k++)
			{
				print OUT "\nPREVELANCE (PERCENTAGE)\t";
				print OUT "Conditioned on $filename2: Answer $k\nYear\t"; #start with the first conditioning variable
				for (my $j=1; $j<=$maxv1; $j++)
				{
				   print OUT "$j\t";
				}
				print OUT "\n";         
				foreach my $key (sort {$a<=>$b} keys %hash2) #run through the years 
				{
					print OUT "$key\t";
					%combo=();
					$total2{$key}=0;
					my $v1=$hash1{$key};
					my $v2=$hash2{$key};
					my $temp1="";
					my $temp2="";
					while ($v1=~/\w/)
					{
						if ($v1=~s/^([^\t]*)\t+//)
						{
							$temp1=$1;
							
						}
						if ($v2=~s/^([^\t]*)\t+//)
						{
							$temp2=$1; 
						}
						#print "$temp1\t$temp2\n";
						$combo{$temp2}.="$temp1\t";
						#print "$temp2\t$combo{$temp2}\n"
					}
					for (my $j=1; $j<=$maxv1; $j++)
					{
						$sum2{$j}=()=$combo{$k}=~/$j/gi;
						$total2{$key}=$total2{$key}+$sum2{$j};
					}
					for (my $j=1; $j<=$maxv1; $j++)
					{
						my $percent = $sum2{$j}/$total2{$key}*100;
						#print "$j\t$sum2{$j}\n";
						print OUT "$percent\t"; 
					}
					print OUT "\n";
				}
			}
			for (my $k=1; $k<=$maxv2; $k++)
			{
				print OUT "\nPREVELANCE (Number)\t";
				print OUT "Conditioned on $filename2: Answer $k\nYear\t"; #start with the first conditioning variable
				for (my $j=1; $j<=$maxv1; $j++)
				{
				   print OUT "$j\t";
				}
				print OUT "\n";         
				foreach my $key (sort {$a<=>$b} keys %hash2) #run through the years 
				{
					print OUT "$key\t";
					%combo=();
					my $v1=$hash1{$key};
					my $v2=$hash2{$key};
					my $temp1="";
					my $temp2="";
					while ($v1=~/\w/)
					{
						if ($v1=~s/^([^\t]*)\t+//)
						{
							$temp1=$1;
							
						}
						if ($v2=~s/^([^\t]*)\t+//)
						{
							$temp2=$1; 
						}
						#print "$temp1\t$temp2\n";
						$combo{$temp2}.="$temp1\t";
						#print "$temp2\t$combo{$temp2}\n"
					}
					for (my $j=1; $j<=$maxv1; $j++)
					{
						$sum2{$j}=()=$combo{$k}=~/$j/gi;
						print OUT "$sum2{$j}\t"; 
					}
					print OUT "\n";
				} 
			}
		}
		else 
		{
			print "\n"; 
		}
	}
	close DIR; 
}