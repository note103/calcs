#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';
use Time::Piece;
use Time::Seconds;

my $switch = 'Sun';
#my $switch = 'Sunday';
#my $switch = '日';
#my $switch = '日曜日';

my ($stamp_local, $stamp_day);
my @week = <DATA>;
for (@week) {
    chomp $_;
    my $output = $_;
    $_ =~ s/\//-/g;
    $stamp_local = localtime->strptime($_, '%Y-%m-%d');
    if ($switch eq 'Sun') {
        $stamp_day = $stamp_local->wdayname;
    } elsif ($switch eq 'Sunday') {
        $stamp_day = $stamp_local->fullday;
    } elsif ($switch eq '日') {
        $stamp_day = $stamp_local->wdayname(qw{日 月 火 水 木 金 土});
    } elsif ($switch eq '日曜日') {
        $stamp_day = $stamp_local->wdayname(qw{日曜日 月曜日 火曜日 水曜日 木曜日 金曜日 土曜日});
    }
    say $output."\t".$stamp_day;
}

__DATA__
2015/12/30
2015/12/30
2015/12/30
2015/12/30
2015/12/31
2015/12/31
2015/12/31
2016/1/1
2016/1/1
2016/1/1
