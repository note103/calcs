#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';
use Time::Piece;
use Time::Seconds;
my ($pday, $phour, $pminute, $psecond);
my ($day, $hour, $minute, $second) = (0, 0, 0, 0);

my @list = <DATA>;
chomp @list;
for (@list) {
    $_ =~ s/\//-/g;
    if ($_ =~ /^(\d\d?:.+)$/) {
        my $d = localtime->date;
        $_ = "$d $1";
    }
}

my $date1 = $list[0];
my $date2 = $list[1];
stamp($date1, $date2);

sub stamp {
    my ($date3, $date4) = @_;
    my $stamp_local = localtime->strptime("$date3", '%Y-%m-%d %T');
    my $stamp_local2 = localtime->strptime("$date4", '%Y-%m-%d %T');

    my $substract_day = ($stamp_local - $stamp_local2) / ONE_DAY;
    $day = sprintf("%d", $substract_day);
    my $substract_hour = (($stamp_local - $stamp_local2) - $day * ONE_DAY) / ONE_HOUR;
    $hour = sprintf("%d", $substract_hour);
    my $substract_minute = ($stamp_local - $stamp_local2 - ($day * ONE_DAY) - ($hour * ONE_HOUR)) / ONE_MINUTE;
    $minute = sprintf("%d", $substract_minute);
    my $substract_second = ($stamp_local - $stamp_local2 - ($day * ONE_DAY) - ($hour * ONE_HOUR) -  ($minute * ONE_MINUTE));
    $second = sprintf("%d", $substract_second);

    ($day, $hour, $minute, $second) = map {abs($_)} ($day, $hour, $minute, $second);
    plural($pday, $phour, $pminute, $psecond);

    my $result = "$day $pday $hour $phour $minute $pminute $second $psecond\n";
    say $result;
}

sub plural {
    ($pday, $phour, $pminute, $psecond) = @_;
    unless ($day == 1) { $pday = 'days'; } else { $pday = 'day'; }
    unless ($hour == 1) { $phour = 'hours'; } else { $phour = 'hour'; }
    unless ($minute == 1) { $pminute = 'minutes'; } else { $pminute = 'minute'; }
    unless ($second == 1) { $psecond = 'seconds'; } else { $psecond = 'second'; }
}
__DATA__
2015-07-18 22:00:00
2015-07-01 11:03:38
2015-10-28
