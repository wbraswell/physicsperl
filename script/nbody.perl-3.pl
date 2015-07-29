#!/usr/bin/perl

# $ ./script/nbody.perl-3.pl 
# -0.169_075_163_828_524
# -0.169_059_906_816_626
# elapsed: 3255.33442401886
# $ rperl lib/PhysicsPerl/Astro/System.pm


# n-Body Program Source Code, Perl Implementation #3
# The Computer Language Benchmarks Game
# http://benchmarksgame.alioth.debian.org/

# contributed in Java by Mark C. Lewis
# modified slightly in Java by Chad Whipkey
# converted to Perl by Will Braswell

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '-0.169_075_164' >>>
# <<< EXECUTE_SUCCESS: '-0.169_059_907' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use PhysicsPerl::Astro::System;
use Time::HiRes qw(time);

# [[[ OPERATIONS ]]]

my $start = time;

#my integer $n = string_to_integer($ARGV[0]);
#my integer $n = 50;
#my integer $n = 50_000;
my integer $n = 50_000_000;

my object $system = PhysicsPerl::Astro::System->new();
$system->init();
print number_to_string($system->energy()) . "\n";

for my integer $i ( 1 .. $n ) { $system->advance(0.01); }
print number_to_string($system->energy()) . "\n";

my $elapsed = time - $start;
print 'elapsed: ' . $elapsed . "\n";