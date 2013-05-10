package PerlEcommerce::Controller::Admin::Products;
use Mojo::Base 'PerlEcommerce::Controller';
use PerlEcommerce::I18N;

sub index {
  my $self = shift;
  my @products = $self->schema('product')->all;
  my %params = (
    products => \@products
  );
  $self->render(%params, @_);
}

sub show {
  my $self = shift;
  my $id = $self->param('id');
  my $product = $self->schema('product')->find($id);
  $self->render({ product => $product });
}

sub create {
    my $self = shift;
    my $conf = $self->stash('config'); # $conf->{database}
    my %params;
    my %defaults = (
        'name'           => undef,
        'description'    => '', 
        'price'          => 0
    );
    while(my ($field, $def) = each %defaults) {
        my $val = $self->param($field) // $defaults{$field};
        $val = $defaults{$field} unless length $val;
        $params{$field} = $val;
    }
    try {
        my $product = $self->schema('product')->find_or_create(\%params);
#$self->show_info_l('Create Success');
	$self->flash(success => 'Product created successfully!');
        return $self->redirect_to('admin_product', id => $product->id);
    } catch {
        print "ERROR$_";
        $self->show_error($self->handle_exception($_));
	return $self->redirect_to('admin_products');
    };
}

sub _get_products {
  return shift;
}

1;
