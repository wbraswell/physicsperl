#!/usr/bin/perl

# Copyright © 2015, Jean-Phillipe Cassar and William N. Braswell, Jr.. All Rights Reserved.
# Based on original code from unknown author at http://www.sci.fi/~benefon/solarsys.txt
# This work is Free & Open Source; you can redistribute it and/or modify it under the same terms as Perl 5.20.0.
# For licensing details, please see http://dev.perl.org/licenses/

# [[[ PREPROCESSOR ]]]
# <<< TYPE_CHECKING: TRACE >>>
# <<< RUN_SUCCESS: 'FOO' >>>

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values &  print operator
## no critic qw(RequireInterpolationOfMetachars) # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers) # USER DEFAULT 3: allow constants

# [[[ CONSTANTS ]]]
use constant PI => my number $TYPED_PI
    = 3.141_592_653_589_793_238_462_643_383_279_502_884_197_169_399_375;
use constant LIGHT_VELOCITY => my integer $TYPED_LIGHT_VELOCITY = 299_792_458;
use constant SUN_ANGULAR_SIZE => my number $TYPED_SUN_ANGULAR_SIZE
    = 0.533_055_555_5;    # angular size of Sun
use constant SUN_DIAMETER => my integer $TYPED_SUN_DIAMETER = 1_392_700; # absolute size of Sun km
use constant GRAVITY_ACCELLERATION => my number $TYPED_GRAVITY_ACCELLERATION
    = 9.811;    # meters per second per second

# [[[ SUBROUTINES ]]]
our void $sun_earth_positions = sub {
    my number $degrees_to_radians = PI() / 180.0; # to convert degrees to radians
    my number $tangent_half_sun_angular_size
        = sin( 0.5 * SUN_ANGULAR_SIZE() * $degrees_to_radians ) /
        cos( 0.5 * SUN_ANGULAR_SIZE() * $degrees_to_radians );  # tan(omega/2)
    my number $sun_earth_distance
        = 0.5 * SUN_DIAMETER() / $tangent_half_sun_angular_size; # distance of Sun to Earth
    my number $sun_earth_distance_over_sun_diameter
        = 2.0 * $sun_earth_distance / SUN_DIAMETER();
    my number $sun_earth_light_travel_time
        = 1_000.0 * $sun_earth_distance / LIGHT_VELOCITY(); # total travel time of light from Sun to Earth, in seconds
    my number $sun_earth_light_travel_time_remainder
        = $sun_earth_light_travel_time - 480.0; # travel time after 8 minutes, in seconds
    my number $orbit_length_per_year = 2.0 * PI() * $sun_earth_distance; # in kilometers??
    my number $orbit_length_per_day = $orbit_length_per_year / 365.25; # in kilometers??
    my number $orbit_mean_tangential_velocity
        = $orbit_length_per_day / 24.0 / 3.6; # average orbital tangential speed, in kilometers per second???
    my number $angular_velocity = 360.0 / 365.25; # angular velocity, in degrees per day
    my number $radial_velocity = 2.0 * $orbit_mean_tangential_velocity *
        sin( 0.5 * $degrees_to_radians * $angular_velocity ); # in kilometers per second???
    my number $earth_to_sun_acceleration = $radial_velocity / 24.0 / 3_600.0;
    my number $sun_gravity
        = $earth_to_sun_acceleration
        * $sun_earth_distance_over_sun_diameter
        * $sun_earth_distance_over_sun_diameter;

    print '[[[ SIZE OF SUN & DISTANCE FROM EARTH TO SUN ]]]', "\n\n";
    print 'Diameter of the Sun:', "\t", SUN_DIAMETER(), ' km', "\n";
    printf
        "Angular diameter of Sun as seen from Earth, omega = %3.6f degrees\n",
        SUN_ANGULAR_SIZE();
    print 'Distance of Sun from earth L = Sun radius/tan(omega/2)=';
    printf "%10.0f km \n", $sun_earth_distance;
    print "\nLight velocity = " . LIGHT_VELOCITY() . " m/s\n";
    printf
        "Light migrates in %5.1f sec = 8 minutes %2.1f sec from Sun to Earth\n",
        $sun_earth_light_travel_time, $sun_earth_light_travel_time_remainder;

    print '[[[ ACCELLERATION OF EARTH TO SUN ]]]', "\n\n";
    print
        "We assume a circular orbit with constant speed of Earth to make it easier to calculate.\n";
    printf "Earth travels 2pi*L = %10.3E km around the Sun during a year\n",
        $orbit_length_per_year;
    printf "This is in average %10.3E km during a day\n",
        $orbit_length_per_day;
    printf "This corresponds to an average velocity %6.0f m/s\n",
        $orbit_mean_tangential_velocity;
    printf "Earth travels a = %1.4f degrees a day around the Sun \n",
        $angular_velocity;
    print "Earth is falling with a constant speed v2 towards Sun.\n";
    printf "v2 = 2v1*sin(a/2) = %4.1f m/s\n", $radial_velocity;
    print
        "The speed v2 is caused by the acceleration a1 of Earth toward Sun \n";
    printf "a1 = v2/24 hours = %2.3E m/s^2\n", $earth_to_sun_acceleration;

    print '[[[ GRAVITY ON SURFACE OF SUN ]]]', "\n\n";
    print
        "G is increasing in proportion to the square of the decreasing distance to Sun.\n";
    printf "Distance of Sun from Earth L = %4.2f x Sun radius \n",
        $sun_earth_distance_over_sun_diameter;
    printf "G = a1*(L / Sun radius)^2 = %2.3E*%4.2f^2 = %4.3f m/s^2\n",
        $earth_to_sun_acceleration, $sun_earth_distance_over_sun_diameter,
        $sun_gravity;
    printf "G = %3.2f x g on Earth (%3.3f m/s^2)\n",
        $sun_gravity / GRAVITY_ACCELLERATION(), GRAVITY_ACCELLERATION();
    return;
};

sun_earth_positions();
