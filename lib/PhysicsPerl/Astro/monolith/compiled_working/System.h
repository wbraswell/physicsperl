// [[[ HEADER ]]]
using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__PhysicsPerl__Astro__Body_h
#define __CPP__INCLUDED__PhysicsPerl__Astro__Body_h 0.006_000

// [[[ INCLUDES & OO INHERITANCE INCLUDES ]]]
#include <RPerl.cpp>  // -> RPerl.h -> (rperltypes_mode.h; rperltypes.h; HelperFunctions.cpp)
#include <RPerl/CompileUnit/Module/Class.cpp>

# ifdef __PERL__TYPES

Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ CONSTANTS ]]]
const number PhysicsPerl__Astro__Body__SOLAR_MASS = 39.4784176043574;
const number PhysicsPerl__Astro__Body__DAYS_PER_YEAR = 365.24;

// [[[ OO INHERITANCE ]]]
class PhysicsPerl__Astro__Body : public RPerl__CompileUnit__Module__Class__CPP {
public:
    // [[[ OO PROPERTIES ]]]
    string name;
    number x;
    number y;
    number z;
    number vx;
    number vy;
    number vz;
    number mass;
    number radius;
    integer_arrayref color;

    // [[[ OO METHODS ]]]

    // <<< OO PROPERTIES, ACCESSORS & MUTATORS >>>
    string get_name() { return this->name; }
    void set_name(string name_new) { this->name = name_new; }
    number get_x() { return this->x; }
    void set_x(number x_new) { this->x = x_new; }
    number get_y() { return this->y; }
    void set_y(number y_new) { this->y = y_new; }
    number get_z() { return this->z; }
    void set_z(number z_new) { this->z = z_new; }
    number get_vx() { return this->vx; }
    void set_vx(number vx_new) { this->vx = vx_new; }
    number get_vy() { return this->vy; }
    void set_vy(number vy_new) { this->vy = vy_new; }
    number get_vz() { return this->vz; }
    void set_vz(number vz_new) { this->vz = vz_new; }
    number get_mass() { return this->mass; }
    void set_mass(number mass_new) { this->mass = mass_new; }
    number get_radius() { return this->radius; }
    void set_radius(number radius_new) { this->radius = radius_new; }
    integer_arrayref get_color() { return this->color; }
    void set_color(integer_arrayref color_new) { this->color = color_new; }

    // <<< CONSTRUCTOR & DESTRUCTOR >>>
    PhysicsPerl__Astro__Body() {}
    ~PhysicsPerl__Astro__Body() {}

    // <<< CLASS NAME REPORTER >>>
    virtual string myclassname() { return (const string) "PhysicsPerl::Astro::Body"; }
};  // end of class

// [[[ OO SUBCLASSES ]]]
#define PhysicsPerl__Astro__Body_rawptr PhysicsPerl__Astro__Body*
typedef std::unique_ptr<PhysicsPerl__Astro__Body> PhysicsPerl__Astro__Body_ptr;
typedef std::vector<PhysicsPerl__Astro__Body_ptr> PhysicsPerl__Astro__Body_arrayref;
typedef std::unordered_map<string, PhysicsPerl__Astro__Body_ptr> PhysicsPerl__Astro__Body_hashref;
typedef std::unordered_map<string, PhysicsPerl__Astro__Body_ptr>::iterator PhysicsPerl__Astro__Body_hashref_iterator;

// [[[ SUBROUTINES ]]]
PhysicsPerl__Astro__Body_ptr PhysicsPerl__Astro__Body__sun();
PhysicsPerl__Astro__Body_ptr PhysicsPerl__Astro__Body__jupiter();
PhysicsPerl__Astro__Body_ptr PhysicsPerl__Astro__Body__saturn();
PhysicsPerl__Astro__Body_ptr PhysicsPerl__Astro__Body__uranus();
PhysicsPerl__Astro__Body_ptr PhysicsPerl__Astro__Body__neptune();

// <<< OPERATIONS & DATA TYPES REPORTER >>>
integer PhysicsPerl__Astro__Body__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# endif

#endif
// [[[ HEADER ]]]
using std::cout;  using std::cerr;

#ifndef __CPP__INCLUDED__PhysicsPerl__Astro__System_h
#define __CPP__INCLUDED__PhysicsPerl__Astro__System_h 0.006_000

// [[[ INCLUDES & OO INHERITANCE INCLUDES ]]]
#include <RPerl.cpp>  // -> RPerl.h -> (rperltypes_mode.h; rperltypes.h; HelperFunctions.cpp)
#include <RPerl/CompileUnit/Module/Class.cpp>

# ifdef __PERL__TYPES

Purposefully_die_from_a_compile-time_error,_due_to____PERL__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# elif defined __CPP__TYPES

// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]
// [[[<<< BEGIN CPP TYPES >>>]]]

// [[[ OO INHERITANCE ]]]
class PhysicsPerl__Astro__System : public RPerl__CompileUnit__Module__Class__CPP {
public:
    // [[[ OO PROPERTIES ]]]
    PhysicsPerl__Astro__Body_arrayref bodies;

    // [[[ OO METHODS ]]]

    // <<< OO PROPERTIES, ACCESSORS & MUTATORS >>>
    integer get_bodies_size() { return this->bodies.size(); }  // call from Perl or C++
    PhysicsPerl__Astro__Body_ptr& get_bodies_element(integer i) { return this->bodies[i]; }  // call from C++
    void get_bodies_element_indirect(integer i, PhysicsPerl__Astro__Body_rawptr bodies_element_rawptr) { *bodies_element_rawptr = *(this->bodies[i].get_raw()); }  // call from Perl shim
    void set_bodies_element(integer i, PhysicsPerl__Astro__Body_ptr& bodies_element_ptr) { *(this->bodies[i].get_raw()) = *(bodies_element_ptr.get_raw()); }  // call from C++
    void set_bodies_element(integer i, PhysicsPerl__Astro__Body_rawptr bodies_element_rawptr) { *(this->bodies[i].get_raw()) = *bodies_element_rawptr; }  // call from Perl

    // <<< CONSTRUCTOR & DESTRUCTOR >>>
    PhysicsPerl__Astro__System() {
        this->bodies.resize(5);
    }
    ~PhysicsPerl__Astro__System() {}

    // <<< CLASS NAME REPORTER >>>
    virtual string myclassname() { return (const string) "PhysicsPerl::Astro::System"; }

    // <<< USER-DEFINED METHODS >>>
    void init();
    number energy();
    void advance_loop(const number delta_time, const integer time_step_max);
};  // end of class

// [[[ OO SUBCLASSES ]]]
#define PhysicsPerl__Astro__System_rawptr PhysicsPerl__Astro__System*
typedef std::unique_ptr<PhysicsPerl__Astro__System> PhysicsPerl__Astro__System_ptr;
typedef std::vector<PhysicsPerl__Astro__System_ptr> PhysicsPerl__Astro__System_arrayref;
typedef std::unordered_map<string, PhysicsPerl__Astro__System_ptr> PhysicsPerl__Astro__System_hashref;
typedef std::unordered_map<string, PhysicsPerl__Astro__System_ptr>::iterator PhysicsPerl__Astro__System_hashref_iterator;

// <<< OPERATIONS & DATA TYPES REPORTER >>>
integer PhysicsPerl__Astro__System__MODE_ID() { return 2; }  // CPPOPS_CPPTYPES is 2

// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]
// [[[<<< END CPP TYPES >>>]]]

# else

Purposefully_die_from_a_compile-time_error,_due_to_neither___PERL__TYPES_nor___CPP__TYPES_being_defined.__We_need_to_define_only___CPP__TYPES_in_this_file!

# endif

#endif
