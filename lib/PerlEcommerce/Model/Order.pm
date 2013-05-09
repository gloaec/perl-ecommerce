package PerlEcommerce::Model::Taxon;
use Mojo::Base 'PerlEcommerce::Model::Base';
use PerlEcommerce::Result::Taxon;

sub all { return shift->schema('user')->all->hashes }


1;
