package PerlEcommerce::Result::Payment;
use Mojo::Base -base;

has [ qw/
    id
    tracking
    created_at
    updated_at
    number
    cost
    shipped_at
    state
    address_id
    order_id
/ ];

1;
