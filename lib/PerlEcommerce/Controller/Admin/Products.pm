package PerlEcommerce::Controller::Admin::Products;
use Mojo::Base 'PerlEcommerce::Controller';
use PerlEcommerce::I18N;

sub index {
  my $self = shift;
  my @products = $self->schema('product')->all;
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
    my $conf = $self->stash('config'); # $conf->{database}
    my %params;
    # my %defaults = (
    #     'name'           => undef,
    #     'description'    => '', 
    #     'price'          => 0
    # );
    # while(my ($field, $def) = each %defaults) {
    #     my $val = $self->param($field) // $defaults{$field};
    #     $val = $defaults{$field} unless length $val;
    #     $params{$field} = $val;
    # }
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

sub delete {
  my $self = shift;
  my $id = $self->param('id');
  my $product = $self->schema('product')->find($id)->delete;
 #$self->flash(success => ('product_successfully_deleted'));
  return $self->render({ json => {success => ('product_successfully_deleted')}});
}

sub _get_products {
  return shift;
}

1;
