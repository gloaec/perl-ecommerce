package PerlEcommerce::Model::Product;
use Mojo::Base 'PerlEcommerce::Model::Base';
use PerlEcommerce::Result::Product;

#sub all { return shift->schema('product')->all->hashes }

sub find { return shift->schema('product')->find(shift)->hash }

sub create {
    my $self = shift;
    my %params = @_;
    my $r = PerlEcommerce::Result::Product->new(@_);
    
    1 == $self->schema('product')->insert(
        @params{qw/name description price permalink meta_description meta_keywords count_on_hand available_on/}
    )->rows
        or $self->throw('Product_result_error',
            # TODO is this error the same for PostgreSQL?
            # TODO localize
            (/Duplicate entry '[^']*' for key 'PRIMARY'/ ? ' Already exists' : '') .
            " (" . $r->domain . ")"
        );
    return $r;
}

1;
