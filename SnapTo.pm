package Math::SnapTo;

#use strict;     # used in testing but not forced on you if you do not
#use warnings;   # want/require the overhead. call strict/warnings locally

require Exporter;
use Carp;
use vars qw( @ISA @EXPORT_OK $VERSION );

@ISA = qw(Exporter);
@EXPORT_OK = qw( snap_basic snap_sigfig snap_units );

$VERSION = '0.02';

sub snap_units {
    my ( $num, $units ) = @_;
    confess "Need units to snap to!" unless $units;
    my $neg = $num < 0 ? 1 : 0;
    $num = abs $num;
    $units = abs $units;
    # integer case
    if ( $units == int $units ) {
        if ( my $remainder = $num % $units ) {
            $num -= $remainder;
            $num += $units if $remainder >= $units/2;
        }
      return  $neg ? - $num : $num;
    }
    # fractional case
    else {
        my $factor = 1/$units;
        my $int = int ( $num * $factor );
        my $remainder = ( $num * $factor ) - $int;
        $int += 1 if $remainder >= 0.5;
        $num = $int / $factor;
      return $neg ? - $num : $num;
    }
}

sub snap_sigfig {
    my ( $num, $sig_figs ) = @_;
    $sig_figs ||= 6;
    my $neg = $num < 0 ? 1 : 0;
    $num = abs $num;
    my $exp;
    # integer case
    if ( $num =~ m/^[-+]?(\d{$sig_figs})(\d*)$/ ) {
        $num = $1 . ( $2 ? '0' x length $2 : '' );
        # round up if required
        if ( defined $2 and length $2 ) {
            my $compare_to = (10**(length $2))/2;
            my $round = $2 >= $compare_to ? 10**length $2 : 0;
            $num += $round;
        }
      return $neg ? - $num : $num;
    }
    # float case
    elsif ( $num =~ m/^(\d*)\.(\d+)$/ and length $num > $sig_figs +1 ) {
        # make it an integer case and recurse
        my $exp = 10 ** length $2;
        my $int = $num * $exp;
        $int = $neg ? - $int : $int;
      return snap_sigfig( $int, $sig_figs ) / $exp;
    }
    # default case
    else {
      return $neg ? - $num : $num;
    }
}

sub snap_basic {
    my ( $num, $accuracy ) = @_;
    $accuracy ||= 6;
    my $neg = $num < 0 ? 1 : 0;
    $num = abs $num;
    # 9s split across decimal point
    if ( $num =~ m/(\d*?)(9+)\.(9+)\d*/ and (defined $2 ? length $2 : 0)+( defined $3 ? length $3 : 0 ) >= $accuracy ) {
      return $neg ? - int($num +1 ) : int($num +1 );
    }
    # 9s after decimal point
    elsif ( $num =~ m/\d*\.(\d*?)(9{$accuracy,})\d*/ ) {
        my $pre = defined $1 ? length $1 : 0;
        my $exp = 10** ($pre + length $2);
      return $neg ? - int(($num * $exp) +1 )/$exp : int(($num * $exp) +1 )/$exp;
    }
    # 9s before decimal point
    elsif ( $num =~ m/\d*?(9{$accuracy,})(\d*)\.?d*/ ) {
        my $exp = defined $2 ? length $2 : 0;
      return $neg ? - ($num + 10**$exp) : $num + 10**$exp;
    }
    # 0s split across decimal point
    if ( $num =~ m/(\d*?)(0+)\.(0+)\d*/ and (defined $2 ? length $2 : 0)+( defined $3 ? length $3 : 0 ) >= $accuracy ) {
      return $neg ? "-$1$2" : $1.$2;
    }
    # 0s after decimal point
    elsif ( $num =~ m/(\d*)\.(\d*?)(0{$accuracy,})\d*/ ) {
        $num = ( $1 ? $1 : '0' ) . ( $2 ? ".$2" : '' );
      return $neg ? - $num : $num;
    }
    # 0s before decimal point
    elsif ( $num =~ m/(\d*?)(0{$accuracy,})(\d*)\.?d*/ ) {
        $num = ( $1 ? $1 : '' ) . ( $2 ? $2 : '' ) . ( $3 ? '0' x length $3 : '');
      return $neg ? - $num : $num;
    }
    else {
      return $neg ? - $num : $num;
    }
}

1;
__END__

=head1 NAME

Math::Snap - Perl extension providing numeric snap-to functions

=head1 SYNOPSIS

  use Math::SnapTo qw( snap_basic snap_sigfig snap_units );

=head1 DESCRIPTION

The Math::SnapTo module provides several methods to snap numeric values to
desired values according to various criteria. Positive or negative integers
and floats are supported.

=head2 FUNCTIONS

This module supplies three functions. None are exported by default so you
have to specify what you want in the use or use the fully quialified name.
For a detailed overview of how the functions behave run snap.test in the ./t
directory

    $ perl snap.test | more

=head3 snap_basic( [NUM], [ACCURACY] );

Something that has always anoyed me is how float operations
return 0.499999999998 or 0.500000000001 when the actual value is 0.5.

By default the approx sub will modify numbers so if we have a number
like 0.499999945 with 6 9s or 0.50000012 with 6 0s the number will be
rounded to 0.5.

The snap_basic() function also takes a second optional argument that specifies
how many 0s or 9s in a row will trigger rounding. For want of a better term
I call this the accuracy. The default is 6.

    snap_basic($num, 7);  # will return 0.5 for 0.500000001 but 0.50000001 if
                          # that is passed as it only has 6 zeros.

It should be noted that this is largely a cosmetic function rather than an
implementation of the IEEE 754 standard. Any sequence of (default 6) 0s or 9s
will trigger the modification so these modifications will occur:

    snap_basic(999999)   == 1000000;
    snap_basic(0.999999) == 1;
    snap_basic(999.999)  == 1000;

Numbers that do not fulfill the requisite criteria are returned unchanged.
For example 0.5000001 will not be rounded to 0.5 as it only has 5 0s.

=head3 snap_sigfig( [NUMBER], [SIGNIFICANT_FIGURES] )

The snap_sigfig() function returns its integer or float argument modified to
the desired number of significant figures. If the SIGNIFICANT_FIGURES argument
is not supplied a value of 6 is used. Appropriate rounding is performed.

    snap_sigfig(999999)     == 1000000;
    snap_sigfig(555555,4)   == 555600;
    snap_sigfig(0.555555,4) == 0.5556;

=head3 snap_units( [NUMBER], [UNITS] )

The snap_units() function returns its integer or float argument modified so
that NUMBER % UNITS == 0. UNITS can be an integer or a float.
Rounding up occurs if NUMBER % UNITS >= UNITS / 2

    snap_units(13,4)       == 12
    snap_units(14,4)       == 16 ;
    snap_units(15,4)       == 16 ;
    snap_units(16,4)       == 16 ;
    snap_units(17,4)       == 16 ;
    snap_units(18,4)       == 20 ;
    snap_units(0.75, 0.25) == 0.75;
    snap_units(0.87, 0.25) == 0.75;
    snap_units(0.88, 0.25) == 1;


=head2 EXPORT

None by default.

=head1 AUTHOR

Dr James Freeman, E<lt>james.freeman@id3.org.ukE<gt>

=cut
