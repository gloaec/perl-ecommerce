use utf8;
package PerlEcommerce::Schema::Result::Product;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PerlEcommerce::Schema::Result::Product - PerlEcommerce Products

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<products>

=cut

__PACKAGE__->table("products");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 127

=head2 description

  data_type: 'text'
  is_nullable: 0

=head2 price

  data_type: 'decimal'
  is_nullable: 0
  size: [11,2]

=head2 permalink

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 meta_description

  data_type: 'text'
  is_nullable: 0

=head2 meta_keywords

  data_type: 'text'
  is_nullable: 0

=head2 count_on_hand

  data_type: 'integer'
  is_nullable: 0

=head2 available_on

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 deleted_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

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

=head2 taxon_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 127 },
  "description",
  { data_type => "text", is_nullable => 0 },
  "price",
  { data_type => "decimal", is_nullable => 0, size => [11, 2] },
  "permalink",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "meta_description",
  { data_type => "text", is_nullable => 0 },
  "meta_keywords",
  { data_type => "text", is_nullable => 0 },
  "count_on_hand",
  { data_type => "integer", is_nullable => 0 },
  "available_on",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
  "deleted_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
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
  "taxon_id",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-05-09 20:07:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:25Wa4BH6zvYHtshryqD/JA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;