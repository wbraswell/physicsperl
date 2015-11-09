#!/usr/bin/env perl

# $ ./script/nbody.perl-3.pl 
# start energy: -0.169_075_163_828_524
# end energy:   -0.169_059_906_816_626
# time total:   3255.33442401886 seconds
# $ rperl lib/PhysicsPerl/Astro/System.pm
# $ ./script/nbody.perl-3.pl
# start energy: -0.169_075_163_828_524
# end energy:   -0.169_059_906_817_754
# time total:   85.7338771820068 seconds


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
our $VERSION = 0.001_101;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use PhysicsPerl::Astro::System;
use PhysicsPerl::Astro::SystemRenderer2D;
use Time::HiRes qw(time);

# [[[ OPERATIONS ]]]

my bool $enable_graphics = 1;
my number $delta_time = 0.01;
#my integer $time_step_max = string_to_integer($ARGV[0]);
#my integer $time_step_max = 5_000;
my integer $time_step_max = 50_000_000;
my integer $time_steps_per_frame = 5000;

my $time_start = time();

my PhysicsPerl::Astro::System $system = PhysicsPerl::Astro::System->new();
$system->init();
print 'start energy: ' . number_to_string($system->energy()) . "\n";

if ($enable_graphics) {
    my PhysicsPerl::Astro::SystemRenderer2D $renderer = PhysicsPerl::Astro::SystemRenderer2D->new();
    $renderer->init($system, $delta_time, $time_step_max, $time_steps_per_frame, $time_start);
    $renderer->render2d_video();
}
else {
    $system->advance_loop($delta_time, $time_step_max);  # 85 seconds; SSE 13 seconds
}

print 'end energy:   ' . number_to_string($system->energy()) . "\n";
my $time_total = time() - $time_start;
print 'time total:   ' . $time_total . ' seconds' . "\n";
