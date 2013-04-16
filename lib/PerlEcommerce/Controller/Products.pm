package PerlEcommerce::Controller::Products;
use Mojo::Base 'PerlEcommerce::Controller';
use PerlEcommerce::I18N;

sub index {
  my $self = shift;
  my @products = $self->model('product')->all;
  my %params = (
    products => \@products
  );
  $self->render(%params, @_);
}

sub show {
  my $self = shift;
  my $id = $self->param('id');
  my $product = $self->model('product')->find($id);
  $self->render({ product => $product });
}

sub _get_products {
  return shift;
}

1;
