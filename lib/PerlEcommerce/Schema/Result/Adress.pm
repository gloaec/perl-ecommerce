use utf8;
package PerlEcommerce::Schema::Result::Adress;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PerlEcommerce::Schema::Result::Adress - PerlEcommerce adress

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<adress>

=cut

__PACKAGE__->table("adress");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 firstname

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 lastname

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 adress1

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 adress2

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 city

  data_type: 'varchar'
  is_nullable: 0
  size: 30

=head2 state

  data_type: 'varchar'
  is_nullable: 0
  size: 30

=head2 zipcode

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 country

  data_type: 'varchar'
  is_nullable: 0
  size: 25

=head2 phone

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 created_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 updated_at

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "firstname",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "lastname",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "adress1",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "adress2",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "city",
  { data_type => "varchar", is_nullable => 0, size => 30 },
  "state",
  { data_type => "varchar", is_nullable => 0, size => 30 },
  "zipcode",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "country",
  { data_type => "varchar", is_nullable => 0, size => 25 },
  "phone",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "created_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
  "updated_at",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-05-10 16:14:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mr3y32lRdg2+Z1oLptskCA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
