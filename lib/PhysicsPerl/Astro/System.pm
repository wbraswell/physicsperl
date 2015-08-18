# [[[ HEADER ]]]
use RPerl;

package PhysicsPerl::Astro::System;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);    # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if

# [[[ INCLUDES ]]]
use PhysicsPerl::Astro::Body;

# [[[ OO PROPERTIES ]]]
our hashref $properties = { bodies => my PhysicsPerl::Astro::Body_arrayref $TYPED_bodies = undef };

# [[[ OO METHODS & SUBROUTINES ]]]

our void::method $get_i_body = sub {
    ( my PhysicsPerl::Astro::System $self, my PhysicsPerl::Astro::Body $pre_body, my integer $i) = @_;
    return $self->{bodies}->[$i];
};

our void::method $init = sub {
    ( my PhysicsPerl::Astro::System $self ) = @_;
    $self->{bodies} = [
        PhysicsPerl::Astro::Body::sun(), PhysicsPerl::Astro::Body::jupiter(), PhysicsPerl::Astro::Body::saturn(), PhysicsPerl::Astro::Body::uranus(),
        PhysicsPerl::Astro::Body::neptune()
    ];
    my number $px = 0.0;
    my number $py = 0.0;
    my number $pz = 0.0;

    for my integer $i ( 0 .. ( ( scalar @{ $self->{bodies} } ) - 1 ) ) {

        #        RPerl::diag('in System::init(), have $self->{bodies}->[' . $i . '] = ' . "\n" . Dumper($self->{bodies}->[$i]) . "\n");
        $px += $self->{bodies}->[$i]->{vx} * $self->{bodies}->[$i]->{mass};
        $py += $self->{bodies}->[$i]->{vy} * $self->{bodies}->[$i]->{mass};
        $pz += $self->{bodies}->[$i]->{vz} * $self->{bodies}->[$i]->{mass};
    }

    $self->{bodies}->[0]->offset_momentum( $px, $py, $pz );
};

our number::method $energy = sub {
    ( my PhysicsPerl::Astro::System $self ) = @_;
    my number $dx;
    my number $dy;
    my number $dz;
    my number $distance;
    my number $e = 0.0;

    for my integer $i ( 0 .. ( ( scalar @{ $self->{bodies} } ) - 1 ) ) {
        my PhysicsPerl::Astro::Body $i_body = $self->{bodies}->[$i];
        $e += 0.5 * $i_body->{mass} * ( ( $i_body->{vx} * $i_body->{vx} ) + ( $i_body->{vy} * $i_body->{vy} ) + ( $i_body->{vz} * $i_body->{vz} ) );

        for my integer $j ( ( $i + 1 ) .. ( ( scalar @{ $self->{bodies} } ) - 1 ) ) {
            my PhysicsPerl::Astro::Body $j_body = $self->{bodies}->[$j];
            $dx       = $i_body->{x} - $j_body->{x};
            $dy       = $i_body->{y} - $j_body->{y};
            $dz       = $i_body->{z} - $j_body->{z};
            $distance = ( ( $dx * $dx ) + ( $dy * $dy ) + ( $dz * $dz ) )**0.5;
            $e -= ( $i_body->{mass} * $j_body->{mass} ) / $distance;
        }
    }
    return $e;
};

# START HERE: inline advance() into advance_loop(), rename Render2DSystem & Body, write System.pm.SSE
# START HERE: inline advance() into advance_loop(), rename Render2DSystem & Body, write System.pm.SSE
# START HERE: inline advance() into advance_loop(), rename Render2DSystem & Body, write System.pm.SSE

our void::method $advance_loop = sub {
    ( my PhysicsPerl::Astro::System $self, my number $dt, my integer $n ) = @_;
#    my integer $bodies_size = scalar @{ $self->{bodies} };
#    my integer $i;
#    my integer $j;
    my number $dx;
    my number $dy;
    my number $dz;
    my number $distance_squared;
    my number $distance;
    my number $magnitude;
    my PhysicsPerl::Astro::Body $i_body;
    my PhysicsPerl::Astro::Body $j_body;

    for my integer $time_step ( 1 .. $n ) {
        for my integer $i ( 0 .. ( ( scalar @{ $self->{bodies} } ) - 1 ) ) {
            $i_body = $self->{bodies}->[$i];

            for my integer $j ( ( $i + 1 ) .. ( ( scalar @{ $self->{bodies} } ) - 1 ) ) {
                $j_body = $self->{bodies}->[$j];
                $dx                       = $i_body->{x} - $j_body->{x};
                $dy                       = $i_body->{y} - $j_body->{y};
                $dz                       = $i_body->{z} - $j_body->{z};

                $distance_squared = ( $dx * $dx ) + ( $dy * $dy ) + ( $dz * $dz );
                $distance         = $distance_squared**0.5;
                $magnitude        = $dt / ( $distance_squared * $distance );

                $i_body->{vx} -= $dx * $self->{bodies}->[$j]->{mass} * $magnitude;
                $i_body->{vy} -= $dy * $self->{bodies}->[$j]->{mass} * $magnitude;
                $i_body->{vz} -= $dz * $self->{bodies}->[$j]->{mass} * $magnitude;

                $self->{bodies}->[$j]->{vx} += $dx * $i_body->{mass} * $magnitude;
                $self->{bodies}->[$j]->{vy} += $dy * $i_body->{mass} * $magnitude;
                $self->{bodies}->[$j]->{vz} += $dz * $i_body->{mass} * $magnitude;
            }
        }

        foreach my PhysicsPerl::Astro::Body $body ( @{ $self->{bodies} } ) {
            $body->{x} += $dt * $body->{vx};
            $body->{y} += $dt * $body->{vy};
            $body->{z} += $dt * $body->{vz};
        }
    }
};

1;           # end of class
