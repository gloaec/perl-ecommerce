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

=head2 permalink

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 meta_description

  data_type: 'text'
  is_nullable: 1

=head2 meta_keywords

  data_type: 'text'
  is_nullable: 1

=head2 count_on_hand

  data_type: 'integer'
  default_value: 0
  is_nullable: 1

=head2 safety_stock

  data_type: 'integer'
  default_value: 10
  is_nullable: 1

=head2 available_on

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 1

=head2 deleted_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 1

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

=head2 taxon_id

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 127 },
  "description",
  { data_type => "text", is_nullable => 0 },
  "permalink",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "meta_description",
  { data_type => "text", is_nullable => 1 },
  "meta_keywords",
  { data_type => "text", is_nullable => 1 },
  "count_on_hand",
  { data_type => "integer", default_value => 0, is_nullable => 1 },
  "safety_stock",
  { data_type => "integer", default_value => 10, is_nullable => 1 },
  "available_on",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 1,
  },
  "deleted_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 1,
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
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "taxon_id",
  { data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-05-16 15:21:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5Xmq67lMeVGSpL1wFEEdWg

__PACKAGE__->has_many(variants => 'PerlEcommerce::Schema::Result::Variant', 'product_id');
__PACKAGE__->has_many(images => 'PerlEcommerce::Schema::Result::Image', 'product_id');

sub master {
  my $self = shift;
  return $self->variants->find({ is_master => 1 }) // $self->variants->new({ product_id => $self->id });
}


1;
