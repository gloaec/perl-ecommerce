package PerlEcommerce;
use Mojo::Base 'Mojolicious'
use MojoX::Renderer::TT;
use Mojolicious::Plugin::Config;
use PerlEcommerce::Controller;
use PerlEcommerce::Model;

my $VERSION = '0.0.1';

sub startup {
  my $self = shift;
  
  $self->setup_plugins;
  $self->setup_routing;
  $self->setup_hooks;
}

sub setup_plugins {
  my $self = shift;
  my $config = $self->plugin(Config => { file => 'perl-ecommerce.conf' });
  
  $self->plugin(
    tt_renderer => {
      template_options => {
        CONSTANTS => {
          version => $VERSION
        }
      }
    }
  );
  $self->renderer->default_handler('tt');
  $self->controller_class('PerlEcommerce::Controller');
  $self->plugin('I18N' => { default => 'en'});    
}

sub setup_routings {
  my $self = shift;
  my $r = $self->routes;
  
  $r->namespace('PerlEcommerce::Controller');

  $r->route('/')->to('main#index')->name('index');

  $self->resources({
  #  product => {
  #    index  => 'GET#products',
  #    create => 'POST#products',
  #    edit   => 'GET#products',
  #    show   => 'GET#products/:id',
  #    update => 'PUT#products/:id',
  #    delete => 'DELETE#products/:id'
  #  }
  });
}

sub setup_hooks {
  my ($self) = @_;
  
  $self->hook(before_dispatch => sub {
    #TODO: Allow hook methods
  });
}

sub resources {
  my ($self, $desc) = @_;
  my $r = $self->routes;

  #TODO: define methods to automatically route the models with their respective controller
}

1;
