# [[[ HEADER ]]]
use RPerl;
package PhysicsPerl::Energy::Light::Color::Ambient;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(PhysicsPerl::Energy::Light::Color);
use PhysicsPerl::Energy::Light::Color;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    # total intensity
    intensity => my PhysicsPerl::Energy::Light::Color::Composite $TYPED_intensity = undef,

    # reflective coefficients
    reflective => my PhysicsPerl::Energy::Light::Color::Composite $TYPED_reflective = undef,
};

# [[[ SUBROUTINES & OO METHODS ]]]

sub init
{
    { my void::method $RETURN_TYPE };
    ( my object $self) = @ARG;

	$self->{intensity} = PhysicsPerl::Energy::Light::Color::Composite->new();
	$self->{reflective} = PhysicsPerl::Energy::Light::Color::Composite->new();

    return;
}

1;    # end of class
