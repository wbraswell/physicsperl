# [[[ PREPROCESSOR ]]]
# <<< PARSE: ON >>>
# <<< GENERATE: ON >>>

# [[[ HEADER ]]]
use RPerl;

package PhysicsPerl::Astro::SystemSSE;
use strict;
use warnings;
our $VERSION = 0.010_000;

# [[[ OO INHERITANCE ]]]
#use parent qw(RPerl::CompileUnit::Module::Class);    # no non-system inheritance, only inherit from base class
#use RPerl::CompileUnit::Module::Class;
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
our hashref $properties = {};  # DEV NOTE: must not declare 'bodies', to avoid clobbering property inherited from PhysicsPerl::Astro::System in CPPOPS_CPPTYPES mode

# [[[ SUBROUTINES & OO METHODS ]]]

sub advance_loop {
    { my void::method $RETURN_TYPE };
    # NEED UPGRADE COMPILER: constant_unsigned_integer not currently supported in subroutine input arguments
    # Can't locate object method "advance_loop" via package "PhysicsPerl::Astro::SystemSSE"
#    ( my PhysicsPerl::Astro::SystemSSE $self, my constant_number $delta_time, my constant_unsigned_integer $time_step_max ) = @ARG;
    ( my PhysicsPerl::Astro::SystemSSE $self, my constant_number $delta_time, my constant_integer $time_step_max ) = @ARG;
    my constant_unsigned_integer $bodies_size = scalar @{ $self->{bodies} };
    my constant_unsigned_integer $bodies_size_triangle  = (($bodies_size - 1) * $bodies_size) / 2;

    # DEV NOTE: arrays must be sized ($bodies_size_triangle + 1), because loop 0.1 has $i_plus_1 as 1 greater than $bodies_size_triangle;
    # avoid C++ error "`/usr/bin/perl': free(): invalid next size (fast)"
    my number_arrayref $dx_array->[ ($bodies_size_triangle + 1) - 1 ]        = undef;
    my number_arrayref $dy_array->[ ($bodies_size_triangle + 1) - 1 ]        = undef;
    my number_arrayref $dz_array->[ ($bodies_size_triangle + 1) - 1 ]        = undef;
    my number_arrayref $magnitude_array->[ ($bodies_size_triangle + 1) - 1 ] = undef;

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

    my unsigned_integer $i_plus_1;
    my unsigned_integer $k;

    my PhysicsPerl::Astro::Body_raw $body_i;
    my PhysicsPerl::Astro::Body_raw $body_j;

    for my integer $time_step ( 0 .. ( $time_step_max - 1 ) ) {  # loop 0

print {*STDERR} 'in SystemSSE::advance_loop(), before loop 0.0, have $bodies_size = ', $bodies_size, "\n";
print {*STDERR} 'in SystemSSE::advance_loop(), before loop 0.0, have $bodies_size_triangle = ', $bodies_size_triangle, "\n";
        $k = 0;
        for my unsigned_integer $i ( 0 .. ( $bodies_size - 2 ) ) {  # loop 0.0
print {*STDERR} 'in SystemSSE::advance_loop(), top of loop 0.0, have $i = ', $i, ', $k = ', $k, "\n";
            $body_i = $self->{bodies}->[$i]->get_raw();
            for my unsigned_integer $j ( ( $i + 1 ) .. ( $bodies_size - 1 ) ) {  # loop 0.0.0
print {*STDERR} 'in SystemSSE::advance_loop(), top of loop 0.0.0, have $i = ', $i, ', $j = ', $j, ', $k = ', $k, "\n";
                $body_j         = $self->{bodies}->[$j]->get_raw();
                $dx_array->[$k] = $body_i->{x} - $body_j->{x};
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.0.0, have $dx_array->[$k] = ', $dx_array->[$k], "\n";
                $dy_array->[$k] = $body_i->{y} - $body_j->{y};
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.0.0, have $dy_array->[$k] = ', $dy_array->[$k], "\n";
                $dz_array->[$k] = $body_i->{z} - $body_j->{z};
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.0.0, have $dz_array->[$k] = ', $dz_array->[$k], "\n";
                $k++;
            }

            # DEV NOTE: possibly initialize one final (x,y,z) component to (0,0,0); avoid Perl error 'use of uninitialized value' in loop 0.1 '$dx->[1] = $dx_array->[$i_plus_1];' and friends below
            if ($k <= $bodies_size_triangle) {
print {*STDERR} 'in SystemSSE::advance_loop(), bottom of loop 0.0, have $i = ', $i, ', $k = ', $k, ', YES (0,0,0) INITIALIZE', "\n";
                $dx_array->[$k] = 0;
                $dy_array->[$k] = 0;
                $dz_array->[$k] = 0;
            }
            else {
print {*STDERR} 'in SystemSSE::advance_loop(), bottom of loop 0.0, have $i = ', $i, ', $k = ', $k, ', NO  (0,0,0) INITIALIZE', "\n";
            }
        }

        for ( my unsigned_integer $i = 0; $i < $bodies_size_triangle; $i += 2 ) {  # loop 0.1
print {*STDERR} 'in SystemSSE::advance_loop(), top of loop 0.1, have $i = ', $i, "\n";
            $i_plus_1         = $i + 1;
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.a, have $i_plus_1 = ', $i_plus_1, "\n";
            $dx->[0]          = $dx_array->[$i];
            $dx->[1]          = $dx_array->[$i_plus_1];
            $dy->[0]          = $dy_array->[$i];
            $dy->[1]          = $dy_array->[$i_plus_1];
            $dz->[0]          = $dz_array->[$i];
            $dz->[1]          = $dz_array->[$i_plus_1];

print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.b, have $dx->[0] = ', $dx->[0], "\n";
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.c, have $dy->[0] = ', $dy->[0], "\n";
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.d, have $dz->[0] = ', $dz->[0], "\n";
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.e, have $dx->[1] = ', $dx->[1], "\n";
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.f, have $dy->[1] = ', $dy->[1], "\n";
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.g, have $dz->[1] = ', $dz->[1], "\n";

            $distance_squared = ( $dx sse_mul $dx ) sse_add ( $dy sse_mul $dy ) sse_add ( $dz sse_mul $dz );
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.h, have $distance_squared->[0] = ', $distance_squared->[0], "\n";
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.h, have $distance_squared->[1] = ', $distance_squared->[1], "\n";

            $distance = sse_recip_sqrt_32bit_on_64bit($distance_squared);    # limited 32-bit precision, increase precision via Newton-Rhapson method below
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.i, have $distance->[0] = ', $distance->[0], "\n";
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.i, have $distance->[1] = ', $distance->[1], "\n";

            $distance = $distance sse_mul $one_point_five sse_sub ( ( $zero_point_five sse_mul $distance_squared) sse_mul $distance ) sse_mul ( $distance sse_mul $distance );
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.j, have $distance->[0] = ', $distance->[0], "\n";
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.j, have $distance->[1] = ', $distance->[1], "\n";

            $distance = $distance sse_mul $one_point_five sse_sub ( ( $zero_point_five sse_mul $distance_squared) sse_mul $distance ) sse_mul ( $distance sse_mul $distance );
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.k, have $distance->[0] = ', $distance->[0], "\n";
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.k, have $distance->[1] = ', $distance->[1], "\n";

            $magnitude                    = ( $delta_time_sse sse_div $distance_squared ) sse_mul $distance;
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.l, have $magnitude->[0] = ', $magnitude->[0], "\n";
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.l, have $magnitude->[1] = ', $magnitude->[1], "\n";

            $magnitude_array->[$i]        = $magnitude->[0];
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.m, have $magnitude_array->[$i] = ', $magnitude_array->[$i], "\n";
            $magnitude_array->[$i_plus_1] = $magnitude->[1];
print {*STDERR} 'in SystemSSE::advance_loop(), in loop 0.1, checkpoint 0.1.n, have $magnitude_array->[$i_plus_1] = ', $magnitude_array->[$i_plus_1], "\n";
        }

        $k = 0;
        for my unsigned_integer $i ( 0 .. ( $bodies_size - 2 ) ) {  # loop 0.2
print {*STDERR} 'in SystemSSE::advance_loop(), top of loop 0.2, have $i = ', $i, "\n";
            $body_i = $self->{bodies}->[$i]->get_raw();
            for my unsigned_integer $j ( ( $i + 1 ) .. ( $bodies_size - 1 ) ) {  # loop 0.2.1
print {*STDERR} 'in SystemSSE::advance_loop(), top of loop 0.2.1, have $k = ', $k, "\n";

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

        for my unsigned_integer $i ( 0 .. ( $bodies_size - 1 ) ) {  # loop 0.3
print {*STDERR} 'in SystemSSE::advance_loop(), top of loop 0.3, have $i = ', $i, "\n";
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

1;  # end of class
