# Alianza Francesa de Maracay

Esta es una aplicación web diseñada para la Alianza Francesa de Maracay como parte del Trabajo Especial de Grado II (TEG II) para optar al titulo de Ingeniería en Información de la Universidad Tecnológica del Centro (UNITEC) con el objetivo de gestionar los procesos administrativos de la organización de una manera rápida y eficiente.

Hecho con ♥ por Angel Perez, desde Venezuela.

[English](./README.en.md) | [Français](./README.fr.md)

# Stack

Esta aplicación está constituida de las siguientes tecnologías:
* [Sinatra](https://github.com/sinatra/sinatra)
* [MySQL](https://www.mysql.com/)
* [ActiveRecord](https://github.com/janko-m/sinatra-activerecord)
* [Bootstrap](http://getbootstrap.com/)

# Instalación
* Clona este repositorio
* Añade a tu *environment* tres (3) variables para la base de datos, usuario y *password* de MySQL
* En tu *environment* también añade lo siguiente:

``` shell
mysql2://{username}:{password}@{host}/{database}
```

* Accede a la carpeta del proyecto
* En /config, crea un 'database.yml' y agrega lo siguiente:

``` yaml
development:
  adapter: mysql2
  encoding: utf8
  reconnect: false
  database: <%= ENV['tu_variable'] %>
  pool: 5
  username: <%= ENV['tu_variable'] %>
  password: <%= ENV['tu_variable'] %>
  socket: /var/run/mysqld/mysqld.sock
  host: localhost
```

* Asegúrate de tener los siguientes paquetes instalados:

``` shell
mysql-server libmysqlclient-dev
```

De lo contrario, instálalos antes de proceder.

* Asegúrate de que Bundler está instalado. Luego, corre en la consola:

``` shell
bundle install
```

* Ahora ejecuta el siguiente comando:

``` shell
rake db:setup
```

* Finalmente, inicia el app:

``` shell
ruby app.rb
```

Puedes ver el app en http://localhost:4567/signin iniciando sesión con los siguientes datos:
* Cédula: 123456
* Password: 123

# Uso
Esta aplicación web permite:
* Crear, modificar y eliminar usuarios (Administradores)
* Cambio de contraseña
* Control de cuotas e inscripciones estudiantiles
* Control de estudiantes y sus calificaciones
* Control de cursos
* Control de profesores y sus horas laborales
* Control de salarios (Administradores)
* Control de inventario
* Generación de reportes (Administradores)

Esta app puede ser empleada en otras sedes de la Alianza Francesa donde se requiera de un sistema administrativo o en instituciones educativas con necesidades similares.

# ¿Cómo colaborar?
* Copia este repositorio
* Añade el *feature* o *bugfix* que realizaste
* Añade *tests*, así me aseguro de que todo funciona como es debido
* Commit!
* Enviame un *pull request*

# Licencia
[AGPL](./LICENSE) ♥

# Social
Puedes seguirme en Twitter como [@AITBW](https://twitter.com/AITBW)
