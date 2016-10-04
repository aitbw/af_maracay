# Alianza Francesa de Maracay

Esta es una aplicación web diseñada para la Alianza Francesa de Maracay como parte del Trabajo Especial de Grado II (TEG II) para optar al titulo de Ingeniería en Información de la Universidad Tecnológica del Centro (UNITEC) con el objetivo de gestionar los procesos administrativos de la organización de una manera rápida y eficiente.

Hecho con ♥ por Angel Perez, desde Venezuela.

[English](./README.md) | [Français](./README.fr.md)

# Stack

Esta aplicación está constituida de las siguientes tecnologías:
* [Sinatra](http://www.sinatrarb.com/)
* [PostgreSQL](https://www.postgresql.org/)
* [ActiveRecord](http://guides.rubyonrails.org/active_record_basics.html) + [Sinatra ActiveRecord](https://github.com/janko-m/sinatra-activerecord)
* [Bootstrap](http://getbootstrap.com/)

# Instalación
* Clona este repositorio
* Establece tres (3) variables de entorno para la base de datos, usuario y contraseña de PostgreSQL
* Accede a la carpeta del proyecto
* En /config, crea un archivo nombrado 'database.yml' y agrega lo siguiente:

``` yaml
development:
  adapter: postgresql
  encoding: utf8
  reconnect: false
  database: <%= ENV['tu_base_de_datos'] %>
  pool: 5
  username: <%= ENV['tu_nombre_de_usuario'] %>
  password: <%= ENV['tu_contraseña'] %>
  host: localhost
  port: 5432
  url: postgres://localhost/<%= ENV['tu_base_de_datos'] %>?pool=5
```

* Si usas Ubuntu (o alguno de sus sabores), asegúrate de tener los siguientes paquetes instalados:

``` shell
postgresql postgresql-contrib postgresql-server-dev-9.5
```

* Si usas Arch (o alguna de sus variantes), sigue esta [guia](https://wiki.archlinux.org/index.php/PostgreSQL)

De lo contrario, ejecuta la acción pertinente a tu SO antes de continuar.

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
* Clona este repositorio
* Añade el *feature* o *bugfix* que realizaste
* Añade *tests*, así me aseguro de que todo funciona como es debido
* Commit!
* Enviame un *pull request*

# Social
Puedes seguirme en Twitter como [@AITBW](https://twitter.com/AITBW)
