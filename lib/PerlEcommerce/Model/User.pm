package PerlEcommerce::Model::User;
use Mojo::Base 'PerlEcommerce::Model::Base';
use PerlEcommerce::Result::User;

sub all { return shift->schema('user')->all->hashes }


1;
