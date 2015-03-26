#! /usr/bin/perl -s
# 2010 Marti Cuquet
# https://github.com/mcuquet/

if ($h) {
   print<<"INFO";
$0 - One-time pad

Usage: $0 file

Read from stdin, output to stdout. Use file as the one-time pad. Use -d to
decipher.
INFO
    exit 0;
}

$f = $d ? -1 : 1;

$if = shift;
open IF, "$if" or die "Can't open file '$if'.\n";
while (<IF>) {
    y/a-z/A-Z/;
    y/A-Z//dc;
    $p .= $_;
}
close P;

while (<>) {
    y/a-z/A-Z/;
    y/A-Z//dc;
    $o .= $_;
}
$o .= 'X' while length ($o)%5;
die "One-time pad '$if' is too short.\n" if (length ($o) > length ($p));
$o =~ s/./chr((ord($&)-ord('A')+$f*&e)%26+ord('A'))/eg;
$o =~ s/(.{5})/$1 /g;

print "$o\n";

sub e {
    $p =~ s/^(.)//;
    return ord($1) - ord('A') + 1;
}
