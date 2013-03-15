SET character_set_client = utf8;

/* DROP TABLES */

DROP TABLE IF EXISTS products;

/* CREATE TABLES */

CREATE TABLE products (
  id       integer(11)  NOT NULL,
  name     varchar(255) NOT NULL,
  created  datetime     NOT NULL DEFAULT '0000-00-00 00:00:00',
  modified datetime     NOT NULL DEFAULT '0000-00-00 00:00:00',
  
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='PerlEcommerce products';
