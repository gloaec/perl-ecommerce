use utf8;
package PerlEcommerce::Schema::Result::InventorysUnit;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PerlEcommerce::Schema::Result::InventorysUnit - PerlEcommerce inventorys unit

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<inventorys_unit>

=cut

__PACKAGE__->table("inventorys_unit");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 state

  data_type: 'varchar'
  is_nullable: 0
  size: 40

=head2 lock_version

  data_type: 'integer'
  default_value: 0
  is_nullable: 0

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

=head2 variant_id

  data_type: 'integer'
  is_nullable: 1

=head2 order_id

  data_type: 'integer'
  is_nullable: 1

=head2 shipment_id

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "state",
  { data_type => "varchar", is_nullable => 0, size => 40 },
  "lock_version",
  { data_type => "integer", default_value => 0, is_nullable => 0 },
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
  "variant_id",
  { data_type => "integer", is_nullable => 1 },
  "order_id",
  { data_type => "integer", is_nullable => 1 },
  "shipment_id",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-05-10 16:14:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:poU1zSBEfNePytzeBFUnpQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
