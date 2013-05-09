package PerlEcommerce::Model::Variant;
use Mojo::Base 'PerlEcommerce::Model::Base';
use PerlEcommerce::Result::Variant;

sub all { return shift->schema('variant')->all->hashes }


1;
