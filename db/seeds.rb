# seeds.rb
class Tipo < ActiveRecord::Base
  self.table_name = 'tiposCurso'

  Tipo.create(tipoCurso: 'Intensivo AM 1', diasCurso: 'Lun/Mar/Mie/Jue', horarioCurso: '7:30 - 9:30')
  Tipo.create(tipoCurso: 'Intensivo AM 2', diasCurso: 'Lun/Mar/Mie/Jue', horarioCurso: '10:00 - 12:00')
  Tipo.create(tipoCurso: 'Intensivo Tarde', diasCurso: 'Lun/Mar/Mie/Jue', horarioCurso: '4:00 - 6:00')
  Tipo.create(tipoCurso: 'Intensivo Nocturno', diasCurso: 'Lun/Mar/Mie/Jue', horarioCurso: '6:00 - 8:00')
  Tipo.create(tipoCurso: 'Sabatino AM', diasCurso: 'Sábados', horarioCurso: '8:00 - 12:00')
  Tipo.create(tipoCurso: 'Sabatino PM', diasCurso: 'Sábados', horarioCurso: '1:00 - 5:00')
  Tipo.create(tipoCurso: 'Regular Lun/Mie AM 1', diasCurso: 'Lun/Mie', horarioCurso: '7:30 - 9:30')
  Tipo.create(tipoCurso: 'Regular Lun/Mie AM 2', diasCurso: 'Lun/Mie', horarioCurso: '10:00 - 12:00')
  Tipo.create(tipoCurso: 'Regular Lun/Mie Tarde', diasCurso: 'Lun/Mie', horarioCurso: '4:00 - 6:00')
  Tipo.create(tipoCurso: 'Regular Lun/Mie Nocturno', diasCurso: 'Lun/Mie', horarioCurso: '6:00 - 8:00')
  Tipo.create(tipoCurso: 'Regular Mar/Jue AM 1', diasCurso: 'Mar/Jue', horarioCurso: '7:30 - 9:30')
  Tipo.create(tipoCurso: 'Regular Mar/Jue AM 2', diasCurso: 'Mar/Jue', horarioCurso: '10:00 - 12:00')
  Tipo.create(tipoCurso: 'Regular Mar/Jue Tarde', diasCurso: 'Mar/Jue', horarioCurso: '4:00 - 6:00')
  Tipo.create(tipoCurso: 'Regular Mar/Jue Nocturno', diasCurso: 'Mar/Jue', horarioCurso: '6:00 - 8:00')
  Tipo.create(tipoCurso: 'Regular Niños Lun/Mie AM 1', diasCurso: 'Lun/Mie', horarioCurso: '7:30 - 9:00')
  Tipo.create(tipoCurso: 'Regular Niños Lun/Mie AM 2', diasCurso: 'Lun/Mie', horarioCurso: '10:30 - 12:00')
  Tipo.create(tipoCurso: 'Regular Niños Lun/Mie Tarde', diasCurso: 'Lun/Mie', horarioCurso: '3:30 - 5:00')
  Tipo.create(tipoCurso: 'Regular Niños Mar/Jue AM 1', diasCurso: 'Mar/Jue', horarioCurso: '7:30 - 9:00')
  Tipo.create(tipoCurso: 'Regular Niños Mar/Jue AM 2', diasCurso: 'Mar/Jue', horarioCurso: '10:30 - 12:00')
  Tipo.create(tipoCurso: 'Regular Niños Mar/Jue Tarde', diasCurso: 'Mar/Jue', horarioCurso: '3:30 - 5:00')
  Tipo.create(tipoCurso: 'Regular Ado. Lun/Mie AM 1', diasCurso: 'Lun/Mie', horarioCurso: '7:30 - 9:30')
  Tipo.create(tipoCurso: 'Regular Ado. Lun/Mie AM 2', diasCurso: 'Lun/Mie', horarioCurso: '10:00 - 12:00')
  Tipo.create(tipoCurso: 'Regular Ado. Lun/Mie Tarde', diasCurso: 'Lun/Mie', horarioCurso: '3:00 - 5:00')
  Tipo.create(tipoCurso: 'Regular Ado. Mar/Jue AM 1', diasCurso: 'Mar/Jue', horarioCurso: '7:30 - 9:30')
  Tipo.create(tipoCurso: 'Regular Ado. Mar/Jue AM 2', diasCurso: 'Mar/Jue', horarioCurso: '10:00 - 12:00')
  Tipo.create(tipoCurso: 'Regular Ado. Mar/Jue Tarde', diasCurso: 'Mar/Jue', horarioCurso: '3:00 - 5:00')
end

# Modelo para la tabla 'bancos'
class Banco < ActiveRecord::Base
  Banco.create(nombreBanco: 'Banco Mercantil')
  Banco.create(nombreBanco: 'Banesco')
  Banco.create(nombreBanco: 'Banco de Venezuela')
  Banco.create(nombreBanco: 'Banco Provincial')
  Banco.create(nombreBanco: 'Banco Exterior')
  Banco.create(nombreBanco: 'BOD')
  Banco.create(nombreBanco: 'BNC')
  Banco.create(nombreBanco: 'Banco Bicentenario')
  Banco.create(nombreBanco: 'Banco del Tesoro')
  Banco.create(nombreBanco: 'Bancaribe')
  Banco.create(nombreBanco: 'Banco Fondo Común')
  Banco.create(nombreBanco: 'Banco Industrial')
  Banco.create(nombreBanco: 'Banco Caroní')
  Banco.create(nombreBanco: 'Sofitasa')
  Banco.create(nombreBanco: 'Banplus')
  Banco.create(nombreBanco: 'Banco Activo')
  Banco.create(nombreBanco: 'Del Sur')
  Banco.create(nombreBanco: '100% Banco')
end

# Modelo para la tabla 'usuarios'
class Usuario < ActiveRecord::Base
  pass = BCrypt::Password.create(123)
  Usuario.create(nombreUsuario: 'prueba', cedulaUsuario: '123456', passwordUsuario: pass, nivelAcceso: 'Admin')
end

# Modelo para la tabla 'sedes'
class Sede < ActiveRecord::Base
  Sede.create(nombreSede: 'Sede La Floresta')
  Sede.create(nombreSede: 'Sede Las Delicias')
end
