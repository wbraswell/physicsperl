#!/usr/bin/perl

# Copyright © 2015, William N. Braswell, Jr.. All Rights Reserved.
# This work is Free & Open Source; you can redistribute it and/or modify it under the same terms as Perl 5.20.0.
# For licensing details, please see http://dev.perl.org/licenses/

# This software takes as input the output of diff (or bdiff) run on a CERN data file, then splits into 3 output files.

# [[[ HEADER ]]]
use strict;
use warnings;
#use RPerl;  # disable RPerl for now, although this file is still very close to proper RPerl syntax
use Carp;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator

use IO::Handle;
use Tie::File;

# [[[ OPERATIONS ]]]

# NEED UPGRADE: insert `bdiff` call here

my $bdiff_file = 'cern_53_vs_pre9.diff';
my $output_file_1 = 'cern_53_unique.txt';
my $output_file_2 = 'cern_pre9_unique.txt';
my $output_file_3 = 'cern_53_pre9_different.txt';
my @bdiff_array;
tie @bdiff_array, 'Tie::File', $bdiff_file or die 'Failed to tie file, dying';
our $OUTPUT_FILEHANDLE_1;
our $OUTPUT_FILEHANDLE_2;
our $OUTPUT_FILEHANDLE_3;
our $open_success;
our $print_success;

open_files();

my $line_number = 0;
#my $bdiff_line_count = @bdiff_array;        # how many records are in the file?  MEMORY LEAK, tries to count lines of bdiff file
#my $bdiff_record = shift @bdiff_array;  # start with first line already in record variable  # MEMORY LEAK, tries to delete line from bdiff file
my $bdiff_record = $bdiff_array[$line_number];
$line_number++;
#my $bdiff_line = shift @bdiff_array;  # start with second line read into line variable  # MEMORY LEAK, tries to delete line from bdiff file
my $bdiff_line = $bdiff_array[$line_number];
$line_number++;

my $bdiff_record_line;
my $file_1_in_record = 0;
my $file_2_in_record = 0;
my $file_1_2_hash = undef;
my $file_1_2_hash_coords_ordered = undef;
my $bdiff_record_line_coords;
my $bdiff_record_line_energy;
my $file_1_or_2;
#my $flush_flag = 0;
#my $flush_threshold = 10;

#for $line_number (1 .. $bdiff_line_count) {  # MEMORY LEAK, needs to know count of lines in bdiff file
while (1) {
#    print 'top of for() loop, have line ' . $line_number . ' of ' . $bdiff_line_count . ' = ' . ($bdiff_line or 'undef') . "\n";
#    if (($line_number % $flush_threshold) == 0) { $flush_flag = 1; print 'MOD' . "\n"; }
#    if (((defined $bdiff_line) and ($bdiff_line =~ m/^[0-9]/)) or ($line_number == $bdiff_line_count)) {  # MEMORY LEAK, needs to know line count of bdiff file
    if (((defined $bdiff_line) and ($bdiff_line =~ m/^[0-9]/)) or (not defined $bdiff_line)) {
#        print 'found line starting with number (start of new record) or end of file, processing previous record =' . "\n" . '[[[ BEGIN RECORD ]]]' . "\n" . $bdiff_record . "\n" . '[[[ END RECORD ]]]' . "\n";
        # start of a new record, process current record before iteration
        foreach $bdiff_record_line (split "\n", $bdiff_record) {
#            print 'top of foreach() loop, have $bdiff_record_line = ' . $bdiff_record_line . "\n";
            if (($bdiff_record_line =~ m/^[0-9]/) or ($bdiff_record_line =~ m/^\-/)) {
                next;  # ignore start-of-record lines and --- seperator lines between file 1 and file 2 record lines
            }
            # else assume actual data line from file 1 or file 2
            if ($file_1_in_record and $file_2_in_record) {
                # prepare to write to output file 3
                if (not defined $file_1_2_hash) { $file_1_2_hash = {}; }
                if (not defined $file_1_2_hash_coords_ordered) { $file_1_2_hash_coords_ordered = []; }
                if ($bdiff_record_line =~ m/^\</) { $file_1_or_2 = 1; }
                elsif ($bdiff_record_line =~ m/^\>/) { $file_1_or_2 = 2; }
                else { croak 'ERROR: expected leading < or > from bdiff output, found neither, croaking'; }

                substr $bdiff_record_line, 0, 2, q{};  # delete leading '< ' or '> ' characters added by bdiff
                ($bdiff_record_line_coords, $bdiff_record_line_energy) = split '>', $bdiff_record_line;
                if (not exists $file_1_2_hash->{$bdiff_record_line_coords}) {
                    $file_1_2_hash->{$bdiff_record_line_coords} = {};
                    push @{$file_1_2_hash_coords_ordered}, $bdiff_record_line_coords;
                }
                $file_1_2_hash->{$bdiff_record_line_coords}->{$file_1_or_2} = $bdiff_record_line_energy;    
            }
            elsif ($file_1_in_record) {
                # write to output file 1
                substr $bdiff_record_line, 0, 5, q{};  # delete leading '< ' characters added by bdiff and 'RH:' characters from original data files
                $bdiff_record_line =~ s/:/\ /g;  # replace colons with spaces
                $bdiff_record_line =~ s/>/\ /g;  # replace greater-than with space
                $print_success = ( print {$OUTPUT_FILEHANDLE_1} $bdiff_record_line, "\n" );
                if ( not $print_success ) { croak 'ERROR: Failed to write to file ' . $output_file_1 . ', croaking'; }
#                $OUTPUT_FILEHANDLE_1->flush();
#                if ($flush_flag) { close_files();  open_files();  $flush_flag = 0; }
            }
            elsif ($file_2_in_record) {
                # write to output file 2
                substr $bdiff_record_line, 0, 5, q{};  # delete leading '> ' characters added by bdiff and 'RH:' characters from original data files
                $bdiff_record_line =~ s/:/\ /g;  # replace colons with spaces
                $bdiff_record_line =~ s/>/\ /g;  # replace greater-than with space
                $print_success = ( print {$OUTPUT_FILEHANDLE_2} $bdiff_record_line, "\n" );
                if ( not $print_success ) { croak 'ERROR: Failed to write to file ' . $output_file_2 . ', croaking'; }
#                $OUTPUT_FILEHANDLE_2->flush();
#                if ($flush_flag) { close_files();  open_files();  $flush_flag = 0; }
            }
            else { croak 'ERROR: expected $file_1_in_record and/or $file_2_in_record flag(s) to be set, found neither, croaking'; }
        }
        if (defined $file_1_2_hash) {
#            print 'have $file_1_2_hash =' . "\n" . Dumper($file_1_2_hash) . "\n";
            # write to output file 3, and also possibly file 1 and/or file 2
            foreach $bdiff_record_line_coords (@{$file_1_2_hash_coords_ordered}) {
                if ((exists $file_1_2_hash->{$bdiff_record_line_coords}->{1}) and (exists $file_1_2_hash->{$bdiff_record_line_coords}->{2})) {
                    $bdiff_record_line = $bdiff_record_line_coords . ' ' . $file_1_2_hash->{$bdiff_record_line_coords}->{1} . ' ' . $file_1_2_hash->{$bdiff_record_line_coords}->{2} . "\n";
                    substr $bdiff_record_line, 0, 3, q{};  # delete leading 'RH:' characters from original data files
                    $bdiff_record_line =~ s/:/\ /g;  # replace colons with spaces
                    $print_success = ( print {$OUTPUT_FILEHANDLE_3} $bdiff_record_line );
                    if ( not $print_success ) { croak 'ERROR: Failed to write to file ' . $output_file_3 . ', croaking'; }
#                    $OUTPUT_FILEHANDLE_3->flush();
                }
                elsif (exists $file_1_2_hash->{$bdiff_record_line_coords}->{1}) {
                    $bdiff_record_line = $bdiff_record_line_coords . ' ' . $file_1_2_hash->{$bdiff_record_line_coords}->{1} . "\n";
                    substr $bdiff_record_line, 0, 3, q{};  # delete leading 'RH:' characters from original data files
                    $bdiff_record_line =~ s/:/\ /g;  # replace colons with spaces
                    $print_success = ( print {$OUTPUT_FILEHANDLE_1} $bdiff_record_line );
                    if ( not $print_success ) { croak 'ERROR: Failed to write to file ' . $output_file_1 . ', croaking'; }
#                    $OUTPUT_FILEHANDLE_1->flush();
                }
                elsif (exists $file_1_2_hash->{$bdiff_record_line_coords}->{2}) {
                    $bdiff_record_line = $bdiff_record_line_coords . ' ' . $file_1_2_hash->{$bdiff_record_line_coords}->{2} . "\n";
                    substr $bdiff_record_line, 0, 3, q{};  # delete leading 'RH:' characters from original data files
                    $bdiff_record_line =~ s/:/\ /g;  # replace colons with spaces
                    $print_success = ( print {$OUTPUT_FILEHANDLE_2} $bdiff_record_line );
                    if ( not $print_success ) { croak 'ERROR: Failed to write to file ' . $output_file_2 . ', croaking'; }
#                    $OUTPUT_FILEHANDLE_2->flush();
                }
                else { croak 'ERROR: expected $file_1_2_hash->{$bdiff_record_line_coords}->{1} and/or $file_1_2_hash->{$bdiff_record_line_coords}->{2} values to be set, found neither, croaking'; }
#                if ($flush_flag) { close_files();  open_files();  $flush_flag = 0; }
            }

            # POSSIBLE MEMORY LEAK
            $file_1_2_hash = undef;
            $file_1_2_hash_coords_ordered = undef;
            $file_1_in_record = 0;
            $file_2_in_record = 0;
        }
        if (not defined $bdiff_line) { last; }  # exit point for main while() loop
        $bdiff_record = $bdiff_line;
    }
    else {
#        print 'found line not starting with number, still inside current record; ';
        # still inside current record, concatenate line to record and check for data from file 1 or 2
        $bdiff_record .= "\n" . $bdiff_line;
        if ($bdiff_line =~ m/^\</) { 
            $file_1_in_record = 1;
#            print 'found line starting with <, setting $file_1_in_record flag' . "\n";
        }
        elsif ($bdiff_line =~ m/^\>/) {
            $file_2_in_record = 1;
#            print 'found line starting with >, setting $file_2_in_record flag' . "\n";
        }
#        else { print "\n"; }  # ignore bdiff --- seperator between file 1 and file 2 lines
    }

#    $bdiff_line = shift @bdiff_array;  # MEMORY LEAK, tries to delete line from bdiff file
    $bdiff_line = $bdiff_array[$line_number];
    $line_number++;  # while() loop does not auto-increment this variable, must do it here
}

untie @bdiff_array;
close_files();


# [[[ SUBROUTINES ]]]

sub open_files {
#    print 'enter open_files()...' . "\n";
    $open_success = open $OUTPUT_FILEHANDLE_1, '>', $output_file_1;
    if ( not $open_success ) { croak 'ERROR: Failed to open file ' . $output_file_1 . ' for writing, croaking'; }

    $open_success = open $OUTPUT_FILEHANDLE_2, '>', $output_file_2;
    if ( not $open_success ) { croak 'ERROR: Failed to open file ' . $output_file_2 . ' for writing, croaking'; }

    $open_success = open $OUTPUT_FILEHANDLE_3, '>', $output_file_3;
    if ( not $open_success ) { croak 'ERROR: Failed to open file ' . $output_file_3 . ' for writing, croaking'; }
#    print 'leave open_files()' . "\n";
}

sub close_files {
#    print 'close_files()...' . "\n";
    if ( not close $OUTPUT_FILEHANDLE_1 ) { croak 'ERROR: Failed to close file ' . $output_file_1 . ' after writing, croaking'; }
    if ( not close $OUTPUT_FILEHANDLE_2 ) { croak 'ERROR: Failed to close file ' . $output_file_2 . ' after writing, croaking'; }
    if ( not close $OUTPUT_FILEHANDLE_3 ) { croak 'ERROR: Failed to close file ' . $output_file_3 . ' after writing, croaking'; }
}
