use utf8;
package PerlEcommerce::Schema::Result::Variant;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PerlEcommerce::Schema::Result::Variant - PerlEcommerce Variants

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<variants>

=cut

__PACKAGE__->table("variants");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 sku

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 price

  data_type: 'decimal'
  is_nullable: 0
  size: [5,0]

=head2 weight

  data_type: 'decimal'
  is_nullable: 0
  size: [5,0]

=head2 height

  data_type: 'decimal'
  is_nullable: 0
  size: [5,0]

=head2 width

  data_type: 'decimal'
  is_nullable: 0
  size: [5,0]

=head2 depth

  data_type: 'decimal'
  is_nullable: 0
  size: [5,0]

=head2 deleted_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 is_master

  data_type: 'tinyint'
  is_nullable: 1

=head2 count_on_hand

  data_type: 'integer'
  is_nullable: 0

=head2 cost_price

  data_type: 'decimal'
  is_nullable: 0
  size: [5,0]

=head2 position

  data_type: 'integer'
  is_nullable: 0

=head2 product_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "sku",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "price",
  { data_type => "decimal", is_nullable => 0, size => [5, 0] },
  "weight",
  { data_type => "decimal", is_nullable => 0, size => [5, 0] },
  "height",
  { data_type => "decimal", is_nullable => 0, size => [5, 0] },
  "width",
  { data_type => "decimal", is_nullable => 0, size => [5, 0] },
  "depth",
  { data_type => "decimal", is_nullable => 0, size => [5, 0] },
  "deleted_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
  "is_master",
  { data_type => "tinyint", is_nullable => 1 },
  "count_on_hand",
  { data_type => "integer", is_nullable => 0 },
  "cost_price",
  { data_type => "decimal", is_nullable => 0, size => [5, 0] },
  "position",
  { data_type => "integer", is_nullable => 0 },
  "product_id",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-05-10 16:07:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:69fQnn84mEUVpGUzP2sn3A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
