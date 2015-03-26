#! /usr/bin/perl -s
# 2010 Marti Cuquet
# https://github.com/mcuquet/

if ($h) {
    print<<"INFO";
$0 - Transposition cipher

Usage: $0 [-d] [NUM]

Reads from stdin, outputs to sdtout. NUM is the number of columns in which the
plain text is arranged (default is 5). Use -d to decipher.
INFO
    exit 0;
}

$w = shift;
$w = 5 unless defined $w;

while (<>) {
    y/a-z/A-Z/;
    y/A-Z//dc;
    $i .= $_;
}
$i .= 'X' while length ($i)%$w;

$w = $d ? length($i)/$w : $w;

$b = 0; $a = $w-1;
while ($b<=$w) {
    $o .= join "", $i =~ /.{$b}(.).{$a}/g;
    $b++;$a--;
}
$o =~ s/(.{5})/$1 /g;
print "$o\n";
