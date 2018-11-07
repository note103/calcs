#!/usr/bin/env perl
use strict;
use warnings;
use feature 'say';
use FindBin;
use lib "$FindBin::Bin/lib";
use Calcs;


my @data = <DATA>;

for (@data) {
    chomp $_;
    if ($_ =~ /\[(.+)\]\z/) {
        $_ = $1;
    }
    elsif ($_ =~ /\A(\d.+)\z/) {
        $_ = $1;
    }
    else {
        $_ = "";
    }
}
my $time = add_time(\@data);
say $time;


__DATA__
00:10:00
01:43:38
00:17:56
00:15:51
00:53:53
03:26:52
