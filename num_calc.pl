#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';

my $msg = "Input (s|b|q).";
my $msg_error = "Please select correct one.";
my ($time_total, $time_calc, $ans_minute, $ans_hour);

my @list = <DATA>;
for my $calc_batch(@list) {
    if ($calc_batch =~ /^(\d+)$/) {
        $time_total += $1;
    } else {
        $time_total += 0;
    }
}

say "total: $time_total";
say "---";
for my $view(@list) {
    print $view;
}

__DATA__
6600
180
80
720
470
4580
10995
1980
7619
2594
844
470
720
1478
