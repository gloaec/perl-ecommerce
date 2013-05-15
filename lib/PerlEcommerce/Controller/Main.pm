package PerlEcommerce::Controller::Main;
use Mojo::Base 'PerlEcommerce::Controller';
use Mojo::Base 'PerlEcommerce::Controller::Orders';
use PerlEcommerce::I18N;



sub index {
 my $self = shift;

 my @taxons = $self->schema('taxon')->all;
 my $k= $self->return_session;
  
  my $f_name = $k;
  my %params = (
    taxons => \@taxons,
    sessio => $f_name
  );
  $self->render(%params, @_);
}
  
1;
