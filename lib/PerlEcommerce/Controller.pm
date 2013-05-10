package PerlEcommerce::Controller;
use Mojo::Base 'Mojolicious::Controller';
use Carp;

sub index {
  my ($self) = @_;
  my $taxons = $self->schema('product')->all;
  return $self->render(taxons => $taxons);
}

sub show_error  { shift->_add_show( error => join('', @_)) }
sub show_info   { shift->_add_show( info  => join('', @_)) }
sub flash_error { shift->_add_flash(error => join('', @_)) }
sub flash_info  { shift->_add_flash(info  => join('', @_)) }
# Localizing versions of the above
sub show_error_l  { shift->_localize(_add_show  => error => @_) }
sub show_info_l   { shift->_localize(_add_show  => info  => @_) }
sub flash_error_l { shift->_localize(_add_flash => error => @_) }
sub flash_info_l  { shift->_localize(_add_flash => info  => @_) }
sub _localize {
    my ($self, $func, $what, $key) = splice @_,0,4;
    $self->$func($what => join('', $self->l($key), @_));
}

sub _add_show   { push @{$_[0]->stash($_[1])}, $_[2] }
sub _add_flash  {
    my ($self, $what, $msg) = @_;
    my $msgs = $self->flash($what) // [];
    $self->flash($what => [@$msgs, $msg]);
}

sub cfg { $_[0]->app->config->{$_[1]} }

sub handle_exception {
    my ($self, $e) = @_;
    my $msg = $e->message;

    warn "handle_exception($msg) (ref:`".(ref $msg)."'".(ref $msg?" => [@$msg]":'');
    ref $msg eq '' and return $self->l($msg);
    my $localized = shift @$msg;
    $localized = $self->l($localized) if length $localized;
    index $localized, '%' and return sprintf($localized, @$msg);
    return join('', $localized, @$msg);
}

sub auth_get_username {
    my $user = shift->session('user') or return;
    return $user->name;
}

sub auth_has_role {
    my ($self, $role) = @_;
    my $user = $self->session('user') or return;
    return $user->roles->{$role};
}

sub auth_require_role {
    my ($self, $role) = @_;
    return unless $self->auth_require_login;
    return 1 if $self->auth_has_role($role);
    # TODO flash() "Insufficient privileges" or something?
    $self->redirect_to(named => 'login', redirect => $self->url_with);
    return;
}

sub auth_require_login {
    my $self = shift;
    my $user = $self->session('user');
    return 1 if defined($user) && defined($user->name);
    $self->redirect_to(named => 'login', redirect => $self->url_with);
    return;
}

1;
