package PerlEcommerce::Model::Product;
use Mojo::Base 'PerlEcommerce::Model::Base';

sub index {
  my $self = shift:
  my %opts = @_;

  #TODO: Fetch products
}

sub show {
  my ($self, $id) = @_;

  #TODO: Get Model with id and render show template
}

sub new {
  my $self = shift:
  my %opts = @_;

  #TODO: Create non-persistant model
}

sub create {
  my $self = shift:
  my %opts = @_;

  #TODO: Create persistant model
}

sub edit {
  my ($self, $id) = @_;

  #TODO: Get model with id and render edit template 
}

sub update {
  my ($self, $id) = @_;

  #TODO: Get model with id and update attributes
}

sub delete {
  my ($self, $id) = @_;

  #TODO: Delete the model from its id
}

1;
