use RPerl;
package Test;
use strict;
use warnings;
our $VERSION = 0.001_001;

use PhysicsPerl::Astro::System;

our Test_arrayref $foo = 23;
my number $baq = 42.211_2;
print 'howdy, $baq = ' . $baq . "\n";
#print 'howdy, $baq = ' . number::number_to_string($baq) . "\n";  # NEED FIX
#print 'howdy, $baq = ' . ::number_to_string($baq) . "\n";  # NEED FIX
print 'have RPerl::TEST_CONSTANT() = ' . RPerl::TEST_CONSTANT() . "\n";

#print undef;    # break with warnings
#print @{$foo};                   # break with strict

#sub baz { return 'rhino' . "\n"; }
our Test_arrayref::method $baz = sub { return 'hippo' . "\n"; };    # break without Class.pm
1;
