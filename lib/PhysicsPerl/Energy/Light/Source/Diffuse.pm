# [[[ HEADER ]]]
use RPerl;
package PhysicsPerl::Energy::Light::Source::Diffuse;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(PhysicsPerl::Energy::Light::Source);
use PhysicsPerl::Energy::Light::Source;

# [[[ INCLUDES ]]]
use PhysicsPerl::Energy::Light::Color::Composite;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {
    intensity => my PhysicsPerl::Energy::Light::Color::Composite $TYPED_intensity = undef,
};

# [[[ SUBROUTINES & OO METHODS ]]]

sub init
{
    { my void::method $RETURN_TYPE };
    ( my object $self) = @ARG;
    
    $self->{intensity} = PhysicsPerl::Energy::Light::Color::Composite->new();
 
    return;
}

1;    # end of class