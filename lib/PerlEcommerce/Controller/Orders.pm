package PerlEcommerce::Controller::Orders;
use Mojo::Base 'PerlEcommerce::Controller';
use PerlEcommerce::I18N;


my @tab;
my @orders = (         
);  
sub index {
  # just render
  my $self = shift;
  
  my @taxons = $self->schema('taxon')->all;


  my %params = (
    taxons =>\@taxons,
    sessio =>  \@orders,
    products => \@orders
  );


    
  $self->render(%params, @_);

}

sub validate {
	my $class = shift;
	my %args = @_;

 	my @taxons = $class->schema('taxon')->all;
	my %params = (
		taxons =>\@taxons,
		sessio =>\@orders
	);  

	$class->render(%params, @_);    
}


sub populate {
	my $self = shift;
  
  my $id = $self->param('id');
  my $product = $self->schema('product')->find($id);
  my @taxons = $self->schema('taxon')->all;
  # storing data in the session
	
   #push(@tab, $product->id,$product->name,$product->master->price);
   push @orders, [$product->id,$product->name,$product->master->price,$product->master->cost_price];
  #my @t = ($product->id,$product->name,$product->master->price);
    
  my %params = (
  
    taxons =>\@taxons,
    sessio =>\@orders
  );  
  
  $self->render(%params, @_);    

}

sub return_session{
  return \@orders;
}


1;
