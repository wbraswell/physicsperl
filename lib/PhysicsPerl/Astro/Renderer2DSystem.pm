# [[[ HEADER ]]]
package PhysicsPerl::Astro::Renderer2DSystem;
use strict;
use warnings;
use RPerl::AfterSubclass;
our $VERSION = 0.002_000;

# [[[ OO INHERITANCE ]]]
use parent qw(RPerl::CompileUnit::Module::Class);    # no non-system inheritance, only inherit from base class
use RPerl::CompileUnit::Module::Class;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls) # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ INCLUDES ]]]
use PhysicsPerl::Astro::System;
use PhysicsPerl::Astro::Body;
use PhysicsPerl::Astro::Renderer2DBody;
use Time::HiRes qw(time);
use SDL;
use SDL::Event;
use SDL::Video;
use SDLx::App;
#use SDLx::Sprite;
use SDLx::Text;

# [[[ OO PROPERTIES ]]]
our hashref $properties = { 
    my_system => my PhysicsPerl::Astro::System $TYPED_system = undef,
    delta_time => my number $TYPED_delta_time = undef,
    time_step_max => my integer $TYPED_time_step_max = undef,
    time_step_current => my integer $TYPED_time_step_current = undef,
    time_steps_per_frame => my integer $TYPED_time_steps_per_frame = undef,
    time_start => my number $TYPED_time_start = undef,
    window_title => my string $TYPED_window_title = undef,
    window_width => my integer $TYPED_window_width = undef,
    window_height => my integer $TYPED_window_height = undef,
    zoom => my number $TYPED_zoom = undef,
    body_renderer2d => my PhysicsPerl::Astro::Renderer2DBody $TYPED_body_renderer2d = undef,
    app => my SDLx::App $TYPED_app = undef
};

# [[[ OO METHODS & SUBROUTINES ]]]

our void::method $init = sub {
    ( my PhysicsPerl::Astro::Renderer2DSystem $self, my PhysicsPerl::Astro::System $system, my number $delta_time, my integer $time_step_max, my integer $time_steps_per_frame, my number $time_start ) = @_;

    $self->{my_system} = $system;
    $self->{delta_time} = $delta_time;
    $self->{time_step_max} = $time_step_max;
    $self->{time_step_current} = 0;
    $self->{time_steps_per_frame} = $time_steps_per_frame;
    $self->{time_start} = $time_start;

    # NEED FIX: remove hard-coded window size
    $self->{window_title} = 'N-Body Solar System Simulator';
    $self->{window_width} = 640;
    $self->{window_height} = 480;
#    $self->{window_width} = 1440;
#    $self->{window_height} = 900;
    $self->{zoom} = 6;
    $self->{body_renderer2d} = PhysicsPerl::Astro::Renderer2DBody->new();  # one body renderer used for all bodies in system
    $self->{body_renderer2d}->{x_offset} = $self->{window_width} / 2;  # offset coordinates so (0,0) maps to center of window, not upper-left corner
    $self->{body_renderer2d}->{y_offset} = $self->{window_height} / 2;
    $self->{body_renderer2d}->{zoom} = $self->{zoom};

    SDL::init(SDL_INIT_VIDEO);

    $self->{app} = SDLx::App->new(
        title => $self->{window_title},
        width => $self->{window_width},
        height => $self->{window_height},
        delay => 15
    );
};

our void::method $events = sub {
    ( my PhysicsPerl::Astro::Renderer2DSystem $self, my SDL::Event $event, my SDLx::App $app ) = @_;
    if ($event->type() == SDL_QUIT) { $app->stop(); }
};

our void::method $show = sub {
    ( my PhysicsPerl::Astro::Renderer2DSystem $self, my number $dt, my SDLx::App $app ) = @_;
    SDL::Video::fill_rect( $app, SDL::Rect->new(0, 0, $app->w(), $app->h()), 0 );

    # NEED FIX: remove hard-coded $bodies size
#    foreach my PhysicsPerl::Astro::Body $body (@{$self->{my_system}->{bodies}}) {
    for my integer $i (0 .. 4) {
        # DEV NOTE: C++ get_i_body() returns void, Perl get_i_body() returns object
        my PhysicsPerl::Astro::Body $pre_body = PhysicsPerl::Astro::Body->new();
        my PhysicsPerl::Astro::Body $tmp_body = undef;
        $tmp_body = $self->{my_system}->get_i_body($pre_body, $i);
        if (defined $tmp_body) { $pre_body = $tmp_body; }
        $self->{body_renderer2d}->{body} = $pre_body;
        $self->{body_renderer2d}->draw($app);
    }
    
    my string $status = q{};
    my string $status_tmp;
    $status .= 'Time, Step: ' . ::number_to_string($self->{time_step_current}) . ' of ' . ::number_to_string($self->{time_step_max}) . "\n";
    $status_tmp = ::number_to_string($self->{delta_time} * $self->{time_step_current});
    $status_tmp =~ s/[.].*//xms;  # sim time, 0 characters after decimal
    $status .= 'Time, Sim:  ' . $status_tmp . ' of ' . ::number_to_string($self->{delta_time} * $self->{time_step_max}) . "\n";
    my number $time_elapsed = time() - $self->{time_start};
    $status_tmp = ::number_to_string($time_elapsed);
    $status_tmp =~ s/([.].{1}).*/$1/xms;  # real time elapsed, 1 character after decimal
    $status .= 'Time, Real: ' . $status_tmp;
    $status_tmp = ::number_to_string($time_elapsed * ($self->{time_step_max} / $self->{time_step_current}));
    $status_tmp =~ s/([.].{1}).*/$1/xms;  # real time total estimate, 1 character after decimal
    $status .= ' of ' . $status_tmp . "\n";
    $status_tmp =  ($self->{time_step_current} / $self->{time_step_max}) * 100;
    $status_tmp =~ s/[.].*//xms;  # sim time, 0 characters after decimal
    $status .= 'Completion: ' . $status_tmp . '%';
    $status_tmp = ::number_to_string($self->{time_step_current} / $time_elapsed);
    $status_tmp =~ s/[.].*//xms;  # steps per real time, 0 characters after decimal
    $status .= ' at ' . $status_tmp . ' Steps / Second' . "\n";
    $status_tmp = ::number_to_string($self->{my_system}->energy());
    $status_tmp =~ s/([.].{11}).*/$1/xms;  # energy, 11 characters after decimal
    $status .= 'Energy:     ' . $status_tmp . "\n";

    # NEED FIX: remove hard-coded font path
    SDLx::Text->new(
        font    => '/home/wbraswell/school/physicsperl/physicsperl-latest/fonts/VeraMono.ttf',
        size    => 15,
        color   => [255, 255, 255],
        text    => $status,
        x       => 10,
        y       => 10,
    )->write_to($app);

    $app->update();
};

our void::method $move = sub {
    ( my PhysicsPerl::Astro::Renderer2DSystem $self, my number $dt, my SDLx::App $app, my number $t ) = @_;
    # don't overshoot your time_step_max
    if (($self->{time_step_current} + $self->{time_steps_per_frame}) > $self->{time_step_max}) {
        $self->{time_steps_per_frame} = $self->{time_step_max} - $self->{time_step_current};
    }
    $self->{my_system}->advance_loop($self->{delta_time}, $self->{time_steps_per_frame});
    $self->{time_step_current} += $self->{time_steps_per_frame};
    if ($self->{time_step_current} >= $self->{time_step_max}) { $app->stop(); }
};

our void::method $render2d_video = sub {
    ( my PhysicsPerl::Astro::Renderer2DSystem $self ) = @_;

    $self->{app}->add_event_handler( sub { $self->events(@_) } );
    $self->{app}->add_show_handler( sub { $self->show(@_) } );
    $self->{app}->add_move_handler( sub { $self->move(@_) } );

#    $self->{app}->fullscreen();
    $self->{app}->run();
};

1;    # end of class
