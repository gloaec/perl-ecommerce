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
use DBIx::Class::Schema::Loader qw/ make_schema_at /;
use Term::ANSIColor;


sub run {
  my $self = shift;
  $self->setup_plugins;
  my $dbconfig = $self->config('database');
  my $drh = DBI->install_driver("mysql");
  my $dbdir = join '/', File::Spec->splitdir(dirname(__FILE__)), '../../..', 'db';

  print color('reset'), "\n===> Creating Database : $dbconfig->{name}\n";
  my $template = Text::Template->new(TYPE => 'FILE', SOURCE => join '/', $dbdir, 'create.sql.tmpl');
  my $text = $template->fill_in(HASH => $dbconfig);
  foreach my $statement (split('\n',$text)) {
    print color('bold bright_cyan'), "SQL> ", color('reset cyan'), $statement, color('reset'), "\n";
  }
  my $rc = $drh->func('createdb', $dbconfig->{name}, $dbconfig->{host}, $dbconfig->{user}, $dbconfig->{password}, 'admin');

  my $dsn = "DBI:mysql:database=$dbconfig->{name};host=$dbconfig->{host};port=$dbconfig->{port}";
  my $dbh = DBI->connect($dsn, $dbconfig->{user}, $dbconfig->{password});
  my $sth;

  print color('reset'), "\n===> Migrating Tables\n";
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
    print color('reset bold bright_cyan'), "SQL> ", color('reset cyan'), $statement, color('reset red'), "\n";
    $sth = $dbh->prepare($statement);
    $sth->execute;
   
  }
  
  print color('reset magenta'), "\n";
  make_schema_at(
      'PerlEcommerce::Schema',
      { 
        debug => 1,
        dump_directory => './lib',
      },[ 
        "dbi:mysql:dbname=$dbconfig->{name};host=$dbconfig->{host};user=$dbconfig->{user};password=$dbconfig->{password}", 
        $dbconfig->{user}, 
        $dbconfig->{password}
      ],
  );

  $sth->finish;
  print color('reset'), "\n===> Done.\n";
}

1;
