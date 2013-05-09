package PerlEcommerce::Schema::Product;
use strict;
use warnings;
use parent 'PerlEcommerce::Schema::Base';

our %queries = (
    all                 => "SELECT * FROM %table_products",
    find                => "SELECT * FROM %table_products WHERE id=?",
    insert              => "INSERT INTO %table_products
             (name,description,price,permalink,meta_description,meta_keywords,count_on_hand,available_on,deleted_at,created_at,updated_at)
      VALUES (?   ,?          ,?    ,?        ,?               ,?            ,?            ,?           ,NULL      ,NOW()     ,NOW()     )"
);

1;
