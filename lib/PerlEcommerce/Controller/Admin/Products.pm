package PerlEcommerce::Controller::Admin::Products;
use Mojo::Base 'PerlEcommerce::Controller';
use PerlEcommerce::I18N;

sub index {
  my $self = shift;
  my @products = $self->model('product')->all;
  my %params = (
    products => \@products
  );
   print "\n\n\nsdfsdfsdfsdf\n\n\n";
  $self->render(%params, @_);
}

sub show {
  my $self = shift;
  my $id = $self->param('id');
  my $product = $self->model('product')->find($id);
  $self->render({ product => $product });
}

sub create {
    my $self = shift;
    my $conf = $self->stash('config'); # $conf->{database}
    my %params;
    print "\n\nCREATING PRODUCT\n\n";
    my %defaults = (
        'name'           => undef,
        'description'    => '', 
        'price'          => 0
    );
    my %permissible = (
        'defaultaliases' => [ 'on', 'off' ],
        'backupmx'       => [ 'on', 'off' ],
    );

    # Validate parameters
    # TODO factor out to Ashafix::Controller?
    while(my ($field, $def) = each %defaults) {
        my $val = $self->param($field) // $defaults{$field};
        $val = $defaults{$field} unless length $val;
        if(defined $val and exists $permissible{$field}) {
            # Likely a hacking attempt, no need to be user friendly
            grep { $_ eq $val } @{$permissible{$field}} or
            die "Invalid value `$val' given for `$field'";
        }
        $params{$field} = $val;
    }

    # TODO RESTful
    $self->req->method =~ /^(?:GET|HEAD)/ and return $self->render(%params);

    #try {
        $self->model('product')->create(%params);
        #$self->show_info_l('Create Success');
    #} catch {
    #    print "ERROR$_";
        #$self->show_error($self->handle_exception($_));
    #11};
    return $self->render(%params, template => 'admin/products/show');
}

sub _get_products {
  return shift;
}

1;
