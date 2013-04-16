Perl-ECommerce
==============

Solution e-commerce développée en PERL

Pre-requis
----------

* Perl 
* MySQL

Installation
------------

- 1 `git clone git://github.com/gloaec/perl-ecommerce.git && cd perl-ecommerce` Cloner le projet
- 2 `sudo bash script/bundle` Installer les dépendences
- 3 `cp perl-ecommerce.default.conf perl-ecommerce.conf` Editer la configuration du projet
- 4 `perl script/migrate` Migrer la base de donnée et le jeu de données
- 5 `morbo script/server` Démarrer le serveur de développement

Allez à l'adresse [http://localhost:3000/](http://localhost:3000/)

Vous pouvez lancer le serveur de production directement avec :

    perl script/server

L'adress sera alors [http://localhost:8080/](http://localhost:8080)
