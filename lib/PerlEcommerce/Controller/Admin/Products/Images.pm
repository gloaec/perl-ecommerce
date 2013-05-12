package PerlEcommerce::Controller::Admin::Products::Images;
use Mojo::Base 'PerlEcommerce::Controller::Admin::Products';
use PerlEcommerce::I18N;
use Image::Magick::Thumbnail::Fixed;

sub image {
  my $self = shift;
  return $self->product->images->find($self->param('id_image'));
}

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
  my $image = $self->schema('image')->new({});
  my $product = $self->product;
  $self->stash({ image => $image, product => $product }); 
  return $self;
}

sub show {
  my $self = shift;
  my $product = $self->product;
  my $image = $self->image;
  return $self->render({ product => $product, image => $image });
}

sub edit {
  my $self = shift;
  my $product = $self->product;
  my $image = $self->image;
  return $self->render({ product => $product, image => $image });
}

sub create {
  my $self = shift;
  my $product = $self->product;
  try {
    my $image = $product->images->create($self->param('image'));
    return $self->render(text => 'File is too big.', status => 200) if $self->req->is_limit_exceeded;
    return $self->redirect_to('admin_product_image_edit') unless my $attachment = $self->param('attachment');
    use Data::Dumper;
    print "\n\n".Dumper($attachment)."\n\n";
    $image->generate_images($attachment);
    $self->flash(success => ('product_image_successfully_created'));
    return $self->redirect_to('admin_product_images', id_product => $product->id);
  } catch {
    print "ERROR$_";
    $self->show_error($self->handle_exception($_));
    return $self->redirect_to('admin_products_images', id_product => $product->id);
  };
}

sub update {
  my $self = shift;
  my $product = $self->product;
  try {
    my $image = $self->image;
    $image->update($self->param('image'));
    return $self->render(text => 'File is too big.', status => 200) if $self->req->is_limit_exceeded;
    return $self->redirect_to('admin_product_image_edit') unless my $attachment = $self->param('attachment');
    use Data::Dumper;
    print "\n\n".Dumper($attachment)."\n\n";
    $image->generate_images($attachment);
    $self->flash(success => ('product_image_successfully_modified'));
    return $self->redirect_to('admin_product_images', id_product => $product->id);
  } catch {
    print "ERROR$_";
    $self->show_error($self->handle_exception($_));
    return $self->redirect_to('admin_products_images', id_product => $product->id);
  };
}

sub delete {
  my $self = shift;
  my $product = $self->product;
  my $image = $self->image;
  $image->delete;
  $self->flash(success => ('product_image_successfully_deleted'));
  return $self->redirect_to('admin_product_images', id_product => $product->id);
}

sub _get_products {
  return shift;
}

1;

