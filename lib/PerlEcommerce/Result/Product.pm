package PerlEcommerce::Result::Product;
use Mojo::Base -base;

has [ qw/
    id name description price permalink meta_description meta_keywords count_on_hand available_on deleted_at created_at updated_at
    taxon_id
/ ];

1;

