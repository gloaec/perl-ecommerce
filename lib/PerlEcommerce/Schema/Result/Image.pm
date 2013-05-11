use utf8;
package PerlEcommerce::Schema::Result::Image;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PerlEcommerce::Schema::Result::Image - PerlEcommerce Images

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<images>

=cut

__PACKAGE__->table("images");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 alt_text

  data_type: 'text'
  is_nullable: 0

=head2 position

  data_type: 'integer'
  is_nullable: 0

=head2 type

  data_type: 'varchar'
  is_nullable: 0
  size: 20

=head2 product_id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "alt_text",
  { data_type => "text", is_nullable => 0 },
  "position",
  { data_type => "integer", is_nullable => 0 },
  "type",
  { data_type => "varchar", is_nullable => 0, size => 20 },
  "product_id",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-05-11 13:49:43
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:g4221Cv/mK9AuscMVSRIRg

__PACKAGE__->belongs_to(product => 'PerlEcommerce::Schema::Result::Product', 'product_id');

sub path {
  return "public/img/upload/products/".shift->id."/".shift.".png";
}

sub url {
  return "/img/upload/products/".shift->id."/".shift.".png";
}

1;
