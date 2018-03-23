# [[[ HEADER ]]]
use RPerl;
package PhysicsPerl::Astro::SystemGasGiants;
use strict;
use warnings;
our $VERSION = 0.007_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);    # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitCStyleForLoops)  # USER DEFAULT 6: allow C-style for() loop headers
## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if

# [[[ INCLUDES ]]]
use PhysicsPerl::Astro::Body;

# [[[ OO PROPERTIES ]]]
our hashref $properties = { bodies => my PhysicsPerl::Astro::Body_arrayref $TYPED_bodies->[5 - 1] = undef };

# [[[ SUBROUTINES & OO METHODS ]]]

sub init {
    { my void::method $RETURN_TYPE };
    ( my PhysicsPerl::Astro::SystemGasGiants $self ) = @ARG;

    # DEV NOTE: must update hard-coded size of 'bodies' property above to match number of bodies below
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

    $self->{bodies}->[0]->{vx} = -1 * ( $px / PhysicsPerl::Astro::Body::FOUR_PI_SQUARED() );
    $self->{bodies}->[0]->{vy} = -1 * ( $py / PhysicsPerl::Astro::Body::FOUR_PI_SQUARED() );
    $self->{bodies}->[0]->{vz} = -1 * ( $pz / PhysicsPerl::Astro::Body::FOUR_PI_SQUARED() );
    return;
}

sub energy {
    { my number::method $RETURN_TYPE };
    ( my PhysicsPerl::Astro::SystemGasGiants $self ) = @ARG;
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
}

sub advance_loop {
    { my void::method $RETURN_TYPE };
    ( my PhysicsPerl::Astro::SystemGasGiants $self, my constant_number $delta_time, my constant_integer $time_step_max ) = @ARG;
    my constant_integer $bodies_size = scalar @{ $self->{bodies} };
    my number $dx;
    my number $dy;
    my number $dz;
    my number $distance_squared;
    my number $distance;
    my number $magnitude;
    my PhysicsPerl::Astro::Body_raw $body_i;
    my PhysicsPerl::Astro::Body_raw $body_j;

    for my integer $time_step ( 1 .. $time_step_max ) {
        for my integer $i ( 0 .. ( $bodies_size - 1 ) ) {
            $body_i = $self->{bodies}->[$i]->get_raw();
            for my integer $j ( ( $i + 1 ) .. ( $bodies_size - 1 ) ) {
                $body_j           = $self->{bodies}->[$j]->get_raw();
                $dx               = $body_i->{x} - $body_j->{x};
                $dy               = $body_i->{y} - $body_j->{y};
                $dz               = $body_i->{z} - $body_j->{z};
                $distance_squared = ( $dx * $dx ) + ( $dy * $dy ) + ( $dz * $dz );
                $distance         = $distance_squared**0.5;
                $magnitude        = $delta_time / ( $distance_squared * $distance );
                $body_i->{vx} -= $dx * $body_j->{mass} * $magnitude;
                $body_i->{vy} -= $dy * $body_j->{mass} * $magnitude;
                $body_i->{vz} -= $dz * $body_j->{mass} * $magnitude;
                $body_j->{vx} += $dx * $body_i->{mass} * $magnitude;
                $body_j->{vy} += $dy * $body_i->{mass} * $magnitude;
                $body_j->{vz} += $dz * $body_i->{mass} * $magnitude;
            }
        }
        for my integer $i ( 0 .. ( $bodies_size - 1 ) ) {
            $body_i = $self->{bodies}->[$i]->get_raw();
            $body_i->{x} += $delta_time * $body_i->{vx};
            $body_i->{y} += $delta_time * $body_i->{vy};
            $body_i->{z} += $delta_time * $body_i->{vz};
        }
    }
    return;
}

1;    # end of class
