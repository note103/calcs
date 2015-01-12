#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';
use Time::Piece;
use Time::Seconds;

my ($stamp_local, $stamp_day);
my @week = <DATA>;
for (@week) {
    chomp $_;
    my $output = $_;
    $_ =~ s/\//-/g;
    #$stamp_local = localtime->strptime($_, '%Y-%m-%d');
    $stamp_day = $stamp_local->fullday; #Sunday
    $stamp_day = $stamp_local->wdayname; #Sun
    say $output."\t".$stamp_day;
}
__DATA__
2014-12-16
2014-12-24
2014/9/6
2014/9/10

