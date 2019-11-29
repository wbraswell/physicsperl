# [[[ HEADER ]]]
use RPerl;
package PhysicsPerl::Energy::Light::Color::Composite;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(PhysicsPerl::Energy::Light::Color);
use PhysicsPerl::Energy::Light::Color;

# [[[ OO PROPERTIES ]]]
our hashref $properties = {

    # START HERE: should these types be number or integer???  also change in set_composite() below; combine Color::RGB & Color::Composite???
    # START HERE: should these types be number or integer???  also change in set_composite() below; combine Color::RGB & Color::Composite???
    # START HERE: should these types be number or integer???  also change in set_composite() below; combine Color::RGB & Color::Composite???

    red => my number $TYPED_red = undef,
    green => my number $TYPED_green = undef,
    blue => my number $TYPED_blue = undef,
};

# [[[ SUBROUTINES & OO METHODS ]]]

sub init
{
    { my void::method $RETURN_TYPE };
    ( my object $self) = @ARG;

    # default to black
    $self->{red} = 0;
    $self->{green} = 0;
    $self->{blue} = 0;

    return;
}

sub set_composite
{
    { my void::method $RETURN_TYPE };
    ( my object $self, my number $red, my number $green, my number $blue) = @ARG;

	$self->{red} = $red;
	$self->{green} = $green;
	$self->{blue} = $blue;
}

1;    # end of class