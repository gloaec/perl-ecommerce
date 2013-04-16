package PerlEcommerce::Model::Product;
use Mojo::Base 'PerlEcommerce::Model::Base';
use PerlEcommerce::Result::Product;

sub list { return shift->schema('product')->get_all->hashes }

1;
