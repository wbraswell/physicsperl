# [[[ HEADER ]]]
use RPerl;
package PhysicsPerl::Energy::Light::Color;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ INCLUDES ]]]
use PhysicsPerl::Energy::Light::Color::Composite;
use PhysicsPerl::Energy::Light::Color::Emissive;
use PhysicsPerl::Energy::Light::Color::Ambient;
use PhysicsPerl::Energy::Light::Color::Specular;
use PhysicsPerl::Energy::Light::Color::Diffuse;
##use Imager;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {

    # START HERE: fill in data types, continue converting this file
    # START HERE: fill in data types, continue converting this file
    # START HERE: fill in data types, continue converting this file

    # total, final, composite color output
    total => undef,

    # entity's lighting-independant emissive color
    emissive => undef,

    # actual lighting-dependant color components
    ambient => undef,
    diffuse => undef,
    specular => undef,

    # coeffs for shading
    lambert => undef,
    phong => undef,

    # Imager::Color object
    imager => undef,
};

sub init
{
    my $self = shift;

    $self->{total} = PhysicsPerl::Energy::Light::Color::Composite->new();

    $self->{emissive} = PhysicsPerl::Energy::Light::Color::Emissive->new();

    $self->{ambient} = PhysicsPerl::Energy::Light::Color::Ambient->new();
    $self->{diffuse} = PhysicsPerl::Energy::Light::Color::Diffuse->new();
    $self->{specular} = PhysicsPerl::Energy::Light::Color::Specular->new();

    # make sure to pass defaults to Imager::Color->new() to avoid errors!
##    $self->{imager} = Imager::Color->new(0, 0, 0);

##    $self->debugger->set("debug_file", "/tmp/FOO/debug/PhysicsPerl_Energy_Light_Color.txt");
}


# add Ambient component of lighting
sub add_ambient
{
    my $self = shift;

    my $ambient_source = shift;

    $self->ambient->intensity->{red} = $ambient_source->intensity->{red} * $self->ambient->reflective->{red};
    $self->ambient->intensity->{green} = $ambient_source->intensity->{green} * $self->ambient->reflective->{green};
    $self->ambient->intensity->{blue} = $ambient_source->intensity->{blue} * $self->ambient->reflective->{blue};
}


# add Diffuse and Specular components of (another) light source
sub add_diffuse_specular
{
    my $self = shift;

    my $light_source = shift;
    my $entity = shift;
    my $in_ray = shift;


##$self->debug("in Color->add_diffuse_specular(), have \$light_source = " . Dumper($light_source) . "\n");
##$self->debug("in Color->add_diffuse_specular(), have \$entity = " . Dumper($entity) . "\n");
    my $light_vector = PhysicsPerl::Concept::Math::Variable::Vector::Vector3->new();
    my $camera_vector = PhysicsPerl::Concept::Math::Variable::Vector::Vector3->new();
    my $halfway_vector = PhysicsPerl::Concept::Math::Variable::Vector::Vector3->new();

    # the light vector points from the hit point to the light source
    $light_vector->set_triplet_chunk($light_source->position->{origin});
    $light_vector->subtract($entity->{intersections}[$entity->{soonest_hit}]->{point});
    $light_vector->find_magnitude();
##$self->debug("in Color->add_diffuse_specular(), setting \$light_vector = " . Dumper($light_vector) . "\n");

    # the camera vector points from the hit point to the camera's eye
    $camera_vector->set_triplet_chunk($in_ray->{direction});
    $camera_vector->scalar_product(-1);
    $camera_vector->find_magnitude();
##$self->debug("in Color->add_diffuse_specular(), setting \$camera_vector = " . Dumper($camera_vector) . "\n");

    # the halfway vector is the light vector plus the camera vector
    $halfway_vector->set_triplet_chunk($light_vector);
    $halfway_vector->add($camera_vector);
    $halfway_vector->find_magnitude();
##$self->debug("in Color->add_diffuse_specular(), setting \$halfway_vector = " . Dumper($halfway_vector) . "\n");

    # grab normal vector's value
    my $normal_vector = $entity->{intersections}[$entity->{soonest_hit}]->{normal};
    $normal_vector->find_magnitude();
##$self->debug("in Color->add_diffuse_specular(), setting \$normal_vector = " . Dumper($normal_vector) . "\n");

    # compute lambert and phong factors
    my $lambert = 0;
    my $magnitude_product = $light_vector->{magnitude} * $normal_vector->{magnitude};
    if ($magnitude_product != 0)
    {
        $lambert = $light_vector->dot($normal_vector) / $magnitude_product;
        $lambert = 0 if ($lambert < 0);
    }

    my $phong = 0;
    $magnitude_product = $halfway_vector->{magnitude} * $normal_vector->{magnitude};
    if ($magnitude_product != 0)
    {
        $phong = $halfway_vector->dot($normal_vector) / $magnitude_product;
        $phong = 0 if ($phong < 0);
    }
    
    # compute diffuse component
    $self->diffuse->intensity->{red} = $light_source->diffuse->intensity->{red} * $self->diffuse->reflective->{red} * $lambert;
    $self->diffuse->intensity->{green} = $light_source->diffuse->intensity->{green} * $self->diffuse->reflective->{green} * $lambert;
    $self->diffuse->intensity->{blue} = $light_source->diffuse->intensity->{blue} * $self->diffuse->reflective->{blue} * $lambert;

    # compute specular component
    $self->specular->intensity->{red} = $light_source->specular->intensity->{red} * $self->specular->reflective->{red} * $phong**$self->specular->{exponent};
    $self->specular->intensity->{green} = $light_source->specular->intensity->{green} * $self->specular->reflective->{green} * $phong**$self->specular->{exponent};
    $self->specular->intensity->{blue} = $light_source->specular->intensity->{blue} * $self->specular->reflective->{blue} * $phong**$self->specular->{exponent};
}


sub determine_total_composite
{
    my $self = shift;

    $self->total->{red} =     $self->emissive->intensity->{red} + 
                $self->ambient->intensity->{red} + 
                $self->diffuse->intensity->{red} +
                $self->specular->intensity->{red};

    $self->total->{green} =    $self->emissive->intensity->{green} + 
                $self->ambient->intensity->{green} + 
                $self->diffuse->intensity->{green} +
                $self->specular->intensity->{green};

    $self->total->{blue} =     $self->emissive->intensity->{blue} + 
                $self->ambient->intensity->{blue} + 
                $self->diffuse->intensity->{blue} +
                $self->specular->intensity->{blue};

##$self->debug("in Color->determine_total_composite(), have \$self->{total} = " . Dumper($self->{total}) . "\n");
}


sub compose
{
    my $self = shift;

    # scale final colors up by 255
    my $scaled_red = $self->total->{red} * 255;
    $scaled_red = 255 if ($scaled_red > 255);
    my $scaled_green = $self->total->{green} * 255;
    $scaled_green = 255 if ($scaled_green > 255);
    my $scaled_blue = $self->total->{blue} * 255;
    $scaled_blue = 255 if ($scaled_blue > 255);

    # send composite color to Imager object
##    $self->imager->set($scaled_red, $scaled_green, $scaled_blue);
}

1;    # end of class
