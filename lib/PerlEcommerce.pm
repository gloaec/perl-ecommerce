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
  
  $self->plugin(
    tt_renderer => {
      template_options => {
        PRE_PROCESS => 'header.html.tt',
        POST_PROCESS => 'footer.html.tt',
        EVAL_PERL => 1,
        CONSTANTS => {
          version => $VERSION
        }
      }
    }
  );
  $self->renderer->default_handler('tt');
  $self->controller_class('PerlEcommerce::Controller');
  $self->app->secret($config->{secret});
  $self->sessions->cookie_name('perlecommerce');
  $self->plugin('I18N' => { default => 'en'});    
  $self->helper(sprintf => sub {
    shift; 
    my $fmt = shift;
    return sprintf($fmt, @_)
  });
}

sub setup_routing {
  my $self = shift;
  my $r = $self->routes;
  
  push @{$r->namespaces}, 'PerlEcommerce::Controller';

  $r->route('/')->to('main#index')->name('index');
  
  $self->resources('products');
  $self->resources(foo => {
    'bar' => '*',
    'bor' => {
      except => ['show']
    },
    only => ['new','create']
  });
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
        root_schema => PerlEcommerce::Schema->new(
            dsn         => "DBI:$config->{type}:database=$config->{name};host=$config->{host}",
            user        => $config->{user},
            password    => $config->{password},
            tabledefs   => $self->config('database_tables'),
            newquota    => $self->config('new_quota_table'),
        )
    );
    $self->helper(model => sub { $model->model($_[1]) });
    $self->helper(schema => sub { $model->schema($_[1]) });
}

sub resources {
  my ($self, $controller) = @_;
  my $r = $self->routes;  
  
  if(ref(\$controller) eq 'SCALAR'){
    my $resource = 
           $r->route('/'.$controller)->via('GET')   ->to(controller => $controller)->name($controller.'#index');
           $r->route('/'.$controller)->via('POST')  ->to(controller => $controller, action => 'create')->name($controller.'#create'); 
    $resource->route('')             ->via('GET')   ->to(action => 'index')        ->name($controller.'#index'); 
    $resource->route('/new')         ->via('GET')   ->to(action => 'new')          ->name($controller.'#new');
    $resource->route('')             ->via('POST')  ->to(action => 'create')       ->name($controller.'#create'); 
    $resource->route('/:id')         ->via('GET')   ->to(action => 'show')         ->name($controller.'#show'); 
    $resource->route('/:id/edit')    ->via('GET')   ->to(action => 'edit')         ->name($controller.'#edit'); 
    $resource->route('/:id')         ->via('PUT')   ->to(action => 'update')       ->name($controller.'#update'); 
    $resource->route('/:id')         ->via('DELETE')->to(action => 'delete')       ->name($controller.'#delete'); 
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
