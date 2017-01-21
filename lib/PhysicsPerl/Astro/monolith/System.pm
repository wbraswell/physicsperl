## no critic qw(Capitalization ProhibitMultiplePackages ProhibitReusedNames RequireFilenameMatchesPackage)  # SYSTEM DEFAULT 3: allow multiple & lower case package names

# $ sudo cpan RPerl
# $ rperl -noW System.pm
# $ perl -I. -e 'use System; my $s = PhysicsPerl::Astro::System->new(); $s->init(); print $s->energy() . qq{\n}; $s->advance_loop(0.01, $ARGV[0] + 0); print $s->energy() . qq{\n};' 50000000
# -0.169075163828524
# -0.169059906811125

# n-Body Program Source Code, Perl Implementation #3
# The Computer Language Benchmarks Game
# http://benchmarksgame.alioth.debian.org/

# contributed in Java by Mark C. Lewis
# modified slightly in Java by Chad Whipkey
# converted to Perl by Will Braswell

# [[[ HEADER ]]]
use RPerl;
package PhysicsPerl::Astro::Body;
use strict;
use warnings;
our $VERSION = 0.006_100;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);    # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ CONSTANTS ]]]
#use constant PI           => my number $TYPED_PI           = 3.141_592_653_589_793;  # CURRENTLY UNUSED
use constant SOLAR_MASS   => my number $TYPED_SOLAR_MASS   = 39.478_417_604_357_4;    # 4 * PI() * PI()
#use constant SOLAR_RADIUS => my number $TYPED_SOLAR_RADIUS = 696_300;                 # kilometers, via Google  # CURRENTLY UNUSED
use constant DAYS_PER_YEAR => my number $TYPED_DAYS_PER_YEAR = 365.24;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {

    # NEED FIX: x as WORD vs OP string repeat
    name  => my string $TYPED_name = undef,
    x=> my number $TYPED_x= undef,
    y      => my number $TYPED_y = undef,
    z      => my number $TYPED_z = undef,
    vx     => my number $TYPED_vx = undef,
    vy     => my number $TYPED_vy = undef,
    vz     => my number $TYPED_vz = undef,
    mass   => my number $TYPED_mass = undef,
    radius => my number $TYPED_radius = undef,
    color  => my integer_arrayref $TYPED_color = undef
};

# [[[ SUBROUTINES & OO METHODS ]]]

our PhysicsPerl::Astro::Body $sun = sub {
    my PhysicsPerl::Astro::Body $body = PhysicsPerl::Astro::Body->new();
    $body->{name} = 'The Sun (Sol)';
    $body->{x}      = 0;
    $body->{y}      = 0;
    $body->{z}      = 0;
    $body->{vx}     = 0;
    $body->{vy}     = 0;
    $body->{vz}     = 0;
    $body->{mass}   = PhysicsPerl::Astro::Body::SOLAR_MASS();
    $body->{radius} = 1;  # in units of solar radii
    $body->{color}  = [255, 245, 240];  # in RGB, estimate
    return $body;
};

our PhysicsPerl::Astro::Body $jupiter = sub {
    my PhysicsPerl::Astro::Body $body = PhysicsPerl::Astro::Body->new();
    $body->{name} = 'Jupiter';
    $body->{x}      = +4.841_431_442_464_720_90e+00;
    $body->{y}      = -1.160_320_044_027_428_39e+00;
    $body->{z}      = -1.036_220_444_711_231_09e-01;
    $body->{vx}     = +1.660_076_642_744_036_94e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vy}     = +7.699_011_184_197_404_25e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vz}     = -6.904_600_169_720_630_23e-05 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{mass}   = +9.547_919_384_243_266_09e-04 * PhysicsPerl::Astro::Body::SOLAR_MASS();
    $body->{radius} = +1.004_035_616_831_83e-01;                                           # in units of solar radii; 69_911 kilometers, via Google
    $body->{color}  = [175, 75, 25];  # in RGB, estimate
    return $body;
};

our PhysicsPerl::Astro::Body $saturn = sub {
    my PhysicsPerl::Astro::Body $body = PhysicsPerl::Astro::Body->new();
    $body->{name} = 'Saturn';
    $body->{x}      = +8.343_366_718_244_579_87e+00;
    $body->{y}      = +4.124_798_564_124_304_79e+00;
    $body->{z}      = -4.035_234_171_143_213_81e-01;
    $body->{vx}     = -2.767_425_107_268_624_11e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vy}     = +4.998_528_012_349_172_38e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vz}     = +2.304_172_975_737_639_29e-05 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{mass}   = +2.858_859_806_661_308_12e-04 * PhysicsPerl::Astro::Body::SOLAR_MASS();
    $body->{radius} = +8.363_061_898_606_92e-02;                                           # in units of solar radii; 58_232 kilometers, via Google
    $body->{color}  = [250, 215, 160];  # in RGB, estimate
    return $body;
};

our PhysicsPerl::Astro::Body $uranus = sub {
    my PhysicsPerl::Astro::Body $body = PhysicsPerl::Astro::Body->new();
    $body->{name} = 'Uranus';
    $body->{x}      = +1.289_436_956_213_913_10e+01;
    $body->{y}      = -1.511_115_140_169_863_12e+01;
    $body->{z}      = -2.233_075_788_926_557_34e-01;
    $body->{vx}     = +2.964_601_375_647_616_18e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vy}     = +2.378_471_739_594_809_50e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vz}     = -2.965_895_685_402_375_56e-05 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{mass}   = +4.366_244_043_351_562_98e-05 * PhysicsPerl::Astro::Body::SOLAR_MASS();
    $body->{radius} = +3.642_251_902_915_41e-02;                                           # in units of solar radii; 25_361 kilometers, via Google
    $body->{color}  = [0, 240, 255];  # in RGB, estimate
    return $body;
};

our PhysicsPerl::Astro::Body $neptune = sub {
    my PhysicsPerl::Astro::Body $body = PhysicsPerl::Astro::Body->new();
    $body->{name} = 'Neptune';
    $body->{x}      = +1.537_969_711_485_091_65e+01;
    $body->{y}      = -2.591_931_460_998_796_41e+01;
    $body->{z}      = +1.792_587_729_503_711_81e-01;
    $body->{vx}     = +2.680_677_724_903_893_22e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vy}     = +1.628_241_700_382_422_95e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vz}     = -9.515_922_545_197_158_70e-05 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{mass}   = +5.151_389_020_466_114_51e-05 * PhysicsPerl::Astro::Body::SOLAR_MASS();
    $body->{radius} = +3.535_975_872_468_76e-02;                                           # in units of solar radii; 24_621 kilometers, via Google
    $body->{color}  = [55, 85, 230];  # in RGB, estimate
    return $body;
};

1;                                                                    # end of class


# [[[ HEADER ]]]
use RPerl;
package PhysicsPerl::Astro::System;
use strict;
use warnings;
our $VERSION = 0.006_100;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);    # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitCStyleForLoops)  # USER DEFAULT 6: allow C-style for() loop headers
## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if

# [[[ INCLUDES ]]]
use rperlsse;

# [[[ OO PROPERTIES ]]]
our hashref $properties = { bodies => my PhysicsPerl::Astro::Body_arrayref $TYPED_bodies->[5 - 1] = undef };

# [[[ SUBROUTINES & OO METHODS ]]]

our void::method $init = sub {
    ( my PhysicsPerl::Astro::System $self ) = @ARG;
    $self->{bodies}->[0] = PhysicsPerl::Astro::Body::sun();
    $self->{bodies}->[1] = PhysicsPerl::Astro::Body::jupiter();
    $self->{bodies}->[2] = PhysicsPerl::Astro::Body::saturn();
    $self->{bodies}->[3] = PhysicsPerl::Astro::Body::uranus();
    $self->{bodies}->[4] = PhysicsPerl::Astro::Body::neptune();
    my number $px = 0.0;
    my number $py = 0.0;
    my number $pz = 0.0;

    for my integer $i ( 0 .. ( ( scalar @{ $self->{bodies} } ) - 1 ) ) {
        $px += $self->{bodies}->[$i]->{vx} * $self->{bodies}->[$i]->{mass};
        $py += $self->{bodies}->[$i]->{vy} * $self->{bodies}->[$i]->{mass};
        $pz += $self->{bodies}->[$i]->{vz} * $self->{bodies}->[$i]->{mass};
    }

    $self->{bodies}->[0]->{vx} = -1 * ( $px / PhysicsPerl::Astro::Body::SOLAR_MASS() );
    $self->{bodies}->[0]->{vy} = -1 * ( $py / PhysicsPerl::Astro::Body::SOLAR_MASS() );
    $self->{bodies}->[0]->{vz} = -1 * ( $pz / PhysicsPerl::Astro::Body::SOLAR_MASS() );
};

our number::method $energy = sub {
    ( my PhysicsPerl::Astro::System $self ) = @ARG;
    my number $dx;
    my number $dy;
    my number $dz;
    my number $distance;
    my number $e = 0.0;

    for my integer $i ( 0 .. ( ( scalar @{ $self->{bodies} } ) - 1 ) ) {
        my PhysicsPerl::Astro::Body_raw $body_i = $self->{bodies}->[$i]->get_raw();
        $e += 0.5 * $body_i->{mass} * ( ( $body_i->{vx} * $body_i->{vx} ) + ( $body_i->{vy} * $body_i->{vy} ) + ( $body_i->{vz} * $body_i->{vz} ) );

        for my integer $j ( ( $i + 1 ) .. ( ( scalar @{ $self->{bodies} } ) - 1 ) ) {
            my PhysicsPerl::Astro::Body_raw $body_j = $self->{bodies}->[$j]->get_raw();
            $dx       = $body_i->{x} - $body_j->{x};
            $dy       = $body_i->{y} - $body_j->{y};
            $dz       = $body_i->{z} - $body_j->{z};
            $distance = ( ( $dx * $dx ) + ( $dy * $dy ) + ( $dz * $dz ) )**0.5;
            $e -= ( $body_i->{mass} * $body_j->{mass} ) / $distance;
        }
    }
    return $e;
};


our void::method $advance_loop = sub {
    ( my PhysicsPerl::Astro::System $self, my constant_number $delta_time, my constant_integer $time_step_max ) = @ARG;
    my constant_integer $bodies_size = scalar @{ $self->{bodies} };
    my constant_unsigned_integer $bodies_size_triangle  = 10;

    my number_arrayref $dx_array->[ $bodies_size_triangle - 1 ]        = undef;
    my number_arrayref $dy_array->[ $bodies_size_triangle - 1 ]        = undef;
    my number_arrayref $dz_array->[ $bodies_size_triangle - 1 ]        = undef;
    my number_arrayref $magnitude_array->[ $bodies_size_triangle - 1 ] = undef;

    my constant_sse_number_pair $delta_time_sse  = constant_sse_number_pair::new_from_singleton_duplicate($delta_time);
    my sse_number_pair $dx                       = sse_number_pair->new();
    my sse_number_pair $dy                       = sse_number_pair->new();
    my sse_number_pair $dz                       = sse_number_pair->new();
    my sse_number_pair $distance_squared         = sse_number_pair->new();
    my sse_number_pair $distance                 = sse_number_pair->new();
    my sse_number_pair $magnitude                = sse_number_pair->new();
    my constant_sse_number_pair $zero_point_five = constant_sse_number_pair::new_from_singleton_duplicate(0.5);
    my constant_sse_number_pair $one_point_five  = constant_sse_number_pair::new_from_singleton_duplicate(1.5);

    my number $dx_array_k;
    my number $dy_array_k;
    my number $dz_array_k;
    my number $magnitude_k;
    my number $body_i_mass_times_magnitude_k;
    my number $body_j_mass_times_magnitude_k;

    my integer $i_plus_1;
    my integer $k;

    my PhysicsPerl::Astro::Body_raw $body_i;
    my PhysicsPerl::Astro::Body_raw $body_j;

    for my integer $time_step ( 0 .. ( $time_step_max - 1 ) ) {
        $k = 0;
        for my integer $i ( 0 .. ( $bodies_size - 1 ) ) {
            $body_i = $self->{bodies}->[$i]->get_raw();
            for my integer $j ( ( $i + 1 ) .. ( $bodies_size - 1 ) ) {
                $body_j         = $self->{bodies}->[$j]->get_raw();
                $dx_array->[$k] = $body_i->{x} - $body_j->{x};
                $dy_array->[$k] = $body_i->{y} - $body_j->{y};
                $dz_array->[$k] = $body_i->{z} - $body_j->{z};
                $k++;
            }
        }

        for ( my integer $i = 0; $i < $bodies_size_triangle; $i += 2 ) {
            $i_plus_1         = $i + 1;
            $dx->[0]          = $dx_array->[$i];
            $dx->[1]          = $dx_array->[$i_plus_1];
            $dy->[0]          = $dy_array->[$i];
            $dy->[1]          = $dy_array->[$i_plus_1];
            $dz->[0]          = $dz_array->[$i];
            $dz->[1]          = $dz_array->[$i_plus_1];
            $distance_squared = ( $dx sse_mul $dx) sse_add( $dy sse_mul $dy) sse_add( $dz sse_mul $dz);
            $distance = sse_recip_sqrt_32bit_on_64bit($distance_squared);    # limited 32-bit precision, increase precision via Newton-Rhapson method below
            $distance = $distance sse_mul $one_point_five sse_sub( ( $zero_point_five sse_mul $distance_squared) sse_mul $distance)
                sse_mul( $distance sse_mul $distance);
            $distance = $distance sse_mul $one_point_five sse_sub( ( $zero_point_five sse_mul $distance_squared) sse_mul $distance)
                sse_mul( $distance sse_mul $distance);
            $magnitude                    = ( $delta_time_sse sse_div $distance_squared) sse_mul $distance;
            $magnitude_array->[$i]        = $magnitude->[0];
            $magnitude_array->[$i_plus_1] = $magnitude->[1];
        }

        $k = 0;
        for my integer $i ( 0 .. ( $bodies_size - 1 ) ) {
            $body_i = $self->{bodies}->[$i]->get_raw();
            for my integer $j ( ( $i + 1 ) .. ( $bodies_size - 1 ) ) {
                $body_j      = $self->{bodies}->[$j]->get_raw();
                $dx_array_k  = $dx_array->[$k];
                $dy_array_k  = $dy_array->[$k];
                $dz_array_k  = $dz_array->[$k];
                $magnitude_k = $magnitude_array->[$k];

                $body_i_mass_times_magnitude_k = $body_i->{mass} * $magnitude_k;
                $body_j_mass_times_magnitude_k = $body_j->{mass} * $magnitude_k;

                $body_i->{vx} -= $dx_array_k * $body_j_mass_times_magnitude_k;
                $body_j->{vx} += $dx_array_k * $body_i_mass_times_magnitude_k;
                $body_i->{vy} -= $dy_array_k * $body_j_mass_times_magnitude_k;
                $body_j->{vy} += $dy_array_k * $body_i_mass_times_magnitude_k;
                $body_i->{vz} -= $dz_array_k * $body_j_mass_times_magnitude_k;
                $body_j->{vz} += $dz_array_k * $body_i_mass_times_magnitude_k;

                $k++;
            }
        }

        for my integer $i ( 0 .. ( $bodies_size - 1 ) ) {
            $body_i = $self->{bodies}->[$i]->get_raw();
            $body_i->{x} += $delta_time * $body_i->{vx};
            $body_i->{y} += $delta_time * $body_i->{vy};
            $body_i->{z} += $delta_time * $body_i->{vz};
        }
    }
};

1;    # end of class
