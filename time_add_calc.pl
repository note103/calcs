#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';
use integer;
use Time::Piece;
use Time::Seconds;

my ($time_total, $time_calc, $ans_minute, $ans_hour, $ans_second);

my @list = <DATA>;
for my $calc_batch(@list) {
    if ($calc_batch =~ /^(\d\d*):(\d\d):(\d\d)$/) {
        $time_total += $1*60*60 + $2*60 + $3;
    } elsif ($calc_batch =~ /^(\d\d?):(\d\d)$/) {
        $time_total += $1*60 + $2;
    } else {
        $calc_batch = "Error!\n";
    }
}
$ans_hour = ($time_total / (60 * 60));
$ans_minute = (($time_total / 60) - ($ans_hour * 60) );
$ans_second = ($time_total) - ($ans_hour * 60 * 60) - ($ans_minute * 60);

say "total: $time_total sec";
say "ans1: $ans_hour:$ans_minute:$ans_second";
say "ans2: $ans_hour hr $ans_minute min $ans_second sec";
say "---";
for my $view(@list) {
    print $view;
}

__DATA__
14:59
15:07
19:03
14:50
15:28
13:02
