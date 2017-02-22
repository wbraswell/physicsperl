// [[[ HEADER ]]]
using std::cout;  using std::cerr;  using std::endl;

#ifndef __CPP__INCLUDED__PhysicsPerl__Astro__Body_cpp
#define __CPP__INCLUDED__PhysicsPerl__Astro__Body_cpp 0.006_100

// [[[ INCLUDES ]]]
#include "PhysicsPerl/Astro/Body.h"

# ifdef __PERL__TYPES

Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ SUBROUTINES & OO METHODS ]]]

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

// end of class
