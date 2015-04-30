#!/usr/bin/perl
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

=head1 NAME
Pythagorean Triples
=head1 SYNOPSIS
Baylor University, PHY2360, Exam 3, Problem 6, Generate Pythagorean Triples For (c <= 100)
=head1 LICENSE 
Copyright © 2015, William N. Braswell, Jr. -L<william.braswell@autoparallel.com>  All Rights Reserved.
This work is Free & Open Source; you can redistribute it and/or modify it under the same terms as Perl 5.20.0.
For licensing details, please see -L<http://dev.perl.org/licenses/>
=cut

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 7: PERL CRITIC UNFILED ISSUE, not postfix foreach or if

# [[[ USER-EDITABLE INPUT VARIABLES ]]]
my integer $a_min = 2;
my integer $c_max = 100;

# [[[ INCLUDES ]]]
use POSIX qw(floor);

# [[[ SUBROUTINES ]]]
sub stringify_pythagorean_triple {
    ( my integer_arrayref $pythagorean_triple) = @_;
    return
          '['
        . $pythagorean_triple->[0] . ', '
        . $pythagorean_triple->[1] . ', '
        . $pythagorean_triple->[2] . ']';
}

sub stringify_pythagorean_triples {
    ( my arrayref_arrayref $pythagorean_triples) = @_;
    my string $retval    = q{};
    my integer $is_first = 1;

#    foreach my integer_arrayref $pythagorean_triple ( @{$pythagorean_triples} )  # bug reported for Perl::Critic RequireFinalReturn
    foreach my $pythagorean_triple ( @{$pythagorean_triples} ) {
        if ($is_first) {
            $is_first = 0;
        }
        else {
            $retval .= q{,} . "\n";
        }
        $retval .= stringify_pythagorean_triple($pythagorean_triple);
    }
    return $retval;
}

# [[[ NON-USER-EDITABLE SYSTEM VARIABLES ]]]
my integer $a_squared;
my integer $a_max;
my number $a_ratio;
my integer $a_ratio_is_integer;
my integer $b_squared;
my integer $b_min;
my integer $b_min_squared;
my integer $b_max;
my number $b_ratio;
my integer $b_ratio_is_integer;
my number $c;
my integer $c_integer_part;
my integer $c_max_squared;
my arrayref_arrayref $pythagorean_triples           = [];
my arrayref_arrayref $pythagorean_triples_primitive = [];
my integer $is_primitive;

# [[[ OPERATIONS ]]]
$b_min = 2;  # hard-coded for now
$b_min_squared = $b_min**2;
$c_max_squared = $c_max**2;
$a_max         = floor( ( $c_max_squared - ($b_min_squared) )**0.5 );

#print '$b_min_squared = ' . $b_min_squared . "\n";
#print '$c_max_squared = ' . $c_max_squared . "\n";
#print '$a_max = ' . $a_max . "\n";

for my integer $a ( $a_min .. $a_max ) {

    #    print 'top of for() loop, $a = ' . $a . "\n";
    $a_squared = $a**2;
    $b_max = floor( ( $c_max_squared - $a_squared )**0.5 );

    #    print "\t" . '$a_squared = ' . $a_squared . "\n";
    #    print "\t" . '$b_max = ' . $b_max . "\n";

    #    for my integer $b ( $b_min .. $b_max ) {  # allow $b <= $a
    for my integer $b ( ( $a + 1 ) .. $b_max ) {    # disallow $b <= $a

        #        print "\t" . 'top of for() loop, $b = ' . $b . "\n";
        $b_squared      = $b**2;
        $c              = ( $a_squared + $b_squared )**0.5;
        $c_integer_part = floor $c;

        #        print "\t\t" . '$b_squared = ' . $b_squared . "\n";
        #        print "\t\t" . '$c = ' . $c . "\n";
        #        print "\t\t" . '$c_integer_part = ' . $c_integer_part . "\n";
        if ( $c == $c_integer_part ) {

            #            print "\t\t" . '<<< BINGO!!! >>>' . "\n";
            push @{$pythagorean_triples}, [ $a, $b, $c ];
        }
    }
}

print '$pythagorean_triples = ' . "\n"
    . stringify_pythagorean_triples($pythagorean_triples) . "\n";

$is_primitive = 1;
foreach my integer_arrayref $pythagorean_triple ( @{$pythagorean_triples} )
{
    foreach my integer_arrayref $pythagorean_triple_primitive (
        @{$pythagorean_triples_primitive} )
    {
        $a_ratio
            = $pythagorean_triple->[0] / $pythagorean_triple_primitive->[0];
        $a_ratio_is_integer = ( $a_ratio - ( floor $a_ratio) ) == 0;
        $b_ratio
            = $pythagorean_triple->[1] / $pythagorean_triple_primitive->[1];
        $b_ratio_is_integer = ( $b_ratio - ( floor $b_ratio) ) == 0;
        if (    $a_ratio_is_integer
            and $b_ratio_is_integer
            and ( $a_ratio == $b_ratio ) )
        {
#            print stringify_pythagorean_triple($pythagorean_triple) . ' is an integer multiple of primitive ' . stringify_pythagorean_triple($pythagorean_triple_primitive) . "\n";
            $is_primitive = 0;
            last;
        }
    }
    if ($is_primitive) {
        push @{$pythagorean_triples_primitive}, $pythagorean_triple;
    }
    $is_primitive = 1;
}

print '$pythagorean_triples_primitive = ' . "\n"
    . stringify_pythagorean_triples($pythagorean_triples_primitive) . "\n";
