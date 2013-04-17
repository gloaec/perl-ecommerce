package PerlEcommerce::Schema::Product;
use strict;
use warnings;
use parent 'PerlEcommerce::Schema::Base';

our %queries = (
    all                 => "SELECT * FROM %table_products",
    find                => "SELECT * FROM %table_products WHERE id=?",
    get_password        => "SELECT password FROM %table_admin WHERE username=? AND active='1'",
    insert              => "INSERT INTO %table_products
        (name,description,price,created_at,updated_at)
        VALUES (?,?,?,NOW(),NOW())"
);

1;
