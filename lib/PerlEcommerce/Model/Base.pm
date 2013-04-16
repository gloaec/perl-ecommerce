package PerlEcommerce::Model::Base;
use Mojo::Base -base;
use Mojo::Exception;
use Carp qw/ croak /;
use Digest::MD5;

has [qw/ app root_schema /];

sub schema {
    my ($self, $schema) = @_;
    return $self->root_schema->schema($schema) || croak "Unknown schema `$schema'";
}

sub dblog { shift->app->db_log(@_) }

sub cfg { $_[0]->app->config->{$_[1]} }

sub throw {
    my $self = shift;
    die Mojo::Exception->new->trace(2)->message(@_ > 1 ? [ @_ ] : $_[0]);
}

sub check_password {
    my ($self, $pw1, $pw2) = @_;
    my $pass_generated;

    if(not length $pw1 and not length $pw2 and $self->cfg('generate_password')) {
        $pw1 = $self->generate_password; 
        $pass_generated = 1;
    } elsif(not length $pw1 or not length $pw2 or $pw1 ne $pw2) {
        $self->throw('pCreate_mailbox_password_text_error');
    } else {
        try {
            $self->check_password_kwalitee($pw1)
        } catch {
            # TODO localize
            $self->throw('', "Password check failed: $@");
        };
    }
    return ($pw1, $pass_generated);
}

sub check_password_kwalitee {
    my ($self, $pw) = @_;
    # Don't bother with all these hand-written regexen and use trusty ol'
    # Cracklib if available. If not, Bad Luck[tm].
    eval "use Crypt::Cracklib ();";
    if($@) {
        6 <= length $pw and return 1;
        die "it is too short\n";
    }
    my $result = Crypt::Cracklib::fascist_check($pw);
    die "$result\n" unless $result eq 'ok';
}

sub check_email_validity {
    my ($self, $uname) = @_;

    my $mvalid = Email::Valid->new(
        -mxcheck => $self->cfg('emailcheck_resolve_domain'),
        -tldcheck => 1
    );
    warn "checking mail address `$uname'";
    return 1 if $mvalid->address($uname);

    (my $domainpart = $uname) =~ s/.*\@//;
    for($mvalid->details) {
        when('fqdn')    { $self->throw(pInvalidDomainRegex  => $domainpart) }
        when('mxcheck') { $self->throw(pInvalidDomainDNS    => $domainpart) }
        default         { $self->throw(pInvalidMailRegex    => ": `$uname'")}
    }
}

sub generate_password { substr(Digest::MD5::md5_base64(rand),0,10) }

1;
