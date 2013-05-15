package PerlEcommerce::Controller::Users;
use Mojo::Base 'PerlEcommerce::Controller';
use PerlEcommerce::I18N;
use Mojolicious::Plugin::Authentication;


plugin 'authentication' => {

    load_user => sub {

        my ( $self, $uid ) = @_;

        my $sth = $self->db->prepare(' select * from user where user_id=? ');

        $sth->execute($uid);

        if ( my $res = $sth->fetchrow_hashref ) {

            return $res;

        }
        else {

            return;
        }

    },
    validate_user => sub {

        my ( $self, $username, $password ) = @_;

        my $sth
            = $self->db->prepare(' select * from user where user_name = ? ');

        $sth->execute($username);

        return unless $sth;

        if ( my $res = $sth->fetchrow_hashref ) {

            my $salt = substr $password, 0, 2;

            if ( $self->bcrypt_validate( $password, $res->{user_passwd} ) ) {

                $self->session(user => $username);

                #
                # For data that should only be visible on the next request, like
                # a confirmation message after a 302 redirect, you can use the
                # flash.
                #
                
                $self->flash(message => 'Thanks for logging in.');

                return $res->{user_id};

            }
            else {

                return;

            }

        }
        else {

            return;

        }
    },

};  

sub verify {

    my $self = shift;

    if ( not $self->user_exists ) {

        $self->flash( message => 'You must log in to view this page' );

        $self->redirect_to('/');

        return;

    }
    else {

        $self->render( template => 'welcome' );

    }

}
sub login {

    my $self = shift;

    my $user = $self->param('name') || q{};

    my $pass = $self->param('pass') || q{};

    if ( $self->authenticate( $user, $pass ) ) {

        $self->redirect_to('/welcome');

    }
    else {

        $self->flash( message => 'Invalid credentials!' );

        $self->redirect_to('/');

    }

}  

sub logout {

    my $self = shift;

    $self->session( expires => 1 );

    $self->redirect_to('/');

}