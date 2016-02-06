use strict;
use warnings;
our $VERSION = 0.001_200;
use ExtUtils::MakeMaker;

BEGIN { use English; }

push( @ExtUtils::MakeMaker::Overridable, qw(pm_to_blib) )
    if ( $OSNAME eq 'MSWin32' );

WriteMakefile(
    NAME             => 'PhysicsPerl',
    ABSTRACT         => 'Physics Perl, The Optimized Physics Library Suite',
    AUTHOR           => ['Will Braswell <wbraswell@cpan.org>'],
    VERSION_FROM     => 'lib/PhysicsPerl.pm',
    LICENSE          => 'perl_5',
    EXE_FILES        => [ 'script/physicsperl', 'script/demo/n_body.pl' ],
    MIN_PERL_VERSION => '5.10.0',                                                      # NEED ANSWER: is RPerl truly incompatible with Perl v5.8 and earlier?
    PREREQ_PM        => {
        'ExtUtils::MakeMaker' => 7.04,     # for compatibility with Inline::C >= v0.75
        'CPAN::Meta'          => 2.150005, # RPerl system developers only, used for generating CPAN metadata from this file during dist build
        'Test::Exception'     => 0.32,
        'Test::CPAN::Changes' => 0.400002,
        'Test::Number::Delta' => 1.06,     # for compatibility with Perls compiled using -Duselongdouble
        'RPerl' => 1.5,
        'Time::HiRes' => 1.9726,
        'SDL'         => 2.546
    },
    META_MERGE => {
        'meta-spec' => {
            version => 2,
            url     => 'https://metacpan.org/pod/CPAN::Meta::Spec'
        },

        release_status => 'stable',
        keywords       => [qw(physicsperl physics rperl optimize compile)],
        description    => 'PhysicsPerl is a collection of physics software written using the RPerl optimizing compiler.',
        resources      => {
            license    => ['http://dev.perl.org/licenses/'],
            homepage   => 'http://www.rperl.org',
            bugtracker => { web => 'http://rt.cpan.org/Public/Dist/Display.html?Name=PhysicsPerl' },
            repository => {
                type => 'git',
                url  => 'git://github.com/wbraswell/physicsperl.git',
                web  => 'https://github.com/wbraswell/physicsperl'
            }
        }
    },

    # NEED UPDATE, CORRELATION #pp00: list of _Inline directories to delete/exclude in Makefile.PL, .gitignore, and MANIFEST.SKIP
    # NEED UPDATE, CORRELATION #pp01: list of CPAN files & directories to delete/exclude in Makefile.PL, .gitignore, and MANIFEST.SKIP
    # NEED UPDATE, CORRELATION #pp02: list of RPerl build files & directories to delete/exclude in Makefile.PL, .gitignore, and MANIFEST.SKIP
    clean => {
        FILES =>
            'Makefile.old MANIFEST.bak lib/PhysicsPerl/Astro/Body.pmc lib/PhysicsPerl/Astro/Body.h lib/PhysicsPerl/Astro/Body.cpp lib/PhysicsPerl/Astro/System.pmc lib/PhysicsPerl/Astro/System.h lib/PhysicsPerl/Astro/System.cpp _Inline lib/_Inline script/_Inline t/_Inline'
    }
);

package MY;
BEGIN { use English; }

sub pm_to_blib {
    my $self = shift;
    my $blib = $self->SUPER::pm_to_blib(@_);

    # un-read-only blib/lib for tests to pass, files are modified at runtime there
    if ( $OSNAME eq 'MSWin32' ) {
        my ( $lastline, $start ) = qq{\t\$(NOECHO) \$(TOUCH) pm_to_blib\n};
        ( $start = index( $blib, $lastline ) ) == -1
            && die "Can't find replacement string for pm_to_blib target";
        substr( $blib, $start, 0, "\t" . 'attrib -R /S  blib/lib/*' . "\n" );
    }
    return $blib;
}
