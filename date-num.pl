#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';
use FindBin;
use lib "$FindBin::Bin/lib";
use Calcs;

my @data = <DATA>;

my $basedate = '2017/07/02';
$data[0] = '2017-10-15' unless @data;

# 数字を出力
my $calc = 1;

# 日付を出力
# $calc = 2;

if ($calc == 1) {
    my $ddn = dates2num($basedate, \@data);
    for (@data) {
        if (keys %$ddn) {
            say $ddn->{$_};
        }
    }
}
elsif ($calc == 2) {
    my $dnd = datenum2date($basedate, \@data, '-');
    for (@data) {
        if (keys %$dnd) {
            say "$dnd->{$_}";
        }
    }
}


__DATA__
