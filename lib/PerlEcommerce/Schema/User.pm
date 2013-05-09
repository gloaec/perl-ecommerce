package PerlEcommerce::Schema::User;
use strict;
use warnings;
use parent 'PerlEcommerce::Schema::Base';

our %queries = (
    all                 => "SELECT * FROM %table_users"
);

1;
