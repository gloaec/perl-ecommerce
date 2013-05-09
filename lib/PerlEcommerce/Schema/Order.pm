package PerlEcommerce::Schema::Order;
use strict;
use warnings;
use parent 'PerlEcommerce::Schema::Base';

our %queries = (
    all                 => "SELECT * FROM %table_order"
);

1;
