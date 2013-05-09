use utf8;
package PerlEcommerce::Schema::Result::Order;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PerlEcommerce::Schema::Result::Order - PerlEcommerce Orders

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<orders>

=cut

__PACKAGE__->table("orders");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 item_total

  data_type: 'decimal'
  is_nullable: 0
  size: [5,0]

=head2 total

  data_type: 'decimal'
  is_nullable: 0
  size: [5,0]

=head2 created_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 updated_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 state

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 adjustement_total

  data_type: 'decimal'
  is_nullable: 0
  size: [5,0]

=head2 credit_total

  data_type: 'decimal'
  is_nullable: 0
  size: [5,0]

=head2 completed_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 payment_total

  data_type: 'decimal'
  is_nullable: 0
  size: [5,0]

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "item_total",
  { data_type => "decimal", is_nullable => 0, size => [5, 0] },
  "total",
  { data_type => "decimal", is_nullable => 0, size => [5, 0] },
  "created_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
  "updated_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
  "state",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "adjustement_total",
  { data_type => "decimal", is_nullable => 0, size => [5, 0] },
  "credit_total",
  { data_type => "decimal", is_nullable => 0, size => [5, 0] },
  "completed_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
  "payment_total",
  { data_type => "decimal", is_nullable => 0, size => [5, 0] },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-05-09 15:44:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:e4x9TRbffo5ecZ/ul2WgDg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
