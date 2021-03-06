# [[[ PREPROCESSOR ]]]
# <<< PARSE: ON >>>
# <<< GENERATE: ON >>>

# [[[ HEADER ]]]
use RPerl;
package PhysicsPerl::Astro::System;
use strict;
use warnings;
our $VERSION = 0.010_000;

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
# DEV NOTE, CORRELATION #pp20: use only 5 gas giants for matching output w/ Alioth Benchmark code; comment to change hard-coded number of bodies, match below & in Body.pm
#our hashref $properties = { bodies => my PhysicsPerl::Astro::Body_arrayref $TYPED_bodies->[5 - 1] = undef };
our hashref $properties = { bodies => my PhysicsPerl::Astro::Body_arrayref $TYPED_bodies->[10 - 1] = undef };

# DEV NOTE: must update hard-coded size of 'bodies' property above to match number of bodies below

# [[[ SUBROUTINES & OO METHODS ]]]

sub init {
    { my void::method $RETURN_TYPE };
    ( my PhysicsPerl::Astro::System $self ) = @ARG;

# DEV NOTE, CORRELATION #pp20: use only 5 gas giants for matching output w/ Alioth Benchmark code; comment to change hard-coded number of bodies, match above & in Body.pm
#    $self->{bodies}->[0] = PhysicsPerl::Astro::Body::sun();
#    $self->{bodies}->[1] = PhysicsPerl::Astro::Body::jupiter();
#    $self->{bodies}->[2] = PhysicsPerl::Astro::Body::saturn();
#    $self->{bodies}->[3] = PhysicsPerl::Astro::Body::uranus();
#    $self->{bodies}->[4] = PhysicsPerl::Astro::Body::neptune();

    $self->{bodies}->[0] = PhysicsPerl::Astro::Body::sun();
    $self->{bodies}->[1] = PhysicsPerl::Astro::Body::mercury();
    $self->{bodies}->[2] = PhysicsPerl::Astro::Body::venus();
    $self->{bodies}->[3] = PhysicsPerl::Astro::Body::earth();
    $self->{bodies}->[4] = PhysicsPerl::Astro::Body::mars();
    $self->{bodies}->[5] = PhysicsPerl::Astro::Body::jupiter();
    $self->{bodies}->[6] = PhysicsPerl::Astro::Body::saturn();
    $self->{bodies}->[7] = PhysicsPerl::Astro::Body::uranus();
    $self->{bodies}->[8] = PhysicsPerl::Astro::Body::neptune();
    $self->{bodies}->[9] = PhysicsPerl::Astro::Body::pluto();

    my number $px = 0.0;
    my number $py = 0.0;
    my number $pz = 0.0;

    for my unsigned_integer $i ( 0 .. ( ( scalar @{ $self->{bodies} } ) - 1 ) ) {
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
    ( my PhysicsPerl::Astro::System $self ) = @ARG;
    my number $dx;
    my number $dy;
    my number $dz;
    my number $distance;
    my number $e = 0.0;

    for my unsigned_integer $i ( 0 .. ( ( scalar @{ $self->{bodies} } ) - 1 ) ) {
        my PhysicsPerl::Astro::Body_raw $body_i = $self->{bodies}->[$i]->get_raw();
        $e += 0.5 * $body_i->{mass} * ( ( $body_i->{vx} * $body_i->{vx} ) + ( $body_i->{vy} * $body_i->{vy} ) + ( $body_i->{vz} * $body_i->{vz} ) );

        for my unsigned_integer $j ( ( $i + 1 ) .. ( ( scalar @{ $self->{bodies} } ) - 1 ) ) {
            my PhysicsPerl::Astro::Body_raw $body_j = $self->{bodies}->[$j]->get_raw();
            $dx       = $body_i->{x} - $body_j->{x};
            $dy       = $body_i->{y} - $body_j->{y};
            $dz       = $body_i->{z} - $body_j->{z};
            $distance = ( ( $dx * $dx ) + ( $dy * $dy ) + ( $dz * $dz ) )**0.5;
            $e -= ( $body_i->{mass} * $body_j->{mass} ) / $distance;
        }
    }

    # NEED FIX, PERLCRITIC BUG: why are 2 return statements necessary here???
    return $e;
    return $e;
}

sub advance_loop {
    { my void::method $RETURN_TYPE };
    # NEED UPGRADE COMPILER: constant_unsigned_integer not currently supported in subroutine input arguments
    # Can't locate object method "advance_loop" via package "PhysicsPerl::Astro::System"
#    ( my PhysicsPerl::Astro::System $self, my constant_number $delta_time, my constant_unsigned_integer $time_step_max ) = @ARG;
    ( my PhysicsPerl::Astro::System $self, my constant_number $delta_time, my constant_integer $time_step_max ) = @ARG;
    my constant_unsigned_integer $bodies_size = scalar @{ $self->{bodies} };
    my number $dx;
    my number $dy;
    my number $dz;
    my number $distance_squared;
    my number $distance;
    my number $magnitude;
    my PhysicsPerl::Astro::Body_raw $body_i;
    my PhysicsPerl::Astro::Body_raw $body_j;

    for my integer $time_step ( 1 .. $time_step_max ) {
        if (($time_step % 25_000) == 0) {
            print 'Time Step ', ::integer_to_string($time_step), ' of ', ::integer_to_string($time_step_max), ', energy = ', ::number_to_string($self->energy()), "\n";
        }

        for my unsigned_integer $i ( 0 .. ( $bodies_size - 1 ) ) {
            $body_i = $self->{bodies}->[$i]->get_raw();
            for my unsigned_integer $j ( ( $i + 1 ) .. ( $bodies_size - 1 ) ) {
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
        for my unsigned_integer $i ( 0 .. ( $bodies_size - 1 ) ) {
            $body_i = $self->{bodies}->[$i]->get_raw();
            $body_i->{x} += $delta_time * $body_i->{vx};
            $body_i->{y} += $delta_time * $body_i->{vy};
            $body_i->{z} += $delta_time * $body_i->{vz};
        }
    }

    # NEED FIX, PERLCRITIC BUG: why are 2 return statements necessary here???
    return;
    return;
}

1;    # end of class
