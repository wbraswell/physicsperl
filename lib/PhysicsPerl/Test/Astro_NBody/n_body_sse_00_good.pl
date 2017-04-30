#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: '-0.169_075_16' >>>
# <<< EXECUTE_SUCCESS: '-0.169_020_00' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.003_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

# [[[ INCLUDES ]]]
use PhysicsPerl::Astro::SystemSSEGasGiants;

# [[[ OPERATIONS ]]]

my integer $time_step_max = 5_000;
my number $delta_time = 0.01;

my PhysicsPerl::Astro::SystemSSEGasGiants $system = PhysicsPerl::Astro::SystemSSEGasGiants->new();
$system->init();
print 'start energy: ' . number_to_string($system->energy()) . "\n";
$system->advance_loop($delta_time, $time_step_max);
print 'end energy:   ' . number_to_string($system->energy()) . "\n";

