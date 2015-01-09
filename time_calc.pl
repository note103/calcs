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
        $time_total += 0;
    }
}
$ans_hour = ($time_total / (60 * 60));
$ans_minute = (($time_total / 60) - ($ans_hour * 60) );
$ans_second = ($time_total) - ($ans_hour * 60 * 60) - ($ans_minute * 60);

say "total: $time_total";
say "ans: $ans_hour hours $ans_minute minutes $ans_second seconds.";
say "---";
for my $view(@list) {
    print $view;
}

__DATA__
1:33
1:01
2:45
4:40
3:41
3:18
2:07
3:05
6:03
4:30
6:29
6:08
8:37
9:37
3:33
5:02
5:32
