#!/usr/bin/perl

# [[[ HEADER ]]]
use strict;
use warnings;
use RPerl;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

print '[[[ PHY2360, WILL BRASWELL ]]]' . "\n";
print '[[[ PROBLEM SET 10, N48A ]]]' . "\n\n";

print '[[ DNA STRING ]]' . "\n\n";

print '[ QUESTION 1 ]' . "\n";

my string $coding_sequence = <<'EOF';
AACCTGCTCTTTAGATTTCGAGCTTATTCTCTTCTAGCAGTTTCTTGCCACCATGTCGGAAACCGCTCCT
GCCGAGACAGCCACCCCAGCGCCGGTGGAGAAATCCCCGGCTAAGAAGAAGGCAACTAAGAAGGCTGCCG
GCGCCGGCGCTGCTAAGCGCAAAGCGACGGGGCCCCCAGTCTCAGAGCTGATCACCAAGGCTGTGGCTGC
TTCTAAGGAGCGCAATGGCCTTTCTTTGGCAGCCCTTAAGAAGGCCTTAGCGGCCGGTGGCTACGACGTG
GAGAAGAATAACAGCCGCATTAAGCTGGGCCTCAAGAGCTTGGTGAGCAAGGGCACCCTGGTGCAGACCA
AGGGCACTGGTGCTTCTGGCTCCTTTAAACTCAACAAGAAGGCGGCCTCCGGGGAAGCCAAGCCCAAAGC
CAAGAAGGCAGGCGCCGCTAAAGCTAAGAAGCCCGCGGGGGCCACGCCTAAGAAGGCCAAGAAGGCTGCA
GGGGCGAAAAAGGCAGTGAAGAAGACTCCGAAGAAGGCGAAGAAGCCCGCGGCGGCTGGCGTCAAAAAGG
TGGCGAAGAGCCCTAAGAAGGCCAAGGCCGCTGCCAAACCGAAAAAGGCAACCAAGAGTCCTGCCAAGCC
CAAGGCAGTTAAGCCGAAGGCGGCAAAGCCCAAAGCCGCTAAGCCCAAAGCAGCAAAACCTAAAGCTGCA
AAGGCCAAGAAGGCGGCTGCCAAAAAGAAGTAGGAAGCTGGCGTGTGAAAACCGCAACAAAGCCCCAAAG
GCTCTTTTCAGAGCCACCCA
EOF

print '$coding_sequence =' . "\n" . $coding_sequence . "\n";

my string $mrna_sequence = $coding_sequence;
$mrna_sequence =~ s/T/U/gxms;

print '$mrna_sequence =' . "\n" . $mrna_sequence . "\n";

print '[ QUESTION 2 ]' . "\n";

my string $template_sequence = $coding_sequence;
$template_sequence =~ s/A/X/gxms;
$template_sequence =~ s/T/A/gxms;
$template_sequence =~ s/X/T/gxms;

$template_sequence =~ s/C/X/gxms;
$template_sequence =~ s/G/C/gxms;
$template_sequence =~ s/X/G/gxms;

my string_arrayref $template_sequence_split
    = [ split "\n", $template_sequence ];
$template_sequence_split = [ reverse @{$template_sequence_split} ];

#print '$template_sequence_split =' . "\n" . Dumper($template_sequence_split) . "\n";
$template_sequence = q{};
foreach my string $template_sequence_line ( @{$template_sequence_split} ) {
    $template_sequence .= join q{},
        ( reverse( split q{}, $template_sequence_line ) ) . "\n";
}

print '$template_sequence =' . "\n" . $template_sequence . "\n";

print '[ QUESTION 3 ]' . "\n";

my string $coding_sequence_flat = join '', ( split "\n", $coding_sequence );
my integer $protein_encoding_start = index $coding_sequence_flat, 'ATG';
print '$protein_encoding_start = ' . $protein_encoding_start . "\n\n";

print '[ QUESTION 4 ]' . "\n";

my integer $protein_encoding_tag_final = rindex $coding_sequence_flat, 'TAG';
print '$protein_encoding_tag_final = ' . $protein_encoding_tag_final . "\n\n";

print '[[ DNA DICTIONARY ]]' . "\n\n";

print '[ QUESTION 1 ]' . "\n";

my string_hashref $codon_table = {
    'TTT' => 'F', 'TTC' => 'F', 'TTA' => 'L', 'TTG' => 'L',
    'TCT' => 'S', 'TCC' => 'S', 'TCA' => 'S', 'TCG' => 'S',
    'TAT' => 'Y', 'TAC' => 'Y', 'TAA' => '*', 'TAG' => '*',
    'TGT' => 'C', 'TGC' => 'C', 'TGA' => '*', 'TGG' => 'W',

    'CTT' => 'L', 'CTC' => 'L', 'CTA' => 'L', 'CTG' => 'L',
    'CCT' => 'P', 'CCC' => 'P', 'CCA' => 'P', 'CCG' => 'P',
    'CAT' => 'H', 'CAC' => 'H', 'CAA' => 'Q', 'CAG' => 'Q',
    'CGT' => 'R', 'CGC' => 'R', 'CGA' => 'R', 'CGG' => 'R',

    'ATT' => 'I', 'ATC' => 'I', 'ATA' => 'I', 'ATG' => 'M',
    'ACT' => 'T', 'ACC' => 'T', 'ACA' => 'T', 'ACG' => 'T',
    'AAT' => 'N', 'AAC' => 'N', 'AAA' => 'K', 'AAG' => 'K',
    'AGT' => 'S', 'AGC' => 'S', 'AGA' => 'R', 'AGG' => 'R',

    'GTT' => 'V', 'GTC' => 'V', 'GTA' => 'V', 'GTG' => 'V',
    'GCT' => 'A', 'GCC' => 'A', 'GCA' => 'A', 'GCG' => 'A',
    'GAT' => 'D', 'GAC' => 'D', 'GAA' => 'E', 'GAG' => 'E',
    'GGT' => 'G', 'GGC' => 'G', 'GGA' => 'G', 'GGG' => 'G'
};

my string $codon = 'AAG';
print '$codon_table->{' . $codon . '} = ' . $codon_table->{$codon} . "\n\n";

print '[ QUESTION 2 ]' . "\n";

my string_hashref $amino_acid_table = {
    'A' => 'alanine',
    'C' => 'cystine',
    'D' => 'aspartic acid',
    'E' => 'glutamic acid',
    'F' => 'phenylalanine',
    'G' => 'glycine',
    'H' => 'histidine',
    'I' => 'isoleucine',
    'K' => 'lysine',
    'L' => 'leucine',
    'M' => 'methionine/start',
    'N' => 'asparagine',
    'P' => 'proline',
    'Q' => 'glutamine',
    'R' => 'arginine',
    'S' => 'serine',
    'T' => 'threonine',
    'V' => 'valine',
    'W' => 'tryptophan',
    'Y' => 'tyrosine',
    '*' => 'stop'
};

$codon = 'CAA';
print '$amino_acid_table->{$codon_table->{'
    . $codon . '}} = '
    . $amino_acid_table->{ $codon_table->{$codon} } . "\n\n";

print '[ QUESTION 3 ]' . "\n";

use Storable qw(dclone);
my string_hashref $mitochondrial_table = dclone $codon_table;
$mitochondrial_table->{AGA} = '*';    # stop
$mitochondrial_table->{AGG} = '*';    # stop
$mitochondrial_table->{TGA} = 'W';    # tryptophan
$mitochondrial_table->{ATA} = 'M';    # methionine

print '$mitochondrial_table =' . "\n"
    . ( join q{}, ( split "\n", Dumper($mitochondrial_table) ) )
    . "\n\n";                         # unpretty print!

print '[ QUESTION 4 BONUS ]' . "\n";

my string_arrayref $codon_table_serine = [];

foreach my string $codon ( sort keys %{$codon_table} ) {
    if ( $codon_table->{$codon} eq 'S' ) {
        push @{$codon_table_serine}, $codon;
    }
}

print '$codon_table_serine =' . "\n" . Dumper($codon_table_serine) . "\n";

print '[[ DNA TRANSLATION ]]' . "\n\n";

print '[ QUESTION 1 ]' . "\n";

sub extract_amino_acids {
   (my string $coding_sequence_flat_in) = @ARG; 
    my string $coding_subsequence = substr $coding_sequence_flat_in, $protein_encoding_start;
    my integer $protein_encoding_end = 999_999;
    foreach my string $stop_codon (qw(TAA TAG TGA)) {
        my integer $stop_codon_index = 999_999;
        for my integer $i (0 .. ((length $coding_subsequence) / 3) - 1) {
            $codon = substr $coding_subsequence, ($i * 3), 3;
#            print '$i = ' . $i . ', $i * 3 = ', ($i * 3), ', possible stop $codon = ' . $codon . "\n";
            if ($codon eq $stop_codon) {
                $stop_codon_index = $i * 3;
                last;
            }
        }
        if ( $stop_codon_index < $protein_encoding_end ) {
            $protein_encoding_end = $stop_codon_index;
        }
    }
#print '$protein_encoding_end = ' . $protein_encoding_end . "\n";

    my string $amino_acids_out        = q{};
    $coding_subsequence = substr $coding_subsequence, 0, ($protein_encoding_end + 3);  # length of codon = 3
    #print '$coding_subsequence = ' . $coding_subsequence . "\n";

    for my integer $i (0 .. ((length $coding_subsequence) / 3) - 2) {
        $codon = substr $coding_subsequence, ($i * 3), 3;
#        print 'amino acid $codon = ' . $codon . "\n";
        $amino_acids_out .= $codon_table->{$codon}; 
    }
    return $amino_acids_out;
}

my string $amino_acids = extract_amino_acids($coding_sequence_flat);
print '$amino_acids = ' . $amino_acids . "\n\n";

print '[ QUESTION 2 ]' . "\n";
print 'length $amino_acids = ' . (length $amino_acids) . "\n\n";

print '[ QUESTION 3 ]' . "\n";

foreach my string $amino_acid_abbreviation (sort keys %{$amino_acid_table}) {
    if ((index $amino_acids, $amino_acid_abbreviation) == -1) {
        print $amino_acid_table->{$amino_acid_abbreviation} . ' is not in protein' . "\n";
    }
    else {
        print $amino_acid_table->{$amino_acid_abbreviation} . ' is in protein' . "\n";
    }
}
print "\n";

print '[ QUESTION 4 BONUS ]' . "\n";

my integer_hashref $codon_count = {};
foreach my string $amino_acid_abbreviation (sort keys %{$amino_acid_table}) {
    $codon_count->{$amino_acid_abbreviation} = 0;
}
foreach my string $amino_acid_abbreviation (sort keys %{$amino_acid_table}) {
    foreach my string $codon_key (sort keys %{$codon_table}) {
        if ($codon_table->{$codon_key} eq $amino_acid_abbreviation) {
            $codon_count->{$amino_acid_abbreviation}++;
        }
    }
}
#print '$codon_count =' . "\n";
#foreach my string $key (sort keys %{$codon_count}) { print $key . ' => ' . $codon_count->{$key} . ', '; }
#print "\n";

use bignum;

my integer $combinations = 1;
foreach my string $amino_acid_abbreviation (split q{}, $amino_acids) {
    $combinations *= $codon_count->{$amino_acid_abbreviation};
}
print '$combinations = ' . $combinations . "\n\n";

print '[[[ PROBLEM SET 10, N48B BONUS ]]]' . "\n\n";

my integer $base_count = length $coding_sequence_flat;
#my string_hashref $base_table = {
#    A => 'adenine',
#    C => 'cytosine',
#    G => 'guanine',
#    T => 'thymine'
#};

my integer $base_mutation_count = 0;
my integer $amino_acids_mutation_count = 0;
for my integer $i (0 .. ((length $coding_sequence_flat) - 1)) {
    my string $base = substr $coding_sequence_flat, $i, 1;
    if ($base eq 'C') {
        $base_mutation_count++;
        my string $coding_sequence_mutated = $coding_sequence_flat;
        substr $coding_sequence_mutated, $i, 1, 'G';
        my string $amino_acids_possibly_mutated = extract_amino_acids($coding_sequence_mutated);
        if ($amino_acids_possibly_mutated ne $amino_acids) {
            $amino_acids_mutation_count++;
        }
    }
}

my integer $amino_acids_nonmutation_count = $base_mutation_count - $amino_acids_mutation_count;
my number $amino_acids_nonmutation_probability = $amino_acids_nonmutation_count / $base_mutation_count;

print '$base_count = ' . $base_count . "\n";
print '$base_mutation_count = ' . $base_mutation_count . "\n";
print '$amino_acids_nonmutation_count = ' . $amino_acids_nonmutation_count . "\n";
print '$amino_acids_nonmutation_probability = ' . $amino_acids_nonmutation_probability . "\n\n";