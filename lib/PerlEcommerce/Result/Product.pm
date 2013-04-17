package PerlEcommerce::Result::Product;
use Mojo::Base -base;

has [ qw/
    id name price
    created_at updated_at
/ ];

1;

