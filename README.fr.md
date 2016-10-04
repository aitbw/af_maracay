# Alliance Française de Maracay

C'est une application web développée pour l'Alliance Française de Maracay comme travail de thèse pour obtenir le diplôme d'Ingénerie en Information à l'Universidad Tecnológica del Centro (Université Technlógique du Centro) afin de réaliser des tâches administratives de l'institution d'une manière rapide et efficace.

Fait avec ♥ par Angel Perez, de Venezuela.

[Español](./README.md) | [English](./README.en.md)

# Stack

Cette application a été développée avec les technologies suivantes:
* [Sinatra](http://www.sinatrarb.com/)
* [PostgreSQL](https://www.postgresql.org/)
* [ActiveRecord](http://guides.rubyonrails.org/active_record_basics.html) + [Sinatra ActiveRecord](https://github.com/janko-m/sinatra-activerecord)
* [Bootstrap](http://getbootstrap.com/)

# Installation
* *Fork* ce repo
* Sur votre environnement, ajoutez 3 variables pour le nom d'utilisateur, mot de passe et base de données de PostgreSQL
* Allez au dossier du projet
* Sur /config, créez un fichier nommé 'database.yml', et ajoutez l'information suivante:

``` yaml
development:
  adapter: postgresql
  encoding: utf8
  reconnect: false
  database: <%= ENV['votre_variable'] %>
  pool: 5
  username: <%= ENV['votre_variable'] %>
  password: <%= ENV['votre_variable'] %>
  host: localhost
  port: 5432
  url: postgres://localhost/<%= ENV['votre_variable'] %>?pool=5
```

* Si vous utilisez Ubuntu (ou une des ses variantes), assurez que vous ayez les *packages* suivants installés:

``` shell
postgresql postgresql-contrib postgresql-server-dev-9.5
```

* Si vous utilisez Arch (ou une des ses variantes), suivez ce [guide](https://wiki.archlinux.org/index.php/PostgreSQL)

Ou contraire, exécutez l'action correspondante à votre SO avant de continuer.

* Assurez que Bundler soit installé. Après, exécutez la commande suivante:

``` shell
bundle install
```

* Maintenant, créez la base de données, chargez le schéma et des informations nécessaires:

``` shell
rake db:setup
```

* Finalement, commencez l'application:

``` shell
ruby app.rb
```

Vouz pouvez commencer à utiliser l'application sur http://localhost:4567/signin avec:
* ID: 123456
* Mot de passe: 123

# Usage
Cette application vous permet de:
* Créer, modifier et éliminer utilisateurs (Admins)
* Changer de mot de passe
* Administrer les inscriptions et frais des étudiants
* Administrer les étudiants et leurs notes
* Administrer les cours
* Administrer les professeurs et leurs heures de travail
* Administrer les salaires (Admins)
* Administrer l'inventaire
* Générer des rapports (Admins)

Cette application peut être utilisée sur autres sièges de l'Alliance Française où un système administratif est nécessaire ou dans des institutions avec des besoins similaires.

# Comment pouvez-vous aider?
* *Fork* ce repo
* Ajoutez la caractéristique ou *bugfix* que vous avez realisé
* N'oubliez pas de ajouter des *tests* pour que je puisse m'assurer que tout fonctionne correctement
* *Commit!*
* Envoyez-moi une *pull request*

# Social
Vous pouvez me suivre sur Twitter comme [@AITBW](https://twitter.com/AITBW)
