# [[[ HEADER ]]]
use RPerl;
package PhysicsPerl::Energy::Light::Source;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);
use RPerl::CompileUnit::Module::Class;

# [[[ INCLUDES ]]]
use PhysicsPerl::Energy::Light::Source::Ambient;
use PhysicsPerl::Energy::Light::Source::Specular;
use PhysicsPerl::Energy::Light::Source::Diffuse;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    position => my MathPerl::Geometry::Ray3D $TYPED_position = undef,

    # lighting components
    diffuse => my PhysicsPerl::Energy::Light::Source::Diffuse $TYPED_diffuse = undef,
    specular => my PhysicsPerl::Energy::Light::Source::Specular $TYPED_specular = undef,
};

# [[[ SUBROUTINES & OO METHODS ]]]

sub init
{
    { my void::method $RETURN_TYPE };
    ( my object $self) = @ARG;

	# the position needs a direction for Specular, so it's a Ray3D
	$self->{position} = MathPerl::Geometry::Ray3D->new();

	$self->{diffuse} = PhysicsPerl::Energy::Light::Source::Diffuse->new();
	$self->{specular} = PhysicsPerl::Energy::Light::Source::Specular->new();
 
    return;
}

1;    # end of class
