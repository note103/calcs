#!/usr/bin/env perl
use strict;
use warnings;
use Time::Piece;
use Time::Seconds;
use 5.012;

my $msg = "Input (dd|dn|q).";
my $any = "Anything else?\n$msg";
my $correct = "Please select correct one.";

print "\n$msg\n";
while (my $in = <>) {
    if ($in =~ /^(dd)$/) {
        d2d();
        print "\n$any\n";
    } elsif ($in =~ /^(dn)$/) {
        d2n();
        print "\n$any\n";
    } elsif ($in =~ /^(q)$/) {
        print "Bye!\n";
        last;
    } else {
        print "\n$correct\n"
    }
}

my ($stamp_local, $stamp_in);
sub d2d {
    print "\nWhat date?\n";
    my $date = <>;
    unless ($date =~ /^(\d{4}-\d\d?-\d\d?)$/) {
        print "\n$correct\n";
    } else {
        $stamp_in = $1;
        $stamp_local = localtime->strptime("$stamp_in", '%Y-%m-%d');
        print "\nWhat numbers?\n";
        my $num = <>;
        unless ($num =~ /^\d+$/) {
            print "\n$correct\n";
        } else {
            my $add = $stamp_local + ONE_DAY * $num;
            say $add->ymd." (add)";
            my $substract = $stamp_local - ONE_DAY * $num;
            say $substract->ymd." (substract)";
        }
    }
}

my ($stamp_local2, $stamp_in2);
sub d2n {
    print "\nWhat date first?\n";
    my $date = <>;
    unless ($date =~ /^(\d{4}-\d\d?-\d\d?)$/) {
        print "\n$correct\n";
    } else {
        $stamp_in = $1;
        $stamp_local = localtime->strptime("$stamp_in", '%Y-%m-%d');
        print "\nWhat date second?\n";
        my $date2 = <>;
        unless ($date2 =~ /^(\d{4}-\d\d?-\d\d?)$/) {
            print "\n$correct\n";
        } else {
            $stamp_in2 = $1;
            $stamp_local2 = localtime->strptime("$stamp_in2", '%Y-%m-%d');
            my $substract = ($stamp_local - $stamp_local2) / ONE_DAY;
            say $substract;
        }
    }
}
