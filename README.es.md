# Alianza Francesa Maracay

Esta es una aplicación web diseñada para la Alianza Francesa de Maracay como parte del Trabajo Especial de Grado II (TEG II) para optar al titulo de Ingeniería en Información de la Universidad Tecnológica del Centro (UNITEC) con el objetivo de gestionar los procesos administrativos de la organización de una manera rápida y eficiente.

Hecho con ♥ por Angel Perez, desde Venezuela.

## Tabla de contenidos
* [Stack](#stack)
* [Instalación](#instalación)
* [Uso](#uso)
* [Traducciones](#traducciones)
* [¿Cómo colaborar?](#cómo-colaborar)
* [Social](#social)

## Stack
Esta aplicación está constituida de las siguientes tecnologías:
* [Sinatra](http://www.sinatrarb.com/)
* [PostgreSQL](https://www.postgresql.org/)
* [ActiveRecord](http://guides.rubyonrails.org/active_record_basics.html) + [Sinatra ActiveRecord](https://github.com/janko-m/sinatra-activerecord)
* [Bootstrap](http://getbootstrap.com/)

## Instalación
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

* Asegúrate de tener PostgreSQL instalado (versión 8.3 o mayor, ya que esta aplicación utiliza 'hstore' para llevar control de los salarios de los profesores)

De lo contrario, ejecuta la acción pertinente a tu SO antes de continuar.

* Asegúrate de que la versión de Ruby instalada sea la 2.3.0; si usas [RVM](https://rvm.io/), puedes instalarla ejecutando el siguiente comando:

``` shell
rvm install 2.3.0
```

Si no quieres instalarla, elimina `ruby '2.3.0'` del Gemfile

* Asegúrate de que [Bundler](bundler.io) está instalado. Luego, corre en la consola:

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

## Uso
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

## Traducciones
Esta guía también está disponible en los siguientes idiomas:
* [English](./README.md)
* [Français](./README.fr.md)

## ¿Cómo colaborar?
* Clona este repositorio
* Añade el *feature* o *bugfix* que realizaste
* Añade *tests*, así me aseguro de que todo funciona como es debido
* Commit!
* Enviame un *pull request*

## Social
Puedes seguirme en Twitter como [@AITBW](https://twitter.com/AITBW)
