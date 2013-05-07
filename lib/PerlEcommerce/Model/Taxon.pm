package PerlEcommerce::Model::Taxon;
use Mojo::Base 'PerlEcommerce::Model::Base';
use PerlEcommerce::Result::Taxon;

sub all { return shift->schema('taxon')->all->hashes }

sub find { return shift->schema('taxon')->find(shift)->hash }

sub create {
    my $self = shift;
    my %params = @_;
    my $r = PerlEcommerce::Result::Taxon->new(@_);

    1 == $self->schema('taxon')->insert(
        @params{qw/name/}
    )->rows
        or $self->throw('Taxon_result_error',
            # TODO is this error the same for PostgreSQL?
            # TODO localize
            (/Duplicate entry '[^']*' for key 'PRIMARY'/ ? ' Already exists' : '') .
            " (" . $r->domain . ")"
        );

    return $r;
}

1;
