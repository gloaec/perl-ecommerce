package PerlEcommerce::Command::seed;
use Mojo::Base 'PerlEcommerce::Command';
use Mojo::Base 'PerlEcommerce';
use Mojo::Util 'class_to_path';
use Mojolicious::Plugin::Config;
use File::Spec;
use Getopt::Long qw(GetOptionsFromArray :config no_ignore_case no_auto_abbrev);   # Match Mojo's commands
use Text::Template;
use File::Basename 'dirname';
use Data::Dumper;
#use PerlEcommerce::Schema;
use DBI;
use DBIx::Class::Schema::Loader qw/ make_schema_at /;
use Term::ANSIColor;


sub run {
  my $self = shift;
  $self->setup_plugins;
  my $dbconfig = $self->config('database');
  my $drh = DBI->install_driver("mysql");
  my $dbdir = join '/', File::Spec->splitdir(dirname(__FILE__)), '../../..', 'db';
  my $dsn = "DBI:mysql:database=$dbconfig->{name};host=$dbconfig->{host};port=$dbconfig->{port}";
  my $dbh = DBI->connect($dsn, $dbconfig->{user}, $dbconfig->{password});
  my $sth;
  print color('reset'), "\n===> Seeding Data\n";
  my $template = Text::Template->new(TYPE => 'FILE', SOURCE => join '/', $dbdir, 'seeds.sql.tmpl');
  my $text = $template->fill_in(HASH => $dbconfig);

  $text =~ s/--.*\n//g;
  $text =~ s/[\s\n\r\t]+/ /g;
  $text =~ s/;[\s\n\r\t]+;//g;
  $text =~ s/^\s+//;
  $text =~ s/\s+$//;

  foreach my $statement (split(';',$text)) {
    $statement =~ s/^\s+//;
    $statement =~ s/\s+$//;
    print color('reset bold bright_cyan'), "SQL> ", color('reset cyan'), $statement, color('reset red'), "\n";
    $sth = $dbh->prepare($statement);
    $sth->execute;
  }
  $sth->finish;
  print color('reset'), "\n===> Done.\n";
}

1;
