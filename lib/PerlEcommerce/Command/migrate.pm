package PerlEcommerce::Command::migrate;
use Mojo::Base 'PerlEcommerce::Command';
use Mojo::Base 'PerlEcommerce';
use Mojo::Util 'class_to_path';
use Mojolicious::Plugin::Config;
use File::Spec;
use Getopt::Long qw(GetOptionsFromArray :config no_ignore_case no_auto_abbrev);   # Match Mojo's commands
use Text::Template;
use File::Basename 'dirname';
use Data::Dumper;
use PerlEcommerce::Schema;
use DBI;

sub run {
  my $self = shift;
  $self->setup_plugins;
  my $dbconfig = $self->config('database');
  my $drh = DBI->install_driver("mysql");
  my $dbdir = join '/', File::Spec->splitdir(dirname(__FILE__)), '../../..', 'db';

  print "\n===> Creating Database : $dbconfig->{name}\n";
  my $template = Text::Template->new(TYPE => 'FILE', SOURCE => join '/', $dbdir, 'create.sql.tmpl');
  my $text = $template->fill_in(HASH => $dbconfig);
  foreach my $val (split('\n',$text)) {
    print "SQL> ${val}\n";
  }
  my $rc = $drh->func('createdb', $dbconfig->{name}, $dbconfig->{host}, $dbconfig->{user}, $dbconfig->{password}, 'admin');

  my $dsn = "DBI:mysql:database=$dbconfig->{name};host=$dbconfig->{host};port=$dbconfig->{port}";
  my $dbh = DBI->connect($dsn, $dbconfig->{user}, $dbconfig->{password});
  my $sth;

  print "\n===> Migrating Tables\n";
  $template = Text::Template->new(TYPE => 'FILE', SOURCE => join '/', $dbdir, 'migrate.sql.tmpl');
  $text = $template->fill_in(HASH => $dbconfig);

  $text =~ s/--.*\n//g;
  $text =~ s/[\s\n\r\t]+/ /g;
  $text =~ s/;[\s\n\r\t]+;//g;
  $text =~ s/^\s+//;
  $text =~ s/\s+$//;

  foreach my $statement (split(';',$text)) {
    $statement =~ s/^\s+//;
    $statement =~ s/\s+$//;
    print "SQL> ${statement}\n";
    $sth = $dbh->prepare($statement);
    $sth->execute;
  }

  print "\n===> Seeding Data\n";
  $template = Text::Template->new(TYPE => 'FILE', SOURCE => join '/', $dbdir, 'seeds.sql.tmpl');
  $text = $template->fill_in(HASH => $dbconfig);

  $text =~ s/--.*\n//g;
  $text =~ s/[\s\n\r\t]+/ /g;
  $text =~ s/;[\s\n\r\t]+;//g;
  $text =~ s/^\s+//;
  $text =~ s/\s+$//;

  foreach my $statement (split(';',$text)) {
    $statement =~ s/^\s+//;
    $statement =~ s/\s+$//;
    print "SQL> ${statement}\n";
    $sth = $dbh->prepare($statement);
    $sth->execute;
  }
  $sth->finish;
  print "\n===> Done.\n";
}

1;
