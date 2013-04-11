package PerlEcommerce::Controller::Products;
use Mojo::Base 'PerlEcommerce::Controller';
use PerlEcommerce::I18N;

sub index {
  my $self = shift;
  my %params = (
    products => [
      { name => 'Product 1', price => 30 },
      { name => 'Product 2', price => 50 },
    ]
  );

  $self->render(%params, @_);
}

1;
