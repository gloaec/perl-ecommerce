package PerlEcommerce::Controller::Main;
use Mojo::Base 'PerlEcommerce::Controller';
use PerlEcommerce::I18N;

sub index {
  my $self = shift;
  my @taxons = $self->schema('taxon')->all;
  my %params = (
    taxons => \@taxons
  );
  $self->render(%params, @_);
}
  
1;
