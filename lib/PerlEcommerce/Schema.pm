package Ashafix::Schema;
use strict;
use warnings;
use DBIx::Simple;
use Carp qw/ croak /;
use Mojo::Loader;
use Try::Tiny;

my $DB;
my @connectargs;

sub new {
    my $class = shift;
    my %config = @_;

    foreach(qw/ dsn user password tabledefs newquota /) {
        croak "No `$_' was passed!" unless defined $config{$_};
    }

    my $self = bless {}, $class;

    unless($DB) {
        @connectargs = @config{qw/dsn user password/};
        $DB = _connect(@connectargs);
        $self->_setup_dbms_specifics($DB, $config{dsn});

        my $modules = [
            grep { $_ ne 'Ashafix::Schema::Base' } @{Mojo::Loader->search('Ashafix::Schema')}
        ];
        foreach my $pm (@$modules) {
            my $e = Mojo::Loader->load($pm);
            croak "Loading `$pm' failed: $e" if ref $e;
            my ($basename) = $pm =~ /.*::(.*)/;
            $self->{modules}{lc $basename} = $pm->new(\%config);
        }
        $self->{modules}{''} = $self;
    }
    return $self;
}

sub schema {
    my ($self, $schema) = @_;
    return $self->{modules}{$schema // ''} || croak "Unknown schema `$schema'";
}

sub error { $DB->error }

sub schemas { return grep { $_ ne '' } keys %{$_[0]->{modules}} }

sub query {
    my @query = @_;
    print STDERR "QUERY: $query[0] ", ($#query >=1 ? "[@query[1 .. $#query]]" : ''), "\n";
    try {
        $DB->query(@query);
    } catch {
        /server has gone away/ and $DB = _connect(@connectargs);
        $DB->query(@query);
    };
}

sub begin { $DB->begin }
sub commit { $DB->commit }
sub rollback { $DB->rollback }

sub _connect {
  my $db = DBIx::Simple->connect(@_, { RaiseError => 1 }
  ) or die DBIx::Simple->error;
  return $db;
}

sub _setup_dbms_specifics {
  my ($self, $db, $dsn) = @_;
  my $dbh = $db->dbh;
  my ($driver) = $dsn =~ /DBI:([^:]+):/i;
  if('Pg' eq $driver) {
      $dbh->{pg_bool_tf} = 0; 
      return;
  }
}

1;
