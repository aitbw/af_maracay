# Alianza Francesa de Maracay

Esta es una aplicación web diseñada para la Alianza Francesa de Maracay como parte del Trabajo Especial de Grado II (TEG II) para optar al titulo de Ingeniería en Información de la Universidad Tecnológica del Centro (UNITEC) con el objetivo de gestionar los procesos administrativos de la organización de una manera rápida y eficiente.

Hecho con ♥ por Angel Perez, desde Venezuela.

# Stack

Esta aplicación está constituida de las siguientes tecnologías:
* [Sinatra](https://github.com/sinatra/sinatra)
* [MySQL](https://www.mysql.com/)
* [ActiveRecord](https://github.com/janko-m/sinatra-activerecord)
* [Foundation by ZURB](http://foundation.zurb.com/)

# Instalación
* Clona este repositorio
* Crea una base de datos en MySQL
* Añade a tu *environment* cuatro (4) variables para la base de datos, usuario, *password* y URL de MySQL
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
* En tu base de datos, crea una tabla llamada 'usuarios' con los siguientes campos:
  * idUsuario
  * nombreUsuario
  * cedulaUsuario
  * passwordUsuario
  * nivelAcceso

* Corre en la consola:

``` shell
bundle install
```

* Ahora ejecuta el siguiente comando:

``` shell
rake db:create
```

* Finalmente, inicia el app:

``` shell
ruby app.rb
```

Puedes ver el app en http://localhost:4567

**NOTA**: Debes eliminar los controladores *check_session* y *restrict_access* de *app.rb* para acceder al panel de control y crear un usuario con permisos administrativos. De lo contrario, no podrás acceder al sistema. No olvides agregar los controladores de nuevo una vez hecho esto. :)

# Uso
Esta aplicación web permite:
* Crear, modificar y eliminar usuarios (Administradores)
* Cambio de contraseña
* Control de cuotas e inscripciones estudiantiles
* Control de estudiantes
* Control de secciones
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