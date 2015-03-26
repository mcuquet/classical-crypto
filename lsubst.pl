#! /usr/bin/perl -s
# 2010 Marti Cuquet
# https://github/mcuquet/

if ($h) {
    print<<"INFO";
$0 - Substitution cipher

Usage: $0 key [-d]

Reads from stdin, outputs to stdout. If a key is not given, it generates a
random one. Use -d to decipher.
INFO
    exit 0;
}

$k = shift;
if (defined $k) {
    $k =~ y/a-z/A-Z/;
    $k =~ y/A-Z//dc;
    die "$0: bad length in key\n" if length($k) != 26;
    foreach ('A' .. 'Z') {
        die "$0: key does not contain $_\n" unless $k =~ /$_/;
    }
} else {
    die "$0: no key given\n" if $d;
    @s = 'A' .. 'Z';
    $i = @s;
    while ($i--) {
        $j = int rand ($i+1);
        @s[$i,$j] = @s[$j,$i];
    }
    $k = join ("", @s);
}

while (<>) {
    y/a-z/A-Z/;
    y/A-Z//dc;
    $o .= $_;
}

$o .= 'X' while length ($o)%5;
$_ = $o;
eval "y/A-Z/$k/" unless $d;
eval "y/$k/A-Z/" if $d;
s/(.{5})/$1 /g;

print "$_\n";
