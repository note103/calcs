#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';
use Time::Piece;
use Time::Seconds;

my @list = <DATA>;
chomp @list;
my $date = $list[0];
my $num = $list[1];

my $stamp_local = localtime->strptime("$date", '%Y-%m-%d');
my $add = $stamp_local + ONE_DAY * $num;
say $add->ymd." (add)";
my $substract = $stamp_local - ONE_DAY * $num;
say $substract->ymd." (substract)";

__DATA__
2014-12-14
14
