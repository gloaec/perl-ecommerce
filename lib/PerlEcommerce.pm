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
  my $rr, my $rrr;
  push @{$r->namespaces}, 'PerlEcommerce::Controller';

  $r->route('/')          ->via('GET')   ->to('main#index')      ->name('root');

  $rr = $r->route('/products')         ->to('products#');
  $rr->route('/')        ->via('GET')   ->to('#index')          ->name('products'); 
  $rr->route('/:id')     ->via('GET')   ->to('#show')           ->name('product');

  # === BackOffice === #

  $rr = $r->route('/admin')              ->to('admin#');
  $rr->route('/')         ->via('GET')   ->to('#index')          ->name('admin_root');
  
  $rrr = $rr->route('/products')         ->to('admin-products#');
  $rrr->route('/')        ->via('GET')   ->to('#index')          ->name('admin_products'); 
  $rrr->route('/')        ->via('POST')  ->to('#create')         ->name('create_admin_product');
  $rrr->route('/new')     ->via('GET')   ->to('#new')            ->name('new_admin_product');
  $rrr->route('/:id')     ->via('GET')   ->to('#show')           ->name('admin_product');
  $rrr->route('/:id')     ->via('PUT')   ->to('#update')         ->name('update_admin_product');
  $rrr->route('/:id')     ->via('DELETE')->to('#delete')         ->name('delete_admin_product');
  $rrr->route('/:id/edit')->via('GET')   ->to('#edit')           ->name('edit_admin_product');
  #$self->subresources($res, 'products');
  #$self->resources('products');
#
#  $r2 = $r->route('/admin')->to('admin#index')->name('admin#index'); 
#  $self->subresources($r2, 'products'),
#
#  $self->resources(foo => {
#    'bar' => '*',
#    'bor' => {
#      except => ['show']
#    },
#    only => ['new','create']
#  });
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
        app         => $self,
        root_schema => PerlEcommerce::Schema->connection(
	    #dsn         => 
	    "dbi:$config->{type}:database=$config->{name};host=$config->{host};user=$config->{user};password=$config->{password}"
	    #user        => $config->{user},
	    #password    => $config->{password},
	    #tabledefs   => $self->config('database_tables'),
	    #newquota    => $self->config('new_quota_table'),
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
  $res->route('')             ->via('GET')   ->to(action => 'index')        ->name($controller.'#index'); 
  $res->route('/new')         ->via('GET')   ->to(action => 'new')          ->name($controller.'#new');
  $res->route('')             ->via('POST')  ->to(action => 'create')       ->name($controller.'#create'); 
  $res->route('/:id')         ->via('GET')   ->to(action => 'show')         ->name($controller.'#show'); 
  $res->route('/:id/edit')    ->via('GET')   ->to(action => 'edit')         ->name($controller.'#edit'); 
  $res->route('/:id')         ->via('PUT')   ->to(action => 'update')       ->name($controller.'#update'); 
  $res->route('/:id')         ->via('DELETE')->to(action => 'delete')       ->name($controller.'#delete'); 
}

sub subresources {
  my ($self, $r, $controller) = @_;
  my $res = 
    $r->route('/'.$controller)->to(controller => $controller);
  
  if(ref(\$controller) eq 'SCALAR'){
    $res->route('')             ->via('GET')   ->to(action => 'index')        ->name($controller.'#index'); 
    $res->route('/new')         ->via('GET')   ->to(action => 'new')          ->name($controller.'#new');
    $res->route('')             ->via('POST')  ->to(action => 'create')       ->name($controller.'#create'); 
    $res->route('/:id')         ->via('GET')   ->to(action => 'show')         ->name($controller.'#show'); 
    $res->route('/:id/edit')    ->via('GET')   ->to(action => 'edit')         ->name($controller.'#edit'); 
    $res->route('/:id')         ->via('PUT')   ->to(action => 'update')       ->name($controller.'#update'); 
    $res->route('/:id')         ->via('DELETE')->to(action => 'delete')       ->name($controller.'#delete'); 
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
