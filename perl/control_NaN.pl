#/usr/bin/perl -w

use strict;

my $counter=0;
my $error=0;
my $line="";
my $dir="Controls_061514"; 
my @filename = ("race", "sex", "grade");

for (my $i=0; $i<3; $i++)
{
	open (IN, "$dir/$filename[$i].txt") or die "can't open file";
	print "$filename[$i].txt\n"; 
	open (OUT, ">$dir/$filename[$i]-NaN.txt") or die "cant create file"; 
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
}
