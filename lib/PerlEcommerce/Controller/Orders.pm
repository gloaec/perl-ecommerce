package PerlEcommerce::Controller::Orders;
use Mojo::Base 'PerlEcommerce::Controller';
use PerlEcommerce::I18N;


my @tab;
my @orders = (         
);
my @quantity;  
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

  my $self = shift;
     @quantity = $self->param('quantity()');
  
 	my @taxons = $self->schema('taxon')->all;
	my %params = (
		taxons =>\@taxons,
		sessio =>\@orders,
    args => \@quantity
	);  

	$self->render(%params, @_);    
}

sub passed {
  my $self = shift;
  my $j=0;
  my $total=0;
  

 
  for my $i ( 0 .. $#orders) {
  $total = $orders[$i][2]*($quantity[$i]);
  # ajouuuuuuuuuuuuuuuuuuuuut dans la BDD #
  my $variant=$self->schema('Variant')->search({ 
                                        product_id => $orders[$i][0]
                                            })->first; 
  my $adress_data = {
      firstname => $self->param('firstname'),
      lastname => $self->param('lastname'),
      adress1 => $self->param('adress1'),  
      adress2 => $self->param('adress2'), 
      city => $self->param('city'), 
      country => $self->param('country'),
      phone => $self->param('phone')
  };
  $self->schema('Adress')->create( $adress_data );                 
  my $adress=$self->schema('Adress')->search({ 
                                            firstname => $self->param('firstname'), 
                                            lastname => $self->param('lastname'),
                                            city => $self->param('city')
                                            })->first;
  my $user_data ={
                  email => $self->param('email'),
                  login => $self->param('login'),
                  encrypted_password => $self->param('password')
  };
$self->schema('User')->create( $user_data ); 

  my $user=$self->schema('User')->search({ 
                                        email => $self->param('email'),
                                        login => $self->param('login')
                                            })->first;


  my $order_data = {
                     #item_total => $quantity[$i],
                     total => $total,
                     item_total => $quantity[$i],
                     adjustement_total => 'adjustment_total',
                     credit_total => 'credit_total',
                     state => 'state',
                     payment_total  => $total,
                     user_id => $user->id,
                     adress_id =>$adress->id
                   };                    
  $self->schema('Order')->create( $order_data );                 
  my $order = $self->schema('Order')->search({ 
                                       user_id => $user->id,
                                       adress_id =>$adress->id
                                            })->first;
my $shipments_data = {
   
    tracking         =>    'tracking',
    number           =>     'number',
    cost             =>     $total,
    state            =>     'state',
    address_id       =>     $adress->id,
    order_id         =>     $order->id

};
$self->schema('Shipment')->create( $shipments_data );    
 my $shipment = $self->schema('Shipment')->search({ 
                                                address_id => $adress->id,
                                                order_id => $order->id
                                            })->first;



my $inventory_unit = {
    state  => 'state',
    order_id  => $order->id,
    shipment_id  => $shipment->id   
  };
$self->schema('inventorysUnit')->create( $inventory_unit );

my $line_items = {
    quantity => $quantity[$i],
    price => $orders[$i][2],
    order_id => $order->id,
    variant_id => $variant->id
};
$self->schema('LineItem')->create( $line_items );

my $payments = {
    amount => $total,
    state => 'state'
};
$self->schema('payment')->create( $payments );
 my $payment = $self->schema('Payment')->search({ 
                                                    amount => $total,
                                                    state => 'state'
                                            })->first;
  
my $payments_method = {
  type => 'carte bancaire',
  name  => $self->param('namecard'),
  description => $self->param('cardnumber').'/'.$self->param('monthcard').'/'.$self->param('monthcard'),
  payments_id => $payment->id
};
$self->schema('paymentsMethod')->create( $payments_method );


  }
# FIN ajouuuuuuuuuuuuuuuuuuuuut dans la BDD #

  my @orderss=$self->schema('Order')->all;

  
  my @taxons = $self->schema('taxon')->all;
  my %params = (
    taxons =>\@taxons,
    sessio =>\@orders,
    orderss =>\@orderss
  );
  $self->render(%params, @_); 
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
