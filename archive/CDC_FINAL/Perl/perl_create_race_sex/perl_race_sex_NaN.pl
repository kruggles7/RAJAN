#/usr/bin/perl -w

use strict;

my $counter=0;
my $error=0;
my $filename="";
my $line="";

if ($ARGV[0]=~/\w/) {$filename=$ARGV[0];} else { $error=1; };

if ($error==0)
{
	open (IN, "<$filename.txt") or die "can't open file";
	open (OUT, ">$filename-NaN.txt") or die "cant create file"; 
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
