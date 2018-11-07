package Calcs;
use strict;
use warnings;
use feature 'say';
use Time::Piece;
use Time::Seconds;

use parent 'Exporter';
our @EXPORT = qw/
    diff_datetime
    dates2num
    datenum2date
    add_time
    week
/;


our $VERSION = "0.01";

sub week {
    my $data = shift;
    my $fmt = 1;
    $fmt = shift;

    my $date;
    my $date_buf;
    my $day;
    my $obj;

    my %week;
    for (@$data) {
        chomp $_;

        if ($_ =~ m!\A(\d{4}[/-]\d\d?[/-]\d\d?)\z!) {
            $date_buf = $1;
            $date = $date_buf;
            $date =~ s/\//-/g;

            $obj = localtime->strptime($date, '%Y-%m-%d');
            if ($fmt eq 1) {
                $day = $obj->wdayname;
            } elsif ($fmt eq 2) {
                $day = $obj->fullday;
            } elsif ($fmt eq 3) {
                $day = $obj->wdayname(qw/日 月 火 水 木 金 土/);
            } elsif ($fmt eq 4) {
                $day = $obj->wdayname(qw/日曜日 月曜日 火曜日 水曜日 木曜日 金曜日 土曜日/);
            }
            $week{$date_buf} = $day;
        }
        else {
            $week{$_} = "";
        }
    }
    return \%week;
}

sub add_time {
    my $data = shift;

    my $hour = 0;
    my $minute = 0;
    my $second = 0;
    my $sum_hour = 0;
    my $sum_minute = 0;
    my $sum_second = 0;

    for my $data(@$data) {
        if ($data =~ /\A(\d\d?):(\d\d?):(\d\d)/) {
            $hour = $1;
            $minute = $2;
            $second = $3;
        }
        elsif ($data =~ /\A(\d\d?):(\d\d)/) {
            $minute = $1;
            $second = $2;
        }
        else {
            next;
        }
        $sum_hour += $hour;
        $sum_minute += $minute;
        $sum_second += $second;
    }
    my $seconds = ($sum_minute * 60) + $sum_second;

    my $minutes = 0;
    if ($seconds > 60) {
        $minutes = int ($seconds / 60);
        $seconds = $seconds - ($minutes * 60);
    }

    my $hours = 0;
    if ($minutes > 60) {
        $hours = int ($minutes / 60);
        $minutes = $minutes - ($hours * 60);

        $minutes = "0$minutes" if $minutes =~ /\A\d\z/;
        $seconds = "0$seconds" if $seconds =~ /\A\d\z/;
    }
    else {
        $seconds = "0$seconds" if $seconds =~ /\A\d\z/;
    }

    $hours += $sum_hour;

    if ($hours != 0) {
        return "$hours:$minutes:$seconds";
    }
    else {
        return "$minutes:$seconds";
    }
}


sub dates2num {
    my ($basedate, $dates) = @_;

    $basedate =~ s/\//-/g;
    my $obj_basedate = localtime->strptime($basedate, '%Y-%m-%d');

    my %result;
    for my $date (@$dates) {
        chomp $date;

        my $result;
        if ($date =~ /^\d{4}/) {
            $date =~ s/\//-/g;

            my $obj_date = localtime->strptime($date, '%Y-%m-%d');
            $result = ($obj_basedate - $obj_date) / ONE_DAY;

            $date =~ s/-/\//g;
            $basedate =~ s/-/\//g;
        }
        else {
            $result = '';
        }
        $result{$date} = $result;
    }
    return \%result;
}

sub datenum2date {
    my ($basedate, $nums, $operator) = @_;

    my $date;
    my $obj_result;

    my %result;
    for my $num (@$nums) {
        chomp $num;
        $date = '';

        if ($num =~ /\A\d+\z/) {
            $basedate =~ s/\//-/g;

            my $obj_basedate = localtime->strptime($basedate, '%Y-%m-%d');

            if ($operator eq '-') {
                $obj_result = $obj_basedate - ONE_DAY * $num;
            }
            else {
                $obj_result = $obj_basedate + ONE_DAY * $num;
            }
            $date = $obj_result->ymd;

            $date =~ s/-/\//g;
            # $num =~ s/0//;
        }
        else {
            $date = '';
        }
        $result{$num} = "$date";
    }
    return \%result;
}

sub diff_datetime {
    my ($x, $y) = @_;

    for ($x, $y) {
        chomp $_;
        if ($_ =~ m!\A(?<year>\d{4})[-/](?<month>\d+)[-/](?<date>\d+)\s(?<time>\d+:\d+:?\d*)!) {
            $_ = "$+{year}/$+{month}/$+{date} $+{time}";
        }
        elsif ($_ =~ m!\A(?<year>\d{4})[-/](?<month>\d+)[-/](?<date>\d+)!) {
            $_ = "$+{year}/$+{month}/$+{date} 00:00:00";
        }
        else {
            return "Incorrect data.";
        }
    }
    calc ($x, $y);
}

sub calc {
    my ($x, $y) = @_;

    my $obj_x = localtime->strptime("$x", '%Y/%m/%d %T');
    my $obj_y = localtime->strptime("$y", '%Y/%m/%d %T');

    my $obj_diff;
    if ($obj_x - $obj_y < 0) {
        $obj_diff = $obj_y - $obj_x;
    }
    else {
        $obj_diff = $obj_x - $obj_y;
    }

    my $obj_date; my $obj_hour; my $obj_minute; my $obj_second;
    my $date; my $hour; my $minute; my $second;
    my $result;

    $obj_date = $obj_diff / ONE_DAY;
    $date = sprintf("%d", $obj_date);
    $obj_hour = ( $obj_diff - $date * ONE_DAY) / ONE_HOUR;
    $hour = sprintf("%d", $obj_hour);
    $obj_minute = ( $obj_diff - $date * ONE_DAY - $hour * ONE_HOUR ) / ONE_MINUTE;
    # say $obj_minute;
    $minute = sprintf("%d", $obj_minute);
    $obj_second = $obj_diff - $date * ONE_DAY - $hour * ONE_HOUR - $minute * ONE_MINUTE;
    $second = sprintf("%d", $obj_second);
    
    $hour = "0$hour" if $hour =~ /\A\d\z/;
    $minute = "0$minute" if $minute =~ /\A\d\z/;
    $second = "0$second" if $second =~ /\A\d\z/;
    
    my %result;
    $result{datetime} = "$date\t$hour:$minute:$second";

    $hour = $hour + ($date * 24);
    $result{time} = "$hour:$minute:$second";

    return \%result;
}


1;
