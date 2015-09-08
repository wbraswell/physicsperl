// [[[ HEADER ]]]
using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__PhysicsPerl__Astro__Body_cpp
#define __CPP__INCLUDED__PhysicsPerl__Astro__Body_cpp 0.006_000

// [[[ INCLUDES ]]]
#include "System.h"

# ifdef __PERL__TYPES

Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ OO METHODS & SUBROUTINES ]]]

PhysicsPerl__Astro__Body_ptr PhysicsPerl__Astro__Body__sun() {
    PhysicsPerl__Astro__Body_ptr body(new PhysicsPerl__Astro__Body);
    body->name = (const string) "The Sun (Sol)";
    body->x = 0;
    body->y = 0;
    body->z = 0;
    body->vx = 0;
    body->vy = 0;
    body->vz = 0;
    body->mass = PhysicsPerl__Astro__Body__SOLAR_MASS;
    body->radius = 1;
    body->color = {255, 245, 240};
    return body;
}

PhysicsPerl__Astro__Body_ptr PhysicsPerl__Astro__Body__jupiter() {
    PhysicsPerl__Astro__Body_ptr body(new PhysicsPerl__Astro__Body);
    body->name = (const string) "Jupiter";
    body->x = +4.84143144246472090e+00;
    body->y = -1.16032004402742839e+00;
    body->z = -1.03622044471123109e-01;
    body->vx = +1.66007664274403694e-03 * PhysicsPerl__Astro__Body__DAYS_PER_YEAR;
    body->vy = +7.69901118419740425e-03 * PhysicsPerl__Astro__Body__DAYS_PER_YEAR;
    body->vz = -6.90460016972063023e-05 * PhysicsPerl__Astro__Body__DAYS_PER_YEAR;
    body->mass = +9.54791938424326609e-04 * PhysicsPerl__Astro__Body__SOLAR_MASS;
    body->radius = +1.00403561683183e-01;
    body->color = {175, 75, 25};
    return body;
}

PhysicsPerl__Astro__Body_ptr PhysicsPerl__Astro__Body__saturn() {
    PhysicsPerl__Astro__Body_ptr body(new PhysicsPerl__Astro__Body);
    body->name = (const string) "Saturn";
    body->x = +8.34336671824457987e+00;
    body->y = +4.12479856412430479e+00;
    body->z = -4.03523417114321381e-01;
    body->vx = -2.76742510726862411e-03 * PhysicsPerl__Astro__Body__DAYS_PER_YEAR;
    body->vy = +4.99852801234917238e-03 * PhysicsPerl__Astro__Body__DAYS_PER_YEAR;
    body->vz = +2.30417297573763929e-05 * PhysicsPerl__Astro__Body__DAYS_PER_YEAR;
    body->mass = +2.85885980666130812e-04 * PhysicsPerl__Astro__Body__SOLAR_MASS;
    body->radius = +8.36306189860692e-02;
    body->color = {250, 215, 160};
    return body;
}

PhysicsPerl__Astro__Body_ptr PhysicsPerl__Astro__Body__uranus() {
    PhysicsPerl__Astro__Body_ptr body(new PhysicsPerl__Astro__Body);
    body->name = (const string) "Uranus";
    body->x = +1.28943695621391310e+01;
    body->y = -1.51111514016986312e+01;
    body->z = -2.23307578892655734e-01;
    body->vx = +2.96460137564761618e-03 * PhysicsPerl__Astro__Body__DAYS_PER_YEAR;
    body->vy = +2.37847173959480950e-03 * PhysicsPerl__Astro__Body__DAYS_PER_YEAR;
    body->vz = -2.96589568540237556e-05 * PhysicsPerl__Astro__Body__DAYS_PER_YEAR;
    body->mass = +4.36624404335156298e-05 * PhysicsPerl__Astro__Body__SOLAR_MASS;
    body->radius = +3.64225190291541e-02;
    body->color = {0, 240, 255};
    return body;
}

PhysicsPerl__Astro__Body_ptr PhysicsPerl__Astro__Body__neptune() {
    PhysicsPerl__Astro__Body_ptr body(new PhysicsPerl__Astro__Body);
    body->name = (const string) "Neptune";
    body->x = +1.53796971148509165e+01;
    body->y = -2.59193146099879641e+01;
    body->z = +1.79258772950371181e-01;
    body->vx = +2.68067772490389322e-03 * PhysicsPerl__Astro__Body__DAYS_PER_YEAR;
    body->vy = +1.62824170038242295e-03 * PhysicsPerl__Astro__Body__DAYS_PER_YEAR;
    body->vz = -9.51592254519715870e-05 * PhysicsPerl__Astro__Body__DAYS_PER_YEAR;
    body->mass = +5.15138902046611451e-05 * PhysicsPerl__Astro__Body__SOLAR_MASS;
    body->radius = +3.53597587246876e-02;
    body->color = {55, 85, 230};
    return body;
}

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# endif

#endif
// [[[ HEADER ]]]
using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__PhysicsPerl__Astro__System_cpp
#define __CPP__INCLUDED__PhysicsPerl__Astro__System_cpp 0.006_000

// [[[ INCLUDES ]]]
#include "System.h"

# ifdef __PERL__TYPES

Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ OO METHODS & SUBROUTINES ]]]

void PhysicsPerl__Astro__System::init() {
    integer i;
    this->bodies[0] = PhysicsPerl__Astro__Body__sun();
    this->bodies[1] = PhysicsPerl__Astro__Body__jupiter();
    this->bodies[2] = PhysicsPerl__Astro__Body__saturn();
    this->bodies[3] = PhysicsPerl__Astro__Body__uranus();
    this->bodies[4] = PhysicsPerl__Astro__Body__neptune();
    number px = 0.0;
    number py = 0.0;
    number pz = 0.0;
    for ( i = 0; i < (this->bodies.size()); i++ ) {
        px += this->bodies[i]->vx * this->bodies[i]->mass;
        py += this->bodies[i]->vy * this->bodies[i]->mass;
        pz += this->bodies[i]->vz * this->bodies[i]->mass;
    }
    this->bodies[0]->vx = -1 * (px / PhysicsPerl__Astro__Body__SOLAR_MASS);
    this->bodies[0]->vy = -1 * (py / PhysicsPerl__Astro__Body__SOLAR_MASS);
    this->bodies[0]->vz = -1 * (pz / PhysicsPerl__Astro__Body__SOLAR_MASS);
}

number PhysicsPerl__Astro__System::energy() {
    integer i;
    integer j;
    number dx;
    number dy;
    number dz;
    number distance;
    number e = 0.0;
    for ( i = 0; i < (this->bodies.size()); i++ ) {
        PhysicsPerl__Astro__Body_rawptr body_i = this->bodies[i].get_raw();
        e += 0.5 * body_i->mass * ((body_i->vx * body_i->vx) + (body_i->vy * body_i->vy) + (body_i->vz * body_i->vz));
        for ( j = (i + 1); j < (this->bodies.size()); j++ ) {
            PhysicsPerl__Astro__Body_rawptr body_j = this->bodies[j].get_raw();
            dx = body_i->x - body_j->x;
            dy = body_i->y - body_j->y;
            dz = body_i->z - body_j->z;
            distance = pow(((dx * dx) + (dy * dy) + (dz * dz)), 0.5);
            e -= (body_i->mass * body_j->mass) / distance;
        }
    }
    return e;
}

void PhysicsPerl__Astro__System::advance_loop(const number delta_time, const integer time_step_max) {
    integer i;
    integer j;
    integer time_step;
    const integer bodies_size = this->bodies.size();
    const unsigned_integer bodies_size_triangle = 10;
    number_arrayref dx_array;
    dx_array.resize(bodies_size_triangle);
    number_arrayref dy_array;
    dy_array.resize(bodies_size_triangle);
    number_arrayref dz_array;
    dz_array.resize(bodies_size_triangle);
    number_arrayref magnitude_array;
    magnitude_array.resize(bodies_size_triangle);
    const sse_number_pair delta_time_sse = constant_sse_number_pair__new_from_singleton_duplicate(delta_time);
    sse_number_pair dx;
    sse_number_pair dy;
    sse_number_pair dz;
    sse_number_pair distance_squared;
    sse_number_pair distance;
    sse_number_pair magnitude;
    const sse_number_pair zero_point_five = constant_sse_number_pair__new_from_singleton_duplicate(0.5);
    const sse_number_pair one_point_five = constant_sse_number_pair__new_from_singleton_duplicate(1.5);
    number dx_array_k;
    number dy_array_k;
    number dz_array_k;
    number magnitude_k;
    number body_i_mass_times_magnitude_k;
    number body_j_mass_times_magnitude_k;
    integer i_plus_1;
    integer k;
    PhysicsPerl__Astro__Body_rawptr body_i;
    PhysicsPerl__Astro__Body_rawptr body_j;
    for ( time_step = 0; time_step < time_step_max; time_step++ ) {
        k = 0;
        for ( i = 0; i < bodies_size; i++ ) {
            body_i = this->bodies[i].get_raw();
            for ( j = (i + 1); j < bodies_size; j++ ) {
                body_j = this->bodies[j].get_raw();
                dx_array[k] = body_i->x - body_j->x;
                dy_array[k] = body_i->y - body_j->y;
                dz_array[k] = body_i->z - body_j->z;
                k++;
            }
        }
        for ( i = 0; i < bodies_size_triangle; i += 2 ) {
            i_plus_1 = i + 1;
            dx[0] = dx_array[i];
            dx[1] = dx_array[i_plus_1];
            dy[0] = dy_array[i];
            dy[1] = dy_array[i_plus_1];
            dz[0] = dz_array[i];
            dz[1] = dz_array[i_plus_1];
            distance_squared = (dx sse_mul dx) sse_add (dy sse_mul dy) sse_add (dz sse_mul dz);
            distance = sse_recip_sqrt_32bit_on_64bit(distance_squared);
            distance = distance sse_mul one_point_five sse_sub ((zero_point_five sse_mul distance_squared) sse_mul distance) sse_mul (distance sse_mul distance);
            distance = distance sse_mul one_point_five sse_sub ((zero_point_five sse_mul distance_squared) sse_mul distance) sse_mul (distance sse_mul distance);
            magnitude = (delta_time_sse sse_div distance_squared) sse_mul distance;
            magnitude_array[i] = magnitude[0];
            magnitude_array[i_plus_1] = magnitude[1];
        }
        k = 0;
        for ( i = 0; i < bodies_size; i++ ) {
            body_i = this->bodies[i].get_raw();
            for ( j = (i + 1); j < bodies_size; j++ ) {
                body_j = this->bodies[j].get_raw();
                dx_array_k = dx_array[k];
                dy_array_k = dy_array[k];
                dz_array_k = dz_array[k];
                magnitude_k = magnitude_array[k];
                body_i_mass_times_magnitude_k = body_i->mass * magnitude_k;
                body_j_mass_times_magnitude_k = body_j->mass * magnitude_k;
                body_i->vx -= dx_array_k * body_j_mass_times_magnitude_k;
                body_j->vx += dx_array_k * body_i_mass_times_magnitude_k;
                body_i->vy -= dy_array_k * body_j_mass_times_magnitude_k;
                body_j->vy += dy_array_k * body_i_mass_times_magnitude_k;
                body_i->vz -= dz_array_k * body_j_mass_times_magnitude_k;
                body_j->vz += dz_array_k * body_i_mass_times_magnitude_k;
                k++;
            }
        }
        for ( i = 0; i < bodies_size; i++ ) {
            body_i = this->bodies[i].get_raw();
            body_i->x += delta_time * body_i->vx;
            body_i->y += delta_time * body_i->vy;
            body_i->z += delta_time * body_i->vz;
        }
    }
}

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# endif

#endif
