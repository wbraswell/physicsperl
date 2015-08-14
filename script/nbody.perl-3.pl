#!/usr/bin/perl

# $ ./script/nbody.perl-3.pl 
# start energy: -0.169_075_163_828_524
# end energy:   -0.169_059_906_816_626
# time elapsed: 3255.33442401886 seconds
# $ rperl lib/PhysicsPerl/Astro/System.pm
# $ ./script/nbody.perl-3.pl
# start energy: -0.169_075_163_828_524
# end energy:   -0.169_059_906_817_754
# time elapsed: 85.7338771820068 seconds


# n-Body Program Source Code, Perl Implementation #3
# The Computer Language Benchmarks Game
# http://benchmarksgame.alioth.debian.org/

# contributed in Java by Mark C. Lewis
# modified slightly in Java by Chad Whipkey
# converted to Perl by Will Braswell

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '-0.169_075_16' >>>
# <<< EXECUTE_SUCCESS: '-0.169_059_90' >>>

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

#my integer $time_steps = string_to_integer($ARGV[0]);
#my integer $time_steps = 1;
#my integer $time_steps = 50;
#my integer $time_steps = 50_000;
#my integer $time_steps = 500_000;
#my integer $time_steps = 5_000_000;
my integer $time_steps = 50_000_000;

my PhysicsPerl::Astro::System $system = PhysicsPerl::Astro::System->new();
$system->init();
print 'start energy: ' . number_to_string($system->energy()) . "\n";

#for my integer $i ( 1 .. $time_steps ) { $system->advance(0.01); }  # 97 seconds
$system->advance_loop(0.01, $time_steps);  # 85 seconds; SSE 13 seconds

print 'end energy:   ' . number_to_string($system->energy()) . "\n";

my $elapsed = time - $start;
print 'time elapsed: ' . $elapsed . ' seconds' . "\n";