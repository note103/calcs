#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';

my $time_total;
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
95
83
47
44
43
