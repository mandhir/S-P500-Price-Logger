#!/usr/bin/perl
use strict;
use warnings;
use HTTP::Tiny;
use HTML::Strip;

my $five = 'S&P500companieslist.csv';
open(my $comp, '<', $five)
  or die "Could not open file '$five' $!";

my (@arrayref, @array, $arrayref, $i, $j);
my $url = 'http://finance.yahoo.com/q?s=';

while (my $line = <$comp>) {
	i++;
@array = split(',', $line);
if ($array[0] eq "Ticker symbol")	{
	} else	{

	my $output = $array[1].'.txt';
	open(my $fh, '>>', $output) or die "Could not open file '$output' $!";

	my $fullurl = $url.$array[0];
	my $response = HTTP::Tiny->new->get($fullurl);
	if ($response->{success}) {
		j++;
    my $html = $response->{content};
    my $hs = HTML::Strip->new();

	my $clean_text = $hs->parse( $html );
	$hs->eof;

#things I want:

#	1. For Which Company
#	2. Date and time of pull request
#	3. 

#	date and time
	$clean_text =~ /(Off On)/g;
	my $datetime = substr ($clean_text, (1+ $+[0]), 28);

#$-[0] is the start position

	$clean_text =~ /\($array[0]\)(.*)\|/g;
	$1 =~ /\w\s\s\s(.*)/;
	print $fh $datetime, "\n", $1, "\n","\n";
		}
	}

}
print "$i Companies read\n";
print "$j Companies stock prices retrieved\n";

exit;