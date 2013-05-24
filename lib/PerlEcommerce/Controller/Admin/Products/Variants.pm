package PerlEcommerce::Controller::Admin::Products::Variants;
use Mojo::Base 'PerlEcommerce::Controller::Admin::Products';
use PerlEcommerce::I18N;

sub variant {
  my $self = shift;
  return $self->schema('variant')->find($self->param('id_variant'));
}

sub index {
  my $self = shift;
  my $product = $self->product;
  my @variants = $product->variants->find({is_master => 0});
  my %params = (
    product => $product,
    variants => \@variants
  );
  return $self->render(%params, @_);
}

sub new {
  my $class = shift;
  my %args = @_;    
  my $self = $class->SUPER::new(@_);
  my $product = $self->product;
  my $variant = $product->variants->new({});
  $self->stash( product => $product, variant => $variant ); 
  return $self;
}

sub show {
  my $self = shift;
  my $product = $self->product;
  my $variant = $self->variant;
  return $self->render( product => $product, variant => $variant);
}

sub edit {
  my $self = shift;
  my $product = $self->product;
  my $variant = $self->variant;
  return $self->render( product => $product, variant => $variant);
}

sub create {
    my $self = shift;
    my $product = $self->product;
    try {
        my $variant = $self->product->variants->find_or_create($self->param('variant'));
	$variant->update({ product_id => $product->id });
	$self->flash(success => ('variant_successfully_created'));
        return $self->redirect_to('edit_admin_product_variants', id_product => $product->id);
    } catch {
        print "ERROR$_";
        $self->show_error($self->handle_exception($_));
	return $self->redirect_to('edit_admin_product_variants', id_product => $product->id);
    };
}

sub update {
    my $self = shift;
    my $product = $self->product;
    try {
	my $variant = $self->variant;
	$variant->update($self->param('variant'));
	$variant->update({ product_id => $product->id });
	$self->flash(success => ('variant_successfully_modified'));
	return $self->redirect_to('edit_admin_product_variant', id_product => $product->id, id_variant => $variant->id);
    } catch {
        print "ERROR$_";
        $self->show_error($self->handle_exception($_));
	return $self->redirect_to('edit_admin_product_variants', id_product => $product->id);
    };
}

sub delete {
  my $self = shift;
  my $product = $self->product;
  $product->delete;
  $self->flash(success => ('variant_successfully_deleted'));
  return $self->redirect_to('edit_admin_product_variants', id_product => $product->id);
}

sub _get_products {
  return shift;
}

1;
