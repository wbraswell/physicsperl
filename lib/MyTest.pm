# [[[ HEADER ]]]
use RPerl;
package MyTest;
use strict;
use warnings;
our $VERSION = 0.003_00;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::Class);
use RPerl::Class;

# [[[ INCLUDES ]]]
use PhysicsPerl::Astro::System;

# [[[ SPECIAL OPERATIONS ]]]

our MyTest_arrayref $foo = 23;
my number $baq = 42.211_2;
print 'howdy, $baq = ' . $baq . "\n";
#print 'howdy, $baq = ' . ::number_to_string($baq) . "\n";  # NEED FIX!
print 'have RPerl::TEST_CONSTANT() = ' . RPerl::TEST_CONSTANT() . "\n";

#print undef;    # break with warnings
#print @{$foo};                   # break with strict

# [[[ OO METHODS & SUBROUTINES ]]]

#sub baz { return 'rhino' . "\n"; }
our MyTest_arrayref::method $baz = sub { return 'hippo & ' . bap() . "\n"; };    # break without Class.pm
our PhysicsPerl::Astro::Body_hashref::method $bap = sub { return 'boppo'; };    # break without Class.pm

1;  # end of class
