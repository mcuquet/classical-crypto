#! /usr/bin/perl -s
# 2009 Marti Cuquet
# https://github.com/mcuquet/

if ($h) {
    print<<"INFO";
$0 - Caesar cipher

Usage: $0 [-d] [NUM]

Reads from stdin, outputs to stdout. NUM is the letter shift (default is 3).
Use -d to decipher.
INFO
    exit 0;
}

$f = $d ? -1 : 1;
$s = shift;
$s = 3 unless defined $s;

while (<>) {
    y/a-z/A-Z/;
    y/A-Z//dc;
    $o .= $_;
}

$o .= 'X' while length ($o)%5;
$o =~ s/./chr((ord($&)-ord('A')+$f*$s)%26+ord('A'))/eg;
$o =~ s/(.{5})/$1 /g;

print "$o\n";
