# [[[ HEADER ]]]
package PhysicsPerl;
use strict;
use warnings;
use RPerl::AfterSubclass;

# DEV NOTE, CORRELATION #rp016: CPAN's underscore-is-beta (NOT RPerl's underscore-is-comma) numbering scheme utilized here, to preserve trailing zeros
our $VERSION = '0.200000';

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);  # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ EXPORTS ]]]

# DEV NOTE: outside of RPerl itself, the only subroutines which should be in @EXPORT are data conversion routines for RPerl data types and data structures, 
# and which have unique names, such as full-length-name stringify routines;
# the only subroutines which should be in @EXPORT_OK are those meant for public use and which have unique names;
# all other subroutines should be invoked with their entire package name prefix

use RPerl::Exporter 'import';
our @EXPORT = (
#                @PhysicsPerl::Energy::Light::Color::HSV::EXPORT,  # unused
#                @PhysicsPerl::Energy::Light::Color::RGB::EXPORT,  # unused
                );
our @EXPORT_OK = (
                @PhysicsPerl::Energy::Light::Color::HSV::EXPORT_OK,
                @PhysicsPerl::Energy::Light::Color::RGB::EXPORT_OK,
                );
                
# [[[ INCLUDES ]]]
use PhysicsPerl::Config;
#use PhysicsPerl::Astro;

# DEV NOTE: must explicitly import each subroutine in @EXPORT_OK

use PhysicsPerl::Energy::Light::Color::HSV qw(hsv_to_rgb);
use PhysicsPerl::Energy::Light::Color::RGB qw(rgb_to_hsv);

# [[[ OO PROPERTIES ]]]
our hashref $properties = {};

1;    # end of class
