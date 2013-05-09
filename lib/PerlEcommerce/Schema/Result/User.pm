use utf8;
package PerlEcommerce::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PerlEcommerce::Schema::Result::User - PerlEcommerce Users

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 127

=head2 encrypted_password

  data_type: 'varchar'
  is_nullable: 0
  size: 127

=head2 password_salt

  data_type: 'varchar'
  is_nullable: 0
  size: 127

=head2 remember_token

  data_type: 'varchar'
  is_nullable: 0
  size: 127

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

=head2 persistence_token

  data_type: 'varchar'
  is_nullable: 0
  size: 172

=head2 reset_password_token

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 perishable_token

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 sign_in_count

  data_type: 'integer'
  is_nullable: 0

=head2 failed_attempts

  data_type: 'integer'
  is_nullable: 0

=head2 last_request_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 last_sign_in_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=head2 lasts_sign_in_ip

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 login

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 authentification_token

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 unlock_token

  data_type: 'varchar'
  is_nullable: 0
  size: 90

=head2 locked_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: '0000-00-00 00:00:00'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 127 },
  "encrypted_password",
  { data_type => "varchar", is_nullable => 0, size => 127 },
  "password_salt",
  { data_type => "varchar", is_nullable => 0, size => 127 },
  "remember_token",
  { data_type => "varchar", is_nullable => 0, size => 127 },
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
  "persistence_token",
  { data_type => "varchar", is_nullable => 0, size => 172 },
  "reset_password_token",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "perishable_token",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "sign_in_count",
  { data_type => "integer", is_nullable => 0 },
  "failed_attempts",
  { data_type => "integer", is_nullable => 0 },
  "last_request_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
  "last_sign_in_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
  "lasts_sign_in_ip",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "login",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "authentification_token",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "unlock_token",
  { data_type => "varchar", is_nullable => 0, size => 90 },
  "locked_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "0000-00-00 00:00:00",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-05-09 15:44:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Cb98mqFQpqusbo2wB1cJSg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
