package PerlEcommerce::Result::Taxon;
use Mojo::Base -base;

has [ qw/
  id
  name
  position
  permalink
  lft
  rgt
  description
  hidden
  home_page
  short_name
/ ];

1;


