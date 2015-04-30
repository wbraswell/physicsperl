#!/usr/bin/perl
## no critic qw(ProhibitUselessNoCritic PodSpelling) # DEVELOPER DEFAULT 1a: allow unreachable & POD-commented code, must be on line 1
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils
## no critic qw(ProhibitUnreachableCode RequirePodSections RequirePodAtEnd) # DEVELOPER DEFAULT 1b: allow POD & unreachable or POD-commented code, must be after line 1

=head1 NAME
Energy Subtract
=head1 SYNOPSIS
Baylor University, PHY2360, Exam 3, Problem 5, Subtract Particle Collision Energies From LHC
Assumptions: All Data Points Appear In Both Data Sets, Data Set Sizes Are Much Less Than Available Memory
=head1 LICENSE AND COPYRIGHT
Copyright © 2015, William N. Braswell, Jr.  All Rights Reserved.
This work is Free & Open Source; you can redistribute it and/or modify it under the same terms as Perl 5.20.0.
For licensing details, please see -L<http://dev.perl.org/licenses/>
=head1 AUTHOR
Will the Chill -L<e-mail|william.braswell@autoparallel.com>
=cut

# [[[ USER-EDITABLE INPUT VARIABLES ]]]
my string $input_data1a_file = 'phy2360_exam_3_data1a.txt';
my string $input_data1b_file = 'phy2360_exam_3_data1b.txt';
my string $output_data_file  = 'phy2360_exam_3_data_subtracted.txt';

# [[[ INCLUDES ]]]

# [[[ SUBROUTINES ]]]

# [[[ NON-USER-EDITABLE SYSTEM VARIABLES ]]]
my string $input_data1a_line;
my integer $input_data1a_line_count;
my string_arrayref $input_data1a_line_split;
my string_arrayref $input_data1a_lines = [];
my number $input_data1a_energy;
my string $input_data1b_line;
my integer $input_data1b_line_count;
my string_arrayref $input_data1b_line_split;
my string_arrayref $input_data1b_lines = [];
my number $input_data1b_energy;
my string_arrayref $output_data_lines = [];
my string $extra_tab;

# [[[ OPERATIONS ]]]

# read all input data into memory;
# will not work properly for huge input files
my integer $input_data1a_open_success
    = open my filehandleref $INPUT_DATA1A_FILEHANDLE, '<',
    $input_data1a_file;
if ( not $input_data1a_open_success ) {
    croak 'ERROR: Failed to open file '
        . $input_data1a_file
        . ' for reading, croaking';
}

$input_data1a_line = <$INPUT_DATA1A_FILEHANDLE>;
while ( defined $input_data1a_line ) {
    chomp $input_data1a_line;
    push @{$input_data1a_lines}, $input_data1a_line;
    $input_data1a_line = <$INPUT_DATA1A_FILEHANDLE>;
}

if ( not close $INPUT_DATA1A_FILEHANDLE ) {
    croak 'ERROR: Failed to close file '
        . $input_data1a_file
        . ' after reading, croaking';
}

my integer $input_data1b_open_success
    = open my filehandleref $INPUT_DATA1B_FILEHANDLE, '<',
    $input_data1b_file;
if ( not $input_data1b_open_success ) {
    croak 'ERROR: Failed to open file '
        . $input_data1b_file
        . ' for reading, croaking';
}

$input_data1b_line = <$INPUT_DATA1B_FILEHANDLE>;
while ( defined $input_data1b_line ) {
    chomp $input_data1b_line;
    push @{$input_data1b_lines}, $input_data1b_line;
    $input_data1b_line = <$INPUT_DATA1B_FILEHANDLE>;
}

if ( not close $INPUT_DATA1B_FILEHANDLE ) {
    croak 'ERROR: Failed to close file '
        . $input_data1b_file
        . ' after reading, croaking';
}

$input_data1a_line_count = scalar @{$input_data1a_lines};
$input_data1b_line_count = scalar @{$input_data1b_lines};
#print '$input_data1a_line_count = ' . $input_data1a_line_count . "\n";
#print '$input_data1b_line_count = ' . $input_data1b_line_count . "\n";

if ( $input_data1a_line_count != $input_data1b_line_count ) {
    croak 'ERROR: Input file line counts do not match, '
        . $input_data1a_line_count . ' vs '
        . $input_data1b_line_count
        . ', croaking';
}

#print '$input_data1a_lines = ' . Dumper($input_data1a_lines) . "\n";
#print '$input_data1b_lines = ' . Dumper($input_data1b_lines) . "\n";

# sort both data sets, just to be on the safe side
$input_data1a_lines = [ sort @{$input_data1a_lines} ];
$input_data1b_lines = [ sort @{$input_data1b_lines} ];

#print 'sorted $input_data1a_lines = ' . Dumper($input_data1a_lines) . "\n";
#print 'sorted $input_data1b_lines = ' . Dumper($input_data1b_lines) . "\n";

for my integer $i ( 0 .. ( $input_data1a_line_count - 1 ) ) {
#    print 'top of for() loop, $i = ' . $i . "\n";

    # isolate 4 numeric components of each data set line
    $input_data1a_line       = $input_data1a_lines->[$i];
    $input_data1a_line_split = [ split ' ', $input_data1a_line ];
    $input_data1b_line       = $input_data1b_lines->[$i];
    $input_data1b_line_split = [ split ' ', $input_data1b_line ];
#    print '$input_data1a_line_split = ' . Dumper($input_data1a_line_split) . "\n";
#    print '$input_data1b_line_split = ' . Dumper($input_data1b_line_split) . "\n";

    # compare data set lines and store subtracted energies in output data;
    # will not work properly for mismatched data sets
    if ( $input_data1a_line_split->[0] ne $input_data1b_line_split->[0] ) {
        croak 'ERROR: Input files line '
            . $i
            . ', collision numbers do not match, '
            . $input_data1a_line_split->[0] . ' vs '
            . $input_data1b_line_split->[0]
            . ', croaking';
    }
    if ( $input_data1a_line_split->[1] ne $input_data1b_line_split->[1] ) {
        croak 'ERROR: Input files line '
            . $i
            . ', detector x-coordinates do not match, '
            . $input_data1a_line_split->[1] . ' vs '
            . $input_data1b_line_split->[1]
            . ', croaking';
    }
    if ( $input_data1a_line_split->[2] ne $input_data1b_line_split->[2] ) {
        croak 'ERROR: Input files line '
            . $i
            . ', detector y-coordinates do not match, '
            . $input_data1a_line_split->[2] . ' vs '
            . $input_data1b_line_split->[2]
            . ', croaking';
    }

    $input_data1a_energy = string_to_number( $input_data1a_line_split->[3] );
    $input_data1b_energy = string_to_number( $input_data1b_line_split->[3] );

    if (   ( not defined $input_data1a_energy )
        or ( $input_data1a_energy <= 0 ) )
    {
        croak 'ERROR: Input energy undefined or invalid, line number '
            . ( $i + 1 )
            . ', file '
            . $input_data1a_file
            . ', croaking';
    }

    if (   ( not defined $input_data1b_energy )
        or ( $input_data1b_energy <= 0 ) )
    {
        croak 'ERROR: Input energy undefined or invalid, line number '
            . ( $i + 1 )
            . ', file '
            . $input_data1b_file
            . ', croaking';
    }

    if ((length $input_data1a_line_split->[0]) < 8) {
        $extra_tab = "\t";
    }
    else {
        $extra_tab = q{};
    }

    $output_data_lines->[$i]
        = $input_data1a_line_split->[0] . "\t" . $extra_tab
        . $input_data1a_line_split->[1] . "\t"
        . $input_data1a_line_split->[2] . "\t"
        . number_to_string( $input_data1a_energy - $input_data1b_energy )
        . "\n";
}

# save output data
my integer $output_data_open_success
    = open my filehandleref $OUTPUT_DATA_FILEHANDLE, '>', $output_data_file;
if ( not $output_data_open_success ) {
    croak 'ERROR: Failed to open file '
        . $output_data_file
        . ' for writing, croaking';
}

foreach my string $output_data_line ( @{$output_data_lines} ) {
    my integer $output_data_print_success
        = ( print {$OUTPUT_DATA_FILEHANDLE} $output_data_line );
    if ( not $output_data_print_success ) {
        croak 'ERROR: Failed to write to file '
            . $output_data_file
            . ', croaking';
    }
}

if ( not close $OUTPUT_DATA_FILEHANDLE ) {
    croak 'ERROR: Failed to close file '
        . $output_data_file
        . ' after writing, croaking';
}
