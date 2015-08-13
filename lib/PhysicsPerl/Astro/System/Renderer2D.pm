# [[[ HEADER ]]]
use RPerl;
package PhysicsPerl::Astro::System::Renderer2D;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);    # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use PhysicsPerl::Astro::System;
use SDL;
#use SDL::Event;
use SDL::Video;
use SDLx::App;
#use SDLx::Sprite;
use SDLx::Text;


# [[[ OO PROPERTIES ]]]
our hashref $properties = { 
    system => my PhysicsPerl::Astro::System $TYPED_system = undef,
    body_renderer2d => my PhysicsPerl::Astro::Body::Renderer2D $TYPED_body_renderer2d = undef,
    window_title => my string $TYPED_window_title = undef,
    window_width => my integer $TYPED_window_width = undef,
    window_height => my integer $TYPED_window_height = undef,
    app => my SDLx::App $TYPED_app = undef
};

# [[[ OO METHODS & SUBROUTINES ]]]

our void::method $init = sub {
    ( my PhysicsPerl::Astro::System::Renderer2D $self ) = @_;
    $self->{body_renderer2d} => PhysicsPerl::Astro::Body::Renderer2D->new();  # one body renderer used for all bodies in system
    $self->{window_title} = 'N-Body Solar System Simulator';
    $self->{window_width} = 640;
    $self->{window_height} = 480;

    SDL::init(SDL_INIT_VIDEO);

    $self->{app} = SDLx::App->new(
        title => $self->{window_title},
        width => $self->{window_width},
        height => $self->{window_height},
        delay => 15
    );
};

our void::method $show = sub {
    ( my PhysicsPerl::Astro::System::Renderer2D $self, my number $dt, my SDLx::App $app ) = @_;
    SDL::Video::fill_rect( $app, SDL::Rect->new(0, 0, $app->w(), $app->h()), 0 );

    foreach my PhysicsPerl::Astro::Body $body (@{$self->{system}->{bodies}}) {
        $self->{body_renderer2d}->{body} = $body;
        $self->{body_renderer2d}->draw($app);
    }

    SDLx::Text->new(
        color   => [255, 255, 255],
        text    => 'Step FOO of BAR',
        x       => 10,
        y       => 10,
    )->write_to($app);

    $app->update();
};

our void::method $render2d = sub {
    ( my PhysicsPerl::Astro::System::Renderer2D $self ) = @_;

#    $self->{app}->add_event_handler( sub { $self->events(@_) } );
    $self->{app}->add_show_handler( sub { $self->show(@_) } );
#    $self->{app}->add_move_handler( sub { $self->move(@_) } );

#    $self->{app}->fullscreen();
    $self->{app}->run();
};

1;    # end of class
