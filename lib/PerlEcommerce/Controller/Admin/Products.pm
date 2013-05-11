package PerlEcommerce::Controller::Admin::Products;
use Mojo::Base 'PerlEcommerce::Controller::Admin';
use PerlEcommerce::I18N;

sub product {
  my $self = shift;
  return $self->schema('product')->find($self->param('id_product'));
}

sub index {
  my $self = shift;
  my @products = $self->schema('product')->all;
  while(my ($id, $product) = each @products) {
    print $id.' '.$product->name."\n";
  }
  my %params = (
    products => \@products
  );
  return $self->render(%params, @_);
}

sub new {
  my $class = shift;
  my %args = @_;    
  my $self = $class->SUPER::new(@_);
  my $product = $self->schema('product')->new({});
  my $variant = $self->schema('variant')->new({});
  $self->stash({ product => $product, variant => $variant }); 
  return $self;
}

sub show {
  my $self = shift;
  my $product = $self->product;
  return $self->render({ product => $product });
}

sub edit {
  my $self = shift;
  my $product = $self->product;
  return $self->render({ product => $product });
}

sub create {
    my $self = shift;
    try {
        my $product = $self->schema('product')->find_or_create($self->param('product'));#\%params);
        my $variant = $self->schema('variant')->find_or_create($self->param('variant'));
	$variant->update({ product_id => $product->id, is_master => 1 });
	$self->flash(success => ('product_successfully_created'));
        return $self->redirect_to('admin_product', id => $product->id);
    } catch {
        print "ERROR$_";
        $self->show_error($self->handle_exception($_));
	return $self->redirect_to('admin_products');
    };
}

sub update {
    my $self = shift;
    try {
        my $product = $self->product;
	$product->update($self->param('product'));#\%params);
        my $variant = $product->master;
	$variant->update($self->param('variant'));
	$variant->update({ product_id => $product->id, is_master => 1 });
	$self->flash(success => ('product_successfully_modified'));
	return $self->redirect_to('edit_admin_product', id => $product->id);
    } catch {
        print "ERROR$_";
        $self->show_error($self->handle_exception($_));
	return $self->redirect_to('admin_product');
    };
}

sub delete {
  my $self = shift;
  my $product = $self->product;
  $product->delete;
  $self->flash(success => ('product_successfully_deleted'));
  return $self->redirect_to('admin_products');
}

sub _get_products {
  return shift;
}

1;
