package PerlEcommerce::Model::Product;
use Mojo::Base 'PerlEcommerce::Model::Base';
use PerlEcommerce::Result::Product;

sub all { return shift->schema('product')->all->hashes }

sub find { return shift->schema('product')->find(shift)->hash }

1;
