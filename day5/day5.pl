use strict;
use warnings;

##my $x = 10;
##$x += 1200;

##my $two = 0 && 0;

##my $s;
##chomp($s = <STDIN>);

# push(), pop(), unshift(), sort(), 
##my @list = (1..100);
##my $length = scalar @list;

##my %hash = (x => 1, y => 2, z => 3);
##my $val = $hash{z};

#elsif

# foreach(@list) --> $_ default var
##for my $i (@list) {
##    $i += 100;
##    print("$i\n");
##}

# inside a list mutates
#print "@list"

#print "$x : $s : $two : $val\n";


# next == continue
# break == last

# regex



## ------------------------------- ##
## day5

##my $string = 'regex in perl is supposed to be pretty good?';
## $string ~= /ul/;
## $string !~ /er/;
##print("$1 \n") if ($string =~ /p([oret]*)/);
##for my $lin (split /\n/, $string) {
##    if ($lin =~ /r([a-z]*)([dxy])/) {
##        print $1 . "|" . $2 . "\n"
##    }
##}
use List::Util qw( min max );
sub part1 {
    my %hash = ();
    my $aref = $_[0];
    for (@$aref) {
        my ($x1, $y1, $x2, $y2) = (0, 0, 0, 0);

        if($_ =~ /([0-9]*),([0-9]*) \-> ([0-9]*),([0-9]*)/) {
            $x1 = $1 + 0;
            $y1 = $2 + 0;
            $x2 = $3 + 0;
            $y2 = $4 + 0;
        }
 
        if ($x1 == $x2) {
            for (my $i = min ($y1, $y2); $i <= max ($y1, $y2); $i++) {
                if (exists $hash{"$x1,$i"}) {
                    $hash{"$x1,$i"} += 1;
                } else {
                    $hash{"$x1,$i"} = 1;
                }
            }     
        } elsif ($y1 == $y2) {
            for (my $i2 = min ($x1, $x2); $i2 <= max ($x1, $x2); $i2++) {
                if (exists $hash{"$i2,$y1"}) {
                    $hash{"$i2,$y1"} += 1;
                } else {
                    $hash{"$i2,$y1"} = 1;
                }
            } 
        } else {
            next; # don't do diagonal
        } 
    }
   
    my $sum = 0;
    foreach my $key (keys %hash) {
        $sum += 1 if ($hash{$key} > 1); 
    }
     
    my $out = $sum;
    print "part1: $out\n";
}

sub part2 {
    my %hash = ();
    my $aref = $_[0];
    for (@$aref) {
        my ($x1, $y1, $x2, $y2) = (0, 0, 0, 0);

        if($_ =~ /([0-9]*),([0-9]*) \-> ([0-9]*),([0-9]*)/) {
            $x1 = $1 + 0;
            $y1 = $2 + 0;
            $x2 = $3 + 0;
            $y2 = $4 + 0;
        }
       
        if ($x1 == $x2) {
            for (my $i = min ($y1, $y2); $i <= max ($y1, $y2); $i++) {
                if (exists $hash{"$x1,$i"}) {
                    $hash{"$x1,$i"} += 1;
                } else {
                    $hash{"$x1,$i"} = 1;
                }
            }     
        } elsif ($y1 == $y2) {
            for (my $i2 = min ($x1, $x2); $i2 <= max ($x1, $x2); $i2++) {
                if (exists $hash{"$i2,$y1"}) {
                    $hash{"$i2,$y1"} += 1;
                } else {
                    $hash{"$i2,$y1"} = 1;
                }
            } 
        } else {
            for (my $i = 0; $i <= max ($x1, $x2) - min($x1, $x2); $i++) {
                my $x = $x1 + ($x2 > $x1) ? $i : -$i;
                my $y = $y1 + ($y2 > $y1) ? $i : -$i;

                if (exists $hash{"$x,$y"}) {
                    $hash{"$x,$y"} += 1;
                } else {
                    $hash{"$x,$y"} = 1;
                }
            } 
        } 
    }
   
    my $sum = 0;
    foreach my $key (keys %hash) {
        if ($hash{$key} > 1) {
            $sum += 1;
        } 
    }
     
    my $out = $sum;
    print "part2: $out\n";
}

open my $fh, '<', 'input' or die "can't open file: $!\n";
read $fh, my $file_str, -s $fh;

my @lines = split /\n/, $file_str; #print "lines: @lines\n";
part1(\@lines);
part2(\@lines);
