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
    $stamp_local = localtime->strptime($_, '%Y-%m-%d');
    $stamp_day = $stamp_local->fullday; #Sunday
    #$stamp_day = $stamp_local->wdayname; Sun
    say $_."\t".$stamp_day;
}

__DATA__
2014-12-14
2014-12-13
2014-12-16
2014-12-24
