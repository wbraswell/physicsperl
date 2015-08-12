# [[[ HEADER ]]]
use RPerl;
package PhysicsPerl::Astro::Body;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);    # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ CONSTANTS ]]]
use constant PI            => my number $TYPED_PI            = 3.141_592_653_589_793;
use constant SOLAR_MASS    => my number $TYPED_SOLAR_MASS    = 39.478_417_604_357_4;  # 4 * PI() * PI()
use constant DAYS_PER_YEAR => my number $TYPED_DAYS_PER_YEAR = 365.24;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    # NEED FIX: x as WORD vs OP string repeat
    x=> my number $TYPED_x= undef,
    y    => my number $TYPED_y    = undef,
    z    => my number $TYPED_z    = undef,
    vx   => my number $TYPED_vx   = undef,
    vy   => my number $TYPED_vy   = undef,
    vz   => my number $TYPED_vz   = undef,
    mass => my number $TYPED_mass = undef
};

# [[[ OO METHODS & SUBROUTINES ]]]

our PhysicsPerl::Astro::Body $jupiter = sub {
    my PhysicsPerl::Astro::Body $p = PhysicsPerl::Astro::Body->new();
    $p->{x}    = +4.841_431_442_464_720_90e+00;
    $p->{y}    = -1.160_320_044_027_428_39e+00;
    $p->{z}    = -1.036_220_444_711_231_09e-01;
    $p->{vx}   = +1.660_076_642_744_036_94e-03 * DAYS_PER_YEAR();
    $p->{vy}   = +7.699_011_184_197_404_25e-03 * DAYS_PER_YEAR();
    $p->{vz}   = -6.904_600_169_720_630_23e-05 * DAYS_PER_YEAR();
    $p->{mass} = +9.547_919_384_243_266_09e-04 * SOLAR_MASS();
    return $p;
};

our PhysicsPerl::Astro::Body $saturn = sub {
    my PhysicsPerl::Astro::Body $p = PhysicsPerl::Astro::Body->new();
    $p->{x}    = +8.343_366_718_244_579_87e+00;
    $p->{y}    = +4.124_798_564_124_304_79e+00;
    $p->{z}    = -4.035_234_171_143_213_81e-01;
    $p->{vx}   = -2.767_425_107_268_624_11e-03 * DAYS_PER_YEAR();
    $p->{vy}   = +4.998_528_012_349_172_38e-03 * DAYS_PER_YEAR();
    $p->{vz}   = +2.304_172_975_737_639_29e-05 * DAYS_PER_YEAR();
    $p->{mass} = +2.858_859_806_661_308_12e-04 * SOLAR_MASS();
    return $p;
};

our PhysicsPerl::Astro::Body $uranus = sub {
    my PhysicsPerl::Astro::Body $p = PhysicsPerl::Astro::Body->new();
    $p->{x}    = +1.289_436_956_213_913_10e+01;
    $p->{y}    = -1.511_115_140_169_863_12e+01;
    $p->{z}    = -2.233_075_788_926_557_34e-01;
    $p->{vx}   = +2.964_601_375_647_616_18e-03 * DAYS_PER_YEAR();
    $p->{vy}   = +2.378_471_739_594_809_50e-03 * DAYS_PER_YEAR();
    $p->{vz}   = -2.965_895_685_402_375_56e-05 * DAYS_PER_YEAR();
    $p->{mass} = +4.366_244_043_351_562_98e-05 * SOLAR_MASS();
    return $p;
};

our PhysicsPerl::Astro::Body $neptune = sub {
    my PhysicsPerl::Astro::Body $p = PhysicsPerl::Astro::Body->new();
    $p->{x}    = +1.537_969_711_485_091_65e+01;
    $p->{y}    = -2.591_931_460_998_796_41e+01;
    $p->{z}    = +1.792_587_729_503_711_81e-01;
    $p->{vx}   = +2.680_677_724_903_893_22e-03 * DAYS_PER_YEAR();
    $p->{vy}   = +1.628_241_700_382_422_95e-03 * DAYS_PER_YEAR();
    $p->{vz}   = -9.515_922_545_197_158_70e-05 * DAYS_PER_YEAR();
    $p->{mass} = +5.151_389_020_466_114_51e-05 * SOLAR_MASS();
    return $p;
};

our PhysicsPerl::Astro::Body $sun = sub {
    my PhysicsPerl::Astro::Body $p = PhysicsPerl::Astro::Body->new();
    $p->{x}    = 0;
    $p->{y}    = 0;
    $p->{z}    = 0;
    $p->{vx}   = 0;
    $p->{vy}   = 0;
    $p->{vz}   = 0;
    $p->{mass} = SOLAR_MASS();
    return $p;
};

our void::method $offset_momentum = sub {
    ( my PhysicsPerl::Astro::Body $self, my number $px, my number $py, my number $pz ) = @_;
    $self->{vx} = -1 * ( $px / SOLAR_MASS() );
    $self->{vy} = -1 * ( $py / SOLAR_MASS() );
    $self->{vz} = -1 * ( $pz / SOLAR_MASS() );
};

1;    # end of class
