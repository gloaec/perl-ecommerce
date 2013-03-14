package PerlEcommerce::Model;
use strict;
use warnings;
use Carp qw/ croak /;	
use Mojo::Loader;
use Try::Tiny;
use PerlEcommerce::Schema;
use Mojo::Base -base;

has modules => sub { {} };
has 'root_schema';

sub new {
  my $class = shift;
  my %args = @_;    
  my $self = $class->SUPER::new(@_);
  
  foreach my $pm (grep { $_ ne 'PerlEcommerce::Model::Base' } @{Mojo::Loader->search('PerlEcommerce::Model')}) {
    my $e = Mojo::Loader->load($pm);
    croak "Loading `$pm' failed: $e" if ref $e;
    my ($basename) = $pm =~ /.*::(.*)/;
    $self->modules->{lc $basename} = $pm->new(%args);
  }
  return $self;
}

sub model {
    my ($self, $model) = @_;
    return $self->{modules}{$model} || croak "Unknown model `$model'";
}

sub schema {
    my ($self, $schema) = @_;
    return $self->root_schema->schema($schema) || croak "Unknown schema `$schema'";
}

sub schema_err { shift->root_schema->error }

sub models { return grep { $_ ne '' } keys %{$_[0]->{modules}} }

1;
