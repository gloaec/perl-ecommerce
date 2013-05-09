package PerlEcommerce::Schema::Variant;
use strict;
use warnings;
use parent 'PerlEcommerce::Schema::Base';

our %queries = (
    all                 => "SELECT * FROM %table_variants"
);

1;
