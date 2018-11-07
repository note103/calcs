#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';
use FindBin;
use lib "$FindBin::Bin/lib";
use Calcs;

# 日付差分
my $i    = '2017-05-16';
my $j    = '2017/05/19';
my $diff_date = diff_datetime($i, $j);
say $diff_date->{time};

# 日時差分
my $x    = '2017-05-16 11:32:45';
my $y    = '2017/05/19 3:00:54';
my $diff_datetime = diff_datetime($x, $y);
say $diff_datetime->{time};
