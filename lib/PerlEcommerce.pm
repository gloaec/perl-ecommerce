package PerlEcommerce;
use Mojo::Base 'Mojolicious';
use Mojolicious::Plugin::TtRenderer::Engine;
use Mojolicious::Plugin::Config;
use PerlEcommerce::Model;
use PerlEcommerce::Controller;
use Data::Dumper;

my $VERSION = '0.0.1';

sub startup {
  my $self = shift;
  
  $self->setup_plugins;
  $self->setup_model;
  $self->setup_routing;
  $self->setup_hooks;
}

sub setup_plugins {
  my $self = shift;
  my $config = $self->plugin(Config => { file => 'perl-ecommerce.conf' });
  $self->renderer->default_handler('tt');
  $self->controller_class('PerlEcommerce::Controller');
  $self->app->secret($config->{secret});
  $self->sessions->cookie_name('perlecommerce');
  $self->plugin('FormFields');
  $self->plugin('I18N' => { default => 'en'});
  $self->defaults(layout => 'store');
  $self->helper(sprintf => sub {
    shift;
    my $fmt = shift;
    return sprintf($fmt, @_)
  });
}

sub setup_routing {
  my $self = shift;
  my $r = $self->routes;
  my ($rr, $rrr, $rrrr);
  push @{$r->namespaces}, 'PerlEcommerce::Controller';

  # === Routes === # TODO : Support "resources" - PUT/DELETE Fake routing

  $r->route('/') ->via('GET') ->to('main#index') ->name('root');

  $rr = $r->route('/products') ->to('products#');
  $rr->route('/') ->via('GET') ->to('#index') ->name('products');
  $rr->route('/:id') ->via('GET') ->to('#show') ->name('product');

  # === BackOffice === #

  $rr = $r->route('/admin') ->to('admin#');
  $rr->route('/') ->via('GET') ->to('#index') ->name('admin_root');
  
  $rrr = $rr->route('/products') ->to('admin-products#');
  $rrr->route('/') ->via('GET') ->to('#index') ->name('admin_products');
  $rrr->route('/') ->via('POST') ->to('#create') ->name('create_admin_product');
  $rrr->route('/new') ->via('GET') ->to('#new') ->name('new_admin_product');
  $rrr->route('/:id_product') ->via('GET') ->to('#show') ->name('admin_product');
  $rrr->route('/:id_product') ->via('POST') ->to('#update') ->name('update_admin_product');
  $rrr->route('/:id_product/delete')->via('GET') ->to('#delete') ->name('delete_admin_product');
  $rrr->route('/:id_product/edit') ->via('GET') ->to('#edit') ->name('edit_admin_product');
# $rrr->route('/:id') ->via('PUT') ->to('#update') ->name('update_admin_product');
# $rrr->route('/:id') ->via('DELETE')->to('#delete') ->name('delete_admin_product');
  
  $rrrr = $rrr->route('/:id_product/images') ->to('admin-products-images#');
  $rrrr->route('/') ->via('GET') ->to('#index') ->name('admin_product_images');
  $rrrr->route('/') ->via('POST') ->to('#create') ->name('create_admin_product_image');
  $rrrr->route('/new') ->via('GET') ->to('#new') ->name('new_admin_product_image');
  $rrrr->route('/:id_image') ->via('GET') ->to('#show') ->name('admin_product_image');
  $rrrr->route('/:id_image') ->via('POST') ->to('#update') ->name('update_admin_product_image');
  $rrrr->route('/:id_image/delete') ->via('GET') ->to('#delete') ->name('delete_admin_product_image');
  $rrrr->route('/:id_image/edit') ->via('GET') ->to('#edit') ->name('edit_admin_product_image');
}

sub setup_hooks {
  my ($self) = @_;
  
  $self->hook(before_dispatch => sub {
    #TODO: Allow hook methods
  });
}

sub setup_model {
    my $self = shift;
    my $config = $self->config('database');
    my $model = PerlEcommerce::Model->new(
        app => $self,
        root_schema => PerlEcommerce::Schema->connection(
          "dbi:$config->{type}:database=$config->{name};host=$config->{host};user=$config->{user};password=$config->{password}"
        )
    );
    $self->helper(model => sub { $model->model($_[1]) });
    $self->helper(schema => sub { $model->schema($_[1]) });
}

sub resources {
  my ($self, $controller) = @_;
  my $r = $self->routes;
  my $res =
    $r->route('/'.$controller)->to(controller => $controller);
  $res->route('') ->via('GET') ->to(action => 'index') ->name($controller.'#index');
  $res->route('/new') ->via('GET') ->to(action => 'new') ->name($controller.'#new');
  $res->route('') ->via('POST') ->to(action => 'create') ->name($controller.'#create');
  $res->route('/:id') ->via('GET') ->to(action => 'show') ->name($controller.'#show');
  $res->route('/:id/edit') ->via('GET') ->to(action => 'edit') ->name($controller.'#edit');
  $res->route('/:id') ->via('PUT') ->to(action => 'update') ->name($controller.'#update');
  $res->route('/:id') ->via('DELETE')->to(action => 'delete') ->name($controller.'#delete');
}

sub subresources {
  my ($self, $r, $controller) = @_;
  my $res =
    $r->route('/'.$controller)->to(controller => $controller);
  
  if(ref(\$controller) eq 'SCALAR'){
    $res->route('') ->via('GET') ->to(action => 'index') ->name($controller.'#index');
    $res->route('/new') ->via('GET') ->to(action => 'new') ->name($controller.'#new');
    $res->route('') ->via('POST') ->to(action => 'create') ->name($controller.'#create');
    $res->route('/:id') ->via('GET') ->to(action => 'show') ->name($controller.'#show');
    $res->route('/:id/edit') ->via('GET') ->to(action => 'edit') ->name($controller.'#edit');
    $res->route('/:id') ->via('PUT') ->to(action => 'update') ->name($controller.'#update');
    $res->route('/:id') ->via('DELETE')->to(action => 'delete') ->name($controller.'#delete');
  }
  elsif(ref(\$controller) eq 'HASH') {
    while(my (%controller, $child_controller) = each %$controller) {
      use Data::Dumper;
      local $Data::Dumber::Terse = 1;
      $controller = Dumper(%controller);
      #$controller = keys($controller);
    }
  }
  #TODO: define methods to automatically route the models with their respective controller
}

1;

=head1 NOM

package I<PerlEcommerce> - module d'exemple commenté avec Pod

=head1 SYNOPSIS

Afin de lancer le serveur, vous devrez utiliser un script executable comme celui ci-dessous :

	#!/usr/bin/env perl
	use Mojo::Base -strict;
	use File::Basename 'dirname';
	use File::Spec;
	use lib join '/', File::Spec->splitdir(dirname(__FILE__)), 'lib';
	use lib join '/', File::Spec->splitdir(dirname(__FILE__)), '..', 'lib';
	
	# Application
	$ENV{MOJO_APP} ||= 'PerlEcommerce';
	
	# Start commands
	my $commands = Mojolicious::Commands->new;
	push @{$commands->namespaces}, 'PerlECommerce::Command';
	
	Mojolicious::Commands->start_app($ENV{MOJO_APP}, 'daemon', '-l', 'http://*:8080');

=head1 DESCRIPTION

Ce module permet la mise en place d'un serveur proposant une application de ecommerce clés en main.

La documentation est réalisée avec B<Pod>

=head2 Fonctions

=over 4

=item startup()

Permet de démarrer le serveur. Example: C<print PerlEcommerce::startup();>

=item setup_plugins()

Configure tous les plugins dont dépend l'application. Example: C<print PerlEcommerce::setup_plugins();>
Pour ajouter un plugin, référez vous à la documentation du gestionnaire de plugins 
L<Mojolicious::Plugins |http://mojolicio.us/perldoc/Mojolicious/Plugins>

=item setup_routings()

Définit toutes les routes de l'application. Example: C<print PerlEcommerce::setup_plugins();>
Pour la définition des routes, référez vous à la documentation du gestionnaire de routes
L<Mojolicious::Routes |http://mojolicio.us/perldoc/Mojolicious/Routes>

=item setup_hooks()

Définit les hooks de l'application.
Pour la définition d'un hook, référez vous à la documentation:
L<Mojolicious#hook |http://mojolicio.us/perldoc/Mojolicious#hook>

=item setup_model()

Instancie le modèle de données. Toutes les entités tu schema sont alors accessible via le 
L<DBIx::Class::Schema::Loader |http://search.cpan.org/~genehack/DBIx-Class-Schema-Loader-0.07035/lib/DBIx/Class/Schema/Loader.pm>

=item resources($controller_name) 

Facilite la définition de routes en générant automatiquement les urls RESTful pour chacune 
des méthodes CRUD et chacune des vues: index, show, edit. Example :

	$self->resources('products');
	
	$self->resources(foo => {
	    'bar' => '*',
	    'bor' => {
	    except => ['show']
	  },
	  only => ['new','create']
	});

=back

=head1 AUTEUR

Ghislain Loaec

=head1 VOIR AUSSI

L<PerlEcommerce::Model |PerlEcommerce::Model>

L<PerlEcommerce::Controller |PerlEcommerce::Controller>

L<PerlEcommerce::Schema |PerlEcommerce::Schema>

L<PerlEcommerce::Command |PerlEcommerce::Command>

L<PerlEcommerce::I18N |PerlEcommerce::I18N>

=cut
