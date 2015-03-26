#! /usr/bin/perl -s
# 2010 Marti Cuquet
# https://github.com/mcuquet

if ($h) {
    print<<"INFO";
$0 - Columnar transposition cipher

Usage: $0 [-d] [-i] KEY

Reads from stdin, outputs to sdtout. Columns will be reordered according to
KEY. Use -d to decipher.
INFO
    exit 0;
}

$k = shift or die "$0: no key given.\n";
$k =~ y/a-z/A-Z/; $k =~ y/A-Z//dc;
$w = length($k);

while (<>) {
    y/a-z/A-Z/;
    y/A-Z//dc;
    $i .= $_;
}
$i .= 'X' while length($i)%$w;

$w = $d ? length($i)/$w : $w;

$j = 0;
foreach (split //, $k) {
    die "$0: ambiguous key $k\n" if defined $b{$_};
    $b{$_} = $j++;
}

if ($d) { # Decrypt
    $p = 0;
    foreach (sort split //, $k) {
        $s{$_} = substr $i, $p, $w;
        $p += $w;
    }
    foreach $p (0 .. $w) {
        foreach (split //, $k) {
            $o .= substr $s{$_}, $p, 1;
        }
    }
} else { # Encrypt
    foreach (sort keys %b) {
        $a = $w-$b{$_}-1;
        $o .= join "", $i =~ /.{$b{$_}}(.).{$a}/g;
    }
}
$o =~ s/(.{5})/$1 /g;
print "$o\n";
