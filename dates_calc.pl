#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';
use Time::Piece;
use Time::Seconds;

my @list = <DATA>;
chomp @list;
for (@list) {
    $_ =~ s/\//-/g;
}
my $date1 = $list[0];
my $date2 = $list[1];

my $stamp_local = localtime->strptime("$date1", '%Y-%m-%d');
my $stamp_local2 = localtime->strptime("$date2", '%Y-%m-%d');
my $substract = ($stamp_local - $stamp_local2) / ONE_DAY;
say $substract;

__DATA__
2014-12-15
2015/8/3
