package PerlEcommerce::Schema::Base;
use 5.010;
use strict;
use warnings;
use Carp qw/ croak /;

my $TABLEDEFS;  

sub new {
    my ($class, $config) = @_;
    $TABLEDEFS //= $config->{tabledefs} or croak "config is missing `tabledefs' member";

    no strict 'refs';
    while(my ($name, $sql) = each %{"${class}::queries"}) {
        $sql = _edit_sql($sql, $TABLEDEFS);
        *{"${class}::$name"} = sub { shift; return PerlEcommerce::Schema::query($sql, @_) };
    }
    
    $_ = _edit_sql($_, $TABLEDEFS) foreach(values %{"${class}::snippets"});

    return bless [], $class;
}

sub sql_in_clause_bindparams {
    return ' IN (' . join(',', ('?') x (@_ - 1)) . ') ';
}

sub raw_query {
    my ($self, $query) = (shift, shift);
    return PerlEcommerce::Schema::query(_edit_sql($query, $TABLEDEFS), @_);
}

sub _edit_sql {
    local $_ = $_[0];
    s/%table_(\w+)/$_[1]->{$1}/eg;
    s/\n/ /g;
    s/\s\s*/ /g;
    return $_;
}

1;
