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
our $VERSION = 0.002_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values &  print operator
## no critic qw(RequireInterpolationOfMetachars) # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers) # USER DEFAULT 3: allow constants

# [[[ CONSTANTS ]]]
use constant PI => my number $TYPED_PI
    = 3.141_592_653_589_793_238_462_643_383_279_502_884_197_169_399_375; # no unit
use constant LIGHT_VELOCITY => my integer $TYPED_LIGHT_VELOCITY
    = 299_792_458;    # in meters per second
use constant SUN_ANGULAR_SIZE => my number $TYPED_SUN_ANGULAR_SIZE
    = 0.533_055_555_5;    # in degrees
use constant SUN_DIAMETER => my integer $TYPED_SUN_DIAMETER = 1_392_700; # in kilometers
use constant EARTH_GRAVITY_ACCELLERATION => my number $TYPED_EARTH_GRAVITY_ACCELLERATION
    = 9.811;    # in meters per second per second

# [[[ SUBROUTINES ]]]
our void $sun_earth_positions = sub {
    my number $degrees_to_radians = PI() / 180.0;
    my number $tangent_half_sun_angular_size
        = sin( 0.5 * SUN_ANGULAR_SIZE() * $degrees_to_radians ) /
        cos( 0.5 * SUN_ANGULAR_SIZE() * $degrees_to_radians );
    my number $sun_earth_distance
        = 0.5 * SUN_DIAMETER() / $tangent_half_sun_angular_size; # in kilometers
    my number $sun_earth_distance_over_sun_diameter
        = 2.0 * $sun_earth_distance / SUN_DIAMETER();
    my number $sun_earth_light_travel_time
        = 1_000.0 * $sun_earth_distance / LIGHT_VELOCITY(); # total travel time of light from Sun to Earth, in seconds
    my number $sun_earth_light_travel_time_remainder
        = $sun_earth_light_travel_time - 480.0; # travel time after 8 minutes, in seconds
    my number $orbit_length_per_year = 2.0 * PI() * $sun_earth_distance; # in kilometers per year
    my number $orbit_length_per_day_average  = $orbit_length_per_year / 365.25;  # in kilometers per day
    my number $orbit_tangential_velocity_average
        = $orbit_length_per_day_average / 24.0 / 3.6;    # in meters per second
    my number $angular_velocity = 360.0 / 365.25; # in degrees per day
    my number $radial_velocity = 2.0 * $orbit_tangential_velocity_average *
        sin( 0.5 * $degrees_to_radians * $angular_velocity ); # in meters per second
    my number $earth_to_sun_acceleration
        = $radial_velocity / 24.0 / 3_600.0;                  # in meters per second per second
    my number $sun_gravity
        = $earth_to_sun_acceleration
        * $sun_earth_distance_over_sun_diameter
        * $sun_earth_distance_over_sun_diameter;

    print "\n", '[[[ SIZE OF SUN & DISTANCE FROM EARTH TO SUN ]]]', "\n\n";
    print 'Diameter of the Sun:  ', SUN_DIAMETER(), ' kilometers', "\n";
    printf "Angular diameter of the Sun as seen from Earth:  omega = %3.6f degrees\n", SUN_ANGULAR_SIZE();
    printf "Distance from Earth to the Sun:  L = Sun radius / tan(omega / 2) = %10.0f kilometers \n", $sun_earth_distance;
    print 'Velocity of light in a vacuum:  c = ', LIGHT_VELOCITY(), " meters per second\n";
    printf
        "Travel time of light from the Sun to Earth:  %5.1f seconds = 8 minutes %2.1f seconds\n",
        $sun_earth_light_travel_time, $sun_earth_light_travel_time_remainder;

    print "\n", '[[[ ACCELLERATION OF EARTH TO SUN ]]]', "\n\n";
    print
        "We assume a circular orbit of Earth around the Sun, with constant speed, to make it easier to calculate...\n";
    printf "Orbit length per year:  2 * pi * L = %10.3E kilometers\n", $orbit_length_per_year;
    printf "Orbit length per day, average:  %10.3E kilometers\n", $orbit_length_per_day_average;
    printf "Orbit tangential velocity, average:  %6.0f m/s\n", $orbit_tangential_velocity_average;
    printf "Orbit angular velocity:  a = %1.4f degrees per day\n", $angular_velocity;
    printf "Radial velocity of Earth falling toward Sun:  v2 = 2 * v1 * sin(a / 2) = %4.1f meters per second\n", $radial_velocity;
    printf "Acceleration of Earth toward Sun:  a1 = v2 / 24 hours = %2.3E meters per second per second\n", $earth_to_sun_acceleration;

    print "\n", '[[[ GRAVITY FROM SUN ]]]', "\n\n";
    print "Gravity from the Sun is proportional to the square of the distance to the Sun...\n";
    printf "Distance from Earth to the Sun:  L = %4.2f * radius of the Sun \n", $sun_earth_distance_over_sun_diameter;
    printf "Gravity from Earth:  %3.3f meters per second per second\n", EARTH_GRAVITY_ACCELLERATION();
    printf "Gravity from the Sun:  a1 * (L / Sun radius)^2 = %2.3E * %4.2f^2 = %4.3f meters per second per second\n",
        $earth_to_sun_acceleration, $sun_earth_distance_over_sun_diameter,
        $sun_gravity;
    printf "Gravity from the Sun:  %3.2f * gravity from Earth\n",
        $sun_gravity / EARTH_GRAVITY_ACCELLERATION();
    return;
};

sun_earth_positions();
