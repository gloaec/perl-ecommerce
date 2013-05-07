package PerlEcommerce::Schema::Taxon;
use strict;
use warnings;
use parent 'PerlEcommerce::Schema::Base';

our %queries = (
    all                 => "SELECT * FROM %table_taxons",
    find                => "SELECT * FROM %table_taxons WHERE id=?",
    insert              => "INSERT INTO %table_taxons
        (name,position,permalink,lft,rgt,hidden,homapage,short_name,created_at,updated_at)
        VALUES (?,?,?,?,?,?,?,?,NULL,NOW(),NOW())"
);

1;
