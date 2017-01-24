# [[[ HEADER ]]]
use RPerl;

package PhysicsPerl::Astro::SystemSSE;
use strict;
use warnings;
our $VERSION = 0.007_000;

# [[[ OO INHERITANCE ]]]
use parent qw(PhysicsPerl::Astro::System);
use PhysicsPerl::Astro::System;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitCStyleForLoops)  # USER DEFAULT 6: allow C-style for() loop headers
## no critic qw(ProhibitPostfixControls)  # SYSTEM SPECIAL 6: PERL CRITIC FILED ISSUE #639, not postfix foreach or if

# [[[ INCLUDES ]]]
use PhysicsPerl::Astro::Body;
use rperlsse;

# [[[ OO PROPERTIES ]]]
our hashref $properties = { bodies => my PhysicsPerl::Astro::Body_arrayref $TYPED_bodies->[5 - 1] = undef };

# [[[ SUBROUTINES & OO METHODS ]]]

our void::method $advance_loop = sub {
    ( my PhysicsPerl::Astro::SystemSSE $self, my constant_number $delta_time, my constant_integer $time_step_max ) = @ARG;
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
