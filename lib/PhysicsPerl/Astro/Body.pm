# [[[ PREPROCESSOR ]]]
# <<< PARSE: ON >>>
# <<< GENERATE: ON >>>

# [[[ HEADER ]]]
use RPerl;
package PhysicsPerl::Astro::Body;
use strict;
use warnings;
our $VERSION = 0.007_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);    # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(ProhibitConstantPragma ProhibitMagicNumbers)  # USER DEFAULT 3: allow constants

# [[[ CONSTANTS ]]]
#use constant PI           => my number $TYPED_PI           = 3.141_592_653_589_793;  # CURRENTLY UNUSED
use constant FOUR_PI_SQUARED => my number $TYPED_FOUR_PI_SQUARED = 39.478_417_604_357_4;    # 4 * PI() * PI()

#use constant SOLAR_RADIUS => my number $TYPED_SOLAR_RADIUS = 696_300;                 # kilometers  # CURRENTLY UNUSED
use constant DAYS_PER_YEAR => my number $TYPED_DAYS_PER_YEAR = 365.24;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    name   => my string $TYPED_name            = undef,
    x      => my number $TYPED_x               = undef,
    y      => my number $TYPED_y               = undef,
    z      => my number $TYPED_z               = undef,
    vx     => my number $TYPED_vx              = undef,
    vy     => my number $TYPED_vy              = undef,
    vz     => my number $TYPED_vz              = undef,
    mass   => my number $TYPED_mass            = undef,
    radius => my number $TYPED_radius          = undef,
    color  => my integer_arrayref $TYPED_color = undef
};

# [[[ SUBROUTINES & OO METHODS ]]]

sub sun {
    { my PhysicsPerl::Astro::Body $RETURN_TYPE };
    my PhysicsPerl::Astro::Body $body = PhysicsPerl::Astro::Body->new();
    $body->{name}   = 'The Sun (Sol)';
    $body->{x}      = 0;
    $body->{y}      = 0;
    $body->{z}      = 0;
    $body->{vx}     = 0;
    $body->{vy}     = 0;
    $body->{vz}     = 0;
    $body->{mass}   = PhysicsPerl::Astro::Body::FOUR_PI_SQUARED();
    $body->{radius} = 1;                                        # in units of solar radii
    $body->{color}  = [ 255, 245, 240 ];                        # in RGB, estimate
    return $body;
}

# http://ssd.jpl.nasa.gov/

# NEED UPDATE: add real colors for all rocky planets
sub mercury {
    { my PhysicsPerl::Astro::Body $RETURN_TYPE };
    my PhysicsPerl::Astro::Body $body = PhysicsPerl::Astro::Body->new();
#    $body->{name}   = '      Mercury';  # move name away from Sun, due to scale mismatch between body sizes & body distances
    $body->{name}   = '      M.';
    $body->{x}      = +3.067_925_455_119_497e-01;
    $body->{y}      = -2.695_851_754_307_215e-01;
    $body->{z}      = -5.017_408_038_016_835e-02;
    $body->{vx}     = +1.300_791_785_131_080e-02 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vy}     = +2.245_507_195_129_482e-02 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vz}     = +6.414_809_034_847_098e-04 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{mass}   = +1.660_136_795_271_930_4e-07 * PhysicsPerl::Astro::Body::FOUR_PI_SQUARED();
    $body->{radius} = +3.505e-03;                                                                  # in units of solar radii; 2_440 kilometers
    $body->{color}  = [ 0, 0, 0 ];                                                             # in RGB, estimate
    return $body;
}

sub venus {
    { my PhysicsPerl::Astro::Body $RETURN_TYPE };
    my PhysicsPerl::Astro::Body $body = PhysicsPerl::Astro::Body->new();
#    $body->{name}   = '          Venus';  # move name away from Sun, due to scale mismatch between body sizes & body distances
    $body->{name}   = '          V.';
    $body->{x}      = +7.248_985_943_229_426e-01;
    $body->{y}      = +2.250_842_837_066_930e-02;
    $body->{z}      = -4.152_252_796_285_734e-02;
    $body->{vx}     = -7.115_663_662_455_383e-04 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vy}     = +2.012_442_278_126_239e-02 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vz}     = +3.170_051_245_998_433e-04 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{mass}   = +2.447_838_339_664_544_7e-06 * PhysicsPerl::Astro::Body::FOUR_PI_SQUARED();
    $body->{radius} = +8.695e-03;                                                                  # in units of solar radii; 6_052 kilometers
    $body->{color}  = [ 0, 0, 0 ];                                                             # in RGB, estimate
    return $body;
}

sub earth {
    { my PhysicsPerl::Astro::Body $RETURN_TYPE };
    my PhysicsPerl::Astro::Body $body = PhysicsPerl::Astro::Body->new();
    $body->{name}   = '               Earth';  # move name away from Sun, due to scale mismatch between body sizes & body distances
    $body->{x}      = +3.371_149_298_368_602e-01;
    $body->{y}      = +9.264_627_375_634_086e-01;
    $body->{z}      = -3.656_592_330_717_117e-05;
    $body->{vx}     = -1.644_763_250_008_539e-02 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vy}     = +5.818_900_153_313_822e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vz}     = -1.401_742_451_705_546e-07 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{mass}   = +3.040_432_646_268_525_7e-06 * PhysicsPerl::Astro::Body::FOUR_PI_SQUARED();
    $body->{radius} = +9.154e-03;                                                                  # in units of solar radii; 6_371 kilometers
    $body->{color}  = [ 0, 0, 255 ];                                                             # in RGB, estimate
    return $body;
}

sub mars {
    { my PhysicsPerl::Astro::Body $RETURN_TYPE };
    my PhysicsPerl::Astro::Body $body = PhysicsPerl::Astro::Body->new();
    $body->{name}   = '                   Mars';  # move name away from Sun, due to scale mismatch between body sizes & body distances
    $body->{x}      = +1.387_314_349_787_443e+00;
    $body->{y}      = -6.417_694_205_651_260e-02;
    $body->{z}      = -3.539_252_627_294_046e-02;
    $body->{vx}     = +1.182_433_685_289_971e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vy}     = +1.517_628_652_546_086e-02 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vz}     = +2.890_089_362_707_097e-04 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{mass}   = +3.227_151_445_053_874_3e-07 * PhysicsPerl::Astro::Body::FOUR_PI_SQUARED();
    $body->{radius} = +4.87e-03;                                                                  # in units of solar radii; 3_390 kilometers
    $body->{color}  = [ 255, 0, 0 ];                                                             # in RGB, estimate
    return $body;
}

sub jupiter {
    { my PhysicsPerl::Astro::Body $RETURN_TYPE };
    my PhysicsPerl::Astro::Body $body = PhysicsPerl::Astro::Body->new();
    $body->{name}   = 'Jupiter';
    $body->{x}      = +4.841_431_442_464_720_90e+00;
    $body->{y}      = -1.160_320_044_027_428_39e+00;
    $body->{z}      = -1.036_220_444_711_231_09e-01;
    $body->{vx}     = +1.660_076_642_744_036_94e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vy}     = +7.699_011_184_197_404_25e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vz}     = -6.904_600_169_720_630_23e-05 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{mass}   = +9.547_919_384_243_266_09e-04 * PhysicsPerl::Astro::Body::FOUR_PI_SQUARED();
    $body->{radius} = +1.004_035_616_831_83e-01;                                                   # in units of solar radii; 69_911 kilometers
    $body->{color}  = [ 175, 75, 25 ];                                                             # in RGB, estimate
    return $body;
}

sub saturn {
    { my PhysicsPerl::Astro::Body $RETURN_TYPE };
    my PhysicsPerl::Astro::Body $body = PhysicsPerl::Astro::Body->new();
    $body->{name}   = 'Saturn';
    $body->{x}      = +8.343_366_718_244_579_87e+00;
    $body->{y}      = +4.124_798_564_124_304_79e+00;
    $body->{z}      = -4.035_234_171_143_213_81e-01;
    $body->{vx}     = -2.767_425_107_268_624_11e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vy}     = +4.998_528_012_349_172_38e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vz}     = +2.304_172_975_737_639_29e-05 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{mass}   = +2.858_859_806_661_308_12e-04 * PhysicsPerl::Astro::Body::FOUR_PI_SQUARED();
    $body->{radius} = +8.363_061_898_606_92e-02;                                                   # in units of solar radii; 58_232 kilometers
    $body->{color}  = [ 250, 215, 160 ];                                                           # in RGB, estimate
    return $body;
}

sub uranus {
    { my PhysicsPerl::Astro::Body $RETURN_TYPE };
    my PhysicsPerl::Astro::Body $body = PhysicsPerl::Astro::Body->new();
    $body->{name}   = 'Uranus';
    $body->{x}      = +1.289_436_956_213_913_10e+01;
    $body->{y}      = -1.511_115_140_169_863_12e+01;
    $body->{z}      = -2.233_075_788_926_557_34e-01;
    $body->{vx}     = +2.964_601_375_647_616_18e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vy}     = +2.378_471_739_594_809_50e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vz}     = -2.965_895_685_402_375_56e-05 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{mass}   = +4.366_244_043_351_562_98e-05 * PhysicsPerl::Astro::Body::FOUR_PI_SQUARED();
    $body->{radius} = +3.642_251_902_915_41e-02;                                                   # in units of solar radii; 25_361 kilometers
    $body->{color}  = [ 0, 240, 255 ];                                                             # in RGB, estimate
    return $body;
}

sub neptune {
    { my PhysicsPerl::Astro::Body $RETURN_TYPE };
    my PhysicsPerl::Astro::Body $body = PhysicsPerl::Astro::Body->new();
    $body->{name}   = 'Neptune';
    $body->{x}      = +1.537_969_711_485_091_65e+01;
    $body->{y}      = -2.591_931_460_998_796_41e+01;
    $body->{z}      = +1.792_587_729_503_711_81e-01;
    $body->{vx}     = +2.680_677_724_903_893_22e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vy}     = +1.628_241_700_382_422_95e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vz}     = -9.515_922_545_197_158_70e-05 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{mass}   = +5.151_389_020_466_114_51e-05 * PhysicsPerl::Astro::Body::FOUR_PI_SQUARED();
    $body->{radius} = +3.535_975_872_468_76e-02;                                                   # in units of solar radii; 24_621 kilometers
    $body->{color}  = [ 55, 85, 230 ];                                                             # in RGB, estimate
    return $body;
}

sub pluto {
    { my PhysicsPerl::Astro::Body $RETURN_TYPE };
    my PhysicsPerl::Astro::Body $body = PhysicsPerl::Astro::Body->new();
    $body->{name}   = 'Pluto';
    $body->{x}      = +9.567_892_811_759_823e+00;
    $body->{y}      = -3.181_011_870_947_866e+01;
    $body->{z}      = +6.350_230_130_441_942e-01;
    $body->{vx}     = +3.063_970_287_718_061e-03 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vy}     = +2.416_600_270_961_735e-04 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{vz}     = -9.066_478_029_110_260e-04 * PhysicsPerl::Astro::Body::DAYS_PER_YEAR();
    $body->{mass}   = +7.407_407_407_407_407e-09 * PhysicsPerl::Astro::Body::FOUR_PI_SQUARED();
    $body->{radius} = +1.705e-03;                                                   # in units of solar radii; 1_187 kilometers
    $body->{color}  = [ 0, 0, 255 ];                                                             # in RGB, estimate
    return $body;
}

1;                                                                                                 # end of class
