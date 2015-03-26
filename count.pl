#! /usr/bin/perl -s

if ($h) {
    print<<"INFO";
$0 - Count letter occurrences

Usage: $0 [SEP]

Reads from stdin, outputs to stdout.
If provided, use SEP as a separator in the output. Default is ':'.
INFO
    exit 0;
}

$s = shift or $s = ':';

%o = ();

while (<>) {
    $i .= $_;
}

$i =~ s/./&c($&)/eg;

foreach $k (sort { $o{$b} <=> $o{$a} } keys %o) {
    print $k . $s . $o{$k} . "\n";
}

sub c {
    $l = shift;
    $o{"$l"} = exists $o{"$l"} ? $o{"$l"} + 1 : 1;
}
