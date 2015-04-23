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
our $VERSION = 0.003_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values &  print operator
## no critic qw(RequireInterpolationOfMetachars) # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers) # USER DEFAULT 3: allow constants

# [[[ CONSTANTS ]]]
#----------------------------------------------------------------------------------------#
# Use Bignum library to get exported constant PI with 100 places                         #
#----------------------------------------------------------------------------------------#
use constant PI => my number $TYPED_PI
    = 3.141_592_653_589_793_238_462_643_383_279_502_884_197_169_399_375_105_820_974_944_592_307_816_406_286_208_998_628_034_825_342_117_068;

#----------------------------------------------------------------------------------------#
# The speed of light in vacuum, commonly denoted c, is a universal physical constant     # 
# important in many areas of physics. Its value is exactly 299792458 metres per second   #
#----------------------------------------------------------------------------------------#
use constant LIGHT_VELOCITY => my integer $TYPED_LIGHT_VELOCITY
    = 299_792_458;    # in meters per second

#----------------------------------------------------------------------------------------#
# The Sun diameter in kilometers.                                                        #
#----------------------------------------------------------------------------------------#
use constant SUN_DIAMETER => my integer $TYPED_SUN_DIAMETER = 1_391_684; # in kilometers

#----------------------------------------------------------------------------------------#
# The number 206,265 is actually the number of seconds of arc in an angle of 57.3°,      #
# which is a special angle called a radian. A radian is defined as an angle subtending   #
# one radius of a circle, laid along the circumference of the circle. Since the          #
# circumference of a circle is 2πr, a radian is 360° / 2 π =57.3° or about a sixth of a  #
# full circle. It is an important angle with many applications in geometry.              #
#----------------------------------------------------------------------------------------#
use constant SEC_IN_ARC => my integer $TYPED_SEC_IN_ARC = 206_265;

#----------------------------------------------------------------------------------------#
# One Atronomical Unit = 149 597 870 700 meters                                          #
#----------------------------------------------------------------------------------------#
use constant AU => my integer $TYPED_AU
   = 149_597_870.7; # in kilometers

#----------------------------------------------------------------------------------------#
# The standard acceleration due to gravity (standard acceleration of free fall),         #
# sometimes abbreviated as standard gravity, usually denoted by ɡ0 or ɡn, is the nominal #
# gravitational acceleration of an object in a vacuum near the surface of the Earth. It  #
# is defined by standard as 9.80665 m/s2, which is exactly 35.30394 (km/h)/s (about      #
# 32.174 ft/s2, or 21.937 mph/s). This value was established by the 3rd CGPM (1901, CR   #
# 70) and used to define the standard weight of an object as the product of its mass and #
# this nominal acceleration. The acceleration of a body near the surface of the Earth is #
# due to the combined effects of gravity and centrifugal acceleration from rotation of   #
# the Earth (but which is small enough to be neglected for most purposes); the total     #
# (the apparent gravity) is about 0.5 percent greater at the poles than at the equator.  #
#----------------------------------------------------------------------------------------#
use constant EARTH_GRAVITY_ACCELLERATION => my number $TYPED_EARTH_GRAVITY_ACCELLERATION
   = 9.806_65;    # in meters per second per second

# [[[ SUBROUTINES ]]]
our void $sun_earth_positions = sub {
    #----------------------------------------------------------------------------------------#
    # Using the small-angle equation:                                                        #
    # a / SEC_IN_ARC = d / D with d the diameter of the sun and D its distance               #
    # calculate the Sun Angle Size                                                           #
    #----------------------------------------------------------------------------------------#
    my number $sun_angular_size_radian
        = (SUN_DIAMETER()/AU()) * SEC_IN_ARC(); # in radian
    #----------------------------------------------------------------------------------------#
    # Since there are 3600" in one degree, this angle is SIN_ANGULAR_SIZE_RADIAN / 3600      #
    #----------------------------------------------------------------------------------------#
    my number $sun_angular_size
        = $sun_angular_size_radian / 3_600;   # in degrees
    #----------------------------------------------------------------------------------------#
    # Degrees to Radians conversion                                                          #
    #----------------------------------------------------------------------------------------#
    my number $degrees_to_radians
        = PI() / 180.0;
    #----------------------------------------------------------------------------------------#
    # Angular velocity is the angle by which an object turns in a certain time.              #
    # A circle has 360 degrees, a year is 365 days and a quater.                             #
    #----------------------------------------------------------------------------------------#
    my number $angular_velocity
        = 360.0 / 365.25; # in degrees per day


    my number $tangent_half_sun_angular_size
        = sin( 0.5 * $sun_angular_size * $degrees_to_radians ) /
        cos( 0.5 * $sun_angular_size * $degrees_to_radians );
    my number $sun_earth_distance
        = AU();
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
    printf "Angular diameter of the Sun as seen from Earth:  omega = %3.6f degrees\n", $sun_angular_size;
    print 'Distance from Earth to the Sun: ', AU(), ' kilometers', "\n";
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
    printf "Gravity from Earth:  %3.3f meters per second per second\n", EARTH_GRAVITY_ACCELLERATION();
    printf "Gravity from the Sun:  a1 * (L / Sun radius)^2 = %2.3E * %4.2f^2 = %4.3f meters per second per second\n",
        $earth_to_sun_acceleration, AU(),
        $sun_gravity;
    printf "Gravity from the Sun:  %3.2f * gravity from Earth\n",
        $sun_gravity / EARTH_GRAVITY_ACCELLERATION();
    return;
};

sun_earth_positions();
