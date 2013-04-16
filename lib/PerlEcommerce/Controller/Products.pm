package PerlEcommerce::Controller::Products;
use Mojo::Base 'PerlEcommerce::Controller';
use PerlEcommerce::I18N;

sub index {
  my $self = shift;
  my @products = $self->model('product')->list;
  my %params = (
    products => \@products
  );
  $self->render(%params, @_);
}

sub show {
  my $self = shift;
  
  #$self->render({ product => { id => "1" }});
}

sub _get_products {
  return shift
}

1;
