#!/usr/bin/perl

my $repo;
BEGIN { $repo = "/Users/kschultz/Workspace/repos/github/schultzy51/dotfiles/xkpasswd.pm/"; }

use lib $repo;
use XKPasswd;

my $config = {
  word_length_min => 4,
  word_length_max => 8,
  num_words => 4,
  separator_character => q{_},
  padding_digits_before => 3,
  padding_digits_after => 3,
  padding_type => 'NONE',
  case_transform => 'LOWER',
  random_function => \&XKPasswd::basic_random_generator,
  random_increment => 8,
};

my $dictionary = $repo."sample_dict.txt";
my $password = xkpasswd($dictionary, $config);

print $password."\n";
