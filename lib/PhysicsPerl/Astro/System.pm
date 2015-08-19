# [[[ HEADER ]]]
use RPerl;

package PhysicsPerl::Astro::System;
use strict;
use warnings;
our $VERSION = 0.002_000;

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
our hashref $properties = { bodies => my PhysicsPerl::Astro::Bo$dy_arrayref $TYPED_bodies = undef };

# [[[ OO METHODS & SUBROUTINES ]]]

# NEED FIX, CORRELATION #pp05: C++ & Perl get_bodies_element() both return void, can enable returning of object by switching on commented code below
#our PhysicsPerl::Astro::Body::method $get_bodies_element = sub {
#    ( my PhysicsPerl::Astro::System $self, my integer $i) = @_;
#    return $self->{bodies}->[$i];
our void::method $get_bodies_element = sub {
    ( my PhysicsPerl::Astro::System $self, my integer $i, my PhysicsPerl::Astro::Body $body_tmp) = @_;
    my PhysicsPerl::Astro::Body $body_i = $self->{bodies}->[$i];
    $body_tmp->{name}   = $body_i->{name};
    $body_tmp->{x}      = $body_i->{x};
    $body_tmp->{y}      = $body_i->{y};
    $body_tmp->{z}      = $body_i->{z};
    $body_tmp->{vx}     = $body_i->{vx};
    $body_tmp->{vy}     = $body_i->{vy};
    $body_tmp->{vz}     = $body_i->{vz};
    $body_tmp->{mass}   = $body_i->{mass};
    $body_tmp->{radius} = $body_i->{radius};
    $body_tmp->{color}  = $body_i->{color};
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
        my PhysicsPerl::Astro::Body $body_i = $self->{bodies}->[$i];
        $e += 0.5 * $body_i->{mass} * ( ( $body_i->{vx} * $body_i->{vx} ) + ( $body_i->{vy} * $body_i->{vy} ) + ( $body_i->{vz} * $body_i->{vz} ) );

        for my integer $j ( ( $i + 1 ) .. ( ( scalar @{ $self->{bodies} } ) - 1 ) ) {
            my PhysicsPerl::Astro::Body $body_j = $self->{bodies}->[$j];
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
    ( my PhysicsPerl::Astro::System $self, my number $delta_time, my integer $time_step_max ) = @_;
    my integer $bodies_size = scalar @{ $self->{bodies} };
    my number $dx;
    my number $dy;
    my number $dz;
    my number $distance_squared;
    my number $distance;
    my number $magnitude;
    my PhysicsPerl::Astro::Body $body_i;
    my PhysicsPerl::Astro::Body $body_j;

    for my integer $time_step ( 1 .. $time_step_max ) {
        for my integer $i ( 0 .. ( $bodies_size - 1 ) ) {
            $body_i = $self->{bodies}->[$i];
            for my integer $j ( ( $i + 1 ) .. ( $bodies_size - 1 ) ) {
                $body_j           = $self->{bodies}->[$j];
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
            $body_i = $self->{bodies}->[$i];
            $body_i->{x} += $delta_time * $body_i->{vx};
            $body_i->{y} += $delta_time * $body_i->{vy};
            $body_i->{z} += $delta_time * $body_i->{vz};
        }
    }
};

# START HERE: make sse types and ops work in Perl; compile!
# START HERE: make sse types and ops work in Perl; compile!
# START HERE: make sse types and ops work in Perl; compile!

our void::method $advance_loop_SSE = sub {
    ( my PhysicsPerl::Astro::System $self, my constant_number $delta_time, my constant_integer $time_step_max ) = @_;
    my constant_integer $bodies_size = scalar @{ $self->{bodies} };
    my constant_unsigned_integer $N = 10;

    my number_arrayref $dx_array[$N];
    my number_arrayref $dy_array[$N];
    my number_arrayref $dz_array[$N];
    my number_arrayref $magnitude_array[$N];

    my sse_constant_number_pair $delta_time_sse = sse_constant_number_pair->new_from_single($delta_time);
    my sse_number_pair $dx = sse_number_pair->new();
    my sse_number_pair $dy = sse_number_pair->new();
    my sse_number_pair $dz = sse_number_pair->new();
    my sse_number_pair $distance_squared = sse_number_pair->new();
    my sse_number_pair $distance = sse_number_pair->new();
    my sse_number_pair $magnitude = sse_number_pair->new();
    my sse_constant_number_pair $zero_point_five = sse_constant_number_pair->new_from_single(0.5);
    my sse_constant_number_pair $one_point_five = sse_constant_number_pair->new_from_single(1.5);
 
    my number $dx_array_k;
    my number $dy_array_k;
    my number $dz_array_k;
    my number $magnitude_k;
    my number $body_i_mass_times_magnitude_k;
    my number $body_j_mass_times_magnitude_k;

    my integer $i_plus_1;
    my integer $k;

    my PhysicsPerl::Astro::Body $body_i;
    my PhysicsPerl::Astro::Body $body_j;

    for ( my integer $time_step = 0; $time_step < $time_step_max; $time_step++ ) {

        $k = 0;
        for ( my integer $i = 0; $i < $bodies_size; $i++ ) {
            $body_i = $self->$bodies->[$i];
            for ( my integer $j = $i + 1; $j < $bodies_size; $j++ ) {
                $body_j = $self->{bodies}->[$j];
                $dx_array->[$k] = $body_i->{x} - $body_j->{x};
                $dy_array->[$k] = $body_i->{y} - $body_j->{y};
                $dz_array->[$k] = $body_i->{z} - $body_j->{z};
                $k++;
            }
        }

        for ( my integer $i = 0; $i < $N; $i += 2) {
            $i_plus_1 = $i + 1;
            $dx->[0] = $dx_array->[$i];
            $dx->[1] = $dx_array->[$i_plus_1];
            $dy->[0] = $dy_array->[$i];
            $dy->[1] = $dy_array->[$i_plus_1];
            $dz->[0] = $dz_array->[$i];
            $dz->[1] = $dz_array->[$i_plus_1];
            $distance_squared = ($dx sse_mul $dx) sse_add ($dy sse_mul $dy) sse_add ($dz sse_mul $dz);
            $distance = sse_number_quad_to_pair(sse_recip_sqrt_quad(sse_number_pair_to_quad($distance_squared)));
            $distance = $distance sse_mul $one_point_five sse_sub (($zero_point_five sse_mul $distance_squared) sse_mul $distance) sse_mul ($distance sse_mul $distance);
            $distance = $distance sse_mul $one_point_five sse_sub (($zero_point_five sse_mul $distance_squared) sse_mul $distance) sse_mul ($distance sse_mul $distance);
            $magnitude = ($delta_time_sse sse_div $distance_squared) sse_mul $distance;
            $magnitude_array->[$i] = $magnitude->[0];
            $magnitude_array->[$i_plus_1] = $magnitude->[1];
        }

        $k = 0;
        for ( my integer $i = 0; $i < bodies_size; $i++ ) {
            $body_i = $self->{bodies}->[$i];
            for ( my integer $j = $i + 1; $j < bodies_size; $j++ ) {
                $body_j = $self->{bodies}->[$j];
                $dx_array_k = $dx_array->[$k];
                $dy_array_k = $dy_array->[$k];
                $dz_array_k = $dz_array->[$k];
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

        for ( my integer $i = 0; $i < bodies_size; $i++ ) {
            $body_i = $self->{bodies}->[$i];
            $body_i->{x} += $delta_time * $body_i->{vx};
            $body_i->{y} += $delta_time * $body_i->{vy};
            $body_i->{z} += $delta_time * $body_i->{vz};
        }
    }
}

1;    # end of class
