#!/usr/bin/perl

# standard 'best practice' imports
use strict;
use warnings;

# set things up for using UTF-8
use 5.016; # min Perl for good UTF-8 support
use utf8;
binmode STDOUT, ':encoding(UTF-8)';

# import the module
use Crypt::HSXKPasswd;

# assemble a config hashref
my $config = {
    word_length_min => 4,
    word_length_max => 8,
    num_words => 4,
    separator_character => '_',
    padding_digits_before => 3,
    padding_digits_after => 3,
    padding_type => 'NONE',
    case_transform => 'LOWER',
    allow_accents => 0,
};

# create an HSXKPasswd object using the above config
my $hsxkpasswd = Crypt::HSXKPasswd->new(config => $config);

# generate password
my $password = $hsxkpasswd->password();

print $password."\n";
