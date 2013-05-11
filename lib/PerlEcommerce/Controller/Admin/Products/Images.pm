package PerlEcommerce::Controller::Admin::Products::Images;
use Mojo::Base 'PerlEcommerce::Controller::Admin::Products';
use PerlEcommerce::I18N;

sub index {
  my $self = shift;
  my $product = $self->product;
  my @images = $product->images;
  my %params = (
    product => $product,
    images  => \@images
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
  my $id = $self->param('id');
  my $product = $self->schema('product')->find($id);
  return $self->render({ product => $product });
}

sub edit {
  my $self = shift;
  my $id = $self->param('id');
  my $product = $self->schema('product')->find($id);
  my $variant = $self->schema('variant')->find({ product_id => $id, is_master => 1 });
  #@product{keys %master_variant} = values %master_variant;
  return $self->render({ product => $product, variant => $variant });
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
        my $product = $self->schema('product')->find($self->param('id'))->update($self->param('product'));#\%params);
        my $variant = $product->master->update($self->param('variant'));
	$variant->update({ product_id => $product->id, is_master => 1 });
	$self->flash(success => ('product_successfully_modified'));
	return $self->redirect_to('admin_product', id => $product->id);
	#return $self->render({ json => {success => ('product_successfully_modified')}});
    } catch {
        print "ERROR$_";
        $self->show_error($self->handle_exception($_));
	return $self->redirect_to('admin_product');
    };
}

sub delete {
  my $self = shift;
  my $id = $self->param('id');
  my $product = $self->schema('product')->find($id)->delete;
  $self->flash(success => ('product_successfully_deleted'));
  return $self->redirect_to('admin_products');
  #return $self->render({ json => {success => ('product_successfully_deleted')}});
}

sub _get_products {
  return shift;
}

1;

