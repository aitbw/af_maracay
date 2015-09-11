# seeds.rb
class Tipo < ActiveRecord::Base
  self.table_name = 'tiposCursos'

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
class Bank < ActiveRecord::Base
  self.table_name = 'bancos'

  Bank.create(nombreBanco: 'Banco Mercantil')
  Bank.create(nombreBanco: 'Banesco')
  Bank.create(nombreBanco: 'Banco de Venezuela')
  Bank.create(nombreBanco: 'Banco Provincial')
  Bank.create(nombreBanco: 'Banco Exterior')
  Bank.create(nombreBanco: 'BOD')
  Bank.create(nombreBanco: 'BNC')
  Bank.create(nombreBanco: 'Banco Bicentenario')
  Bank.create(nombreBanco: 'Banco del Tesoro')
  Bank.create(nombreBanco: 'Bancaribe')
  Bank.create(nombreBanco: 'Banco Fondo Común')
  Bank.create(nombreBanco: 'Banco Industrial')
  Bank.create(nombreBanco: 'Banco Caroní')
  Bank.create(nombreBanco: 'Sofitasa')
  Bank.create(nombreBanco: 'Banplus')
  Bank.create(nombreBanco: 'Banco Activo')
  Bank.create(nombreBanco: 'Del Sur')
  Bank.create(nombreBanco: '100% Banco')
end

# Modelo para la tabla 'usuarios'
class User < ActiveRecord::Base
  self.table_name = 'usuarios'

  pass = BCrypt::Password.create(123)
  User.create(nombreUsuario: 'prueba', cedulaUsuario: '123456', passwordUsuario: pass, nivelAcceso: 'Admin')
end
