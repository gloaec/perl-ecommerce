package PerlEcommerce::Controller::Admin::Products;
use Mojo::Base 'PerlEcommerce::Controller';
use PerlEcommerce::I18N;

sub index {
  my $self = shift;
  my @users = $self->model('user')->all;
  my %params = (
    users => \@users
  );
  $self->render(%params, @_);
}
sub _get_products {
  return shift;
}

1;
