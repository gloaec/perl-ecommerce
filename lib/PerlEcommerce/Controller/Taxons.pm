package PerlEcommerce::Controller::Taxons;
use Mojo::Base 'PerlEcommerce::Controller';
use Mojo::Base 'PerlEcommerce::Controller::Orders';
use PerlEcommerce::I18N;



sub listing {
 my $self = shift;
 my @productss =	$self->schema('Product')->search({ 
                                        taxon_id => $self->param('id')
                                            });

 my @taxons = $self->schema('taxon')->all;
 my $k= $self->return_session;
  
  my $f_name = $k;
  my %params = (
    taxons => \@taxons,
    sessio => $f_name,
    products => \@productss
  );
  $self->render(%params, @_);
}
  
1;
