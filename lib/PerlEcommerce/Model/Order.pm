package PerlEcommerce::Model::Order;
use Mojo::Base 'PerlEcommerce::Model::Base';
use PerlEcommerce::Result::Order;

sub all { return shift->schema('order')->all->hashes }


1;
