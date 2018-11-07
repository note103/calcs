#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';
use FindBin;
use lib "$FindBin::Bin/lib";
use Calcs;


my @data = <DATA>;

my $weeks = week(\@data, 1);
for (@data) {
    say "$_\t$weeks->{$_}";
}


__DATA__
2018-11-07
