use utf8;
package PerlEcommerce::Schema::Result::Taxon;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PerlEcommerce::Schema::Result::Taxon - PerlEcommerce Taxons

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<taxons>

=cut

__PACKAGE__->table("taxons");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 127

=head2 position

  data_type: 'integer'
  is_nullable: 0

=head2 permalink

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 lft

  data_type: 'integer'
  is_nullable: 0

=head2 rgt

  data_type: 'integer'
  is_nullable: 0

=head2 description

  data_type: 'text'
  is_nullable: 0

=head2 hidden

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=head2 home_page

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 0

=head2 short_name

  data_type: 'varchar'
  is_nullable: 0
  size: 63

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 127 },
  "position",
  { data_type => "integer", is_nullable => 0 },
  "permalink",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "lft",
  { data_type => "integer", is_nullable => 0 },
  "rgt",
  { data_type => "integer", is_nullable => 0 },
  "description",
  { data_type => "text", is_nullable => 0 },
  "hidden",
  { data_type => "tinyint", default_value => 0, is_nullable => 0 },
  "home_page",
  { data_type => "tinyint", default_value => 0, is_nullable => 0 },
  "short_name",
  { data_type => "varchar", is_nullable => 0, size => 63 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-05-10 16:07:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xaaywO6uOkh4xlE7LzwzTQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
