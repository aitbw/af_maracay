# Data for 'course_types' table
class CourseType < ActiveRecord::Base
  CourseType.create(course_type: 'Intensivo AM 1', course_days: 'Lun/Mar/Mie/Jue', course_schedule: '7:30 - 9:30')
  CourseType.create(course_type: 'Intensivo AM 2', course_days: 'Lun/Mar/Mie/Jue', course_schedule: '10:00 - 12:00')
  CourseType.create(course_type: 'Intensivo Tarde', course_days: 'Lun/Mar/Mie/Jue', course_schedule: '4:00 - 6:00')
  CourseType.create(course_type: 'Intensivo Nocturno', course_days: 'Lun/Mar/Mie/Jue', course_schedule: '6:00 - 8:00')
  CourseType.create(course_type: 'Sabatino AM', course_days: 'Sábados', course_schedule: '8:00 - 12:00')
  CourseType.create(course_type: 'Sabatino PM', course_days: 'Sábados', course_schedule: '1:00 - 5:00')
  CourseType.create(course_type: 'Regular Lun/Mie AM 1', course_days: 'Lun/Mie', course_schedule: '7:30 - 9:30')
  CourseType.create(course_type: 'Regular Lun/Mie AM 2', course_days: 'Lun/Mie', course_schedule: '10:00 - 12:00')
  CourseType.create(course_type: 'Regular Lun/Mie Tarde', course_days: 'Lun/Mie', course_schedule: '4:00 - 6:00')
  CourseType.create(course_type: 'Regular Lun/Mie Nocturno', course_days: 'Lun/Mie', course_schedule: '6:00 - 8:00')
  CourseType.create(course_type: 'Regular Mar/Jue AM 1', course_days: 'Mar/Jue', course_schedule: '7:30 - 9:30')
  CourseType.create(course_type: 'Regular Mar/Jue AM 2', course_days: 'Mar/Jue', course_schedule: '10:00 - 12:00')
  CourseType.create(course_type: 'Regular Mar/Jue Tarde', course_days: 'Mar/Jue', course_schedule: '4:00 - 6:00')
  CourseType.create(course_type: 'Regular Mar/Jue Nocturno', course_days: 'Mar/Jue', course_schedule: '6:00 - 8:00')
  CourseType.create(course_type: 'Regular Niños Lun/Mie AM 1', course_days: 'Lun/Mie', course_schedule: '7:30 - 9:00')
  CourseType.create(course_type: 'Regular Niños Lun/Mie AM 2', course_days: 'Lun/Mie', course_schedule: '10:30 - 12:00')
  CourseType.create(course_type: 'Regular Niños Lun/Mie Tarde', course_days: 'Lun/Mie', course_schedule: '3:30 - 5:00')
  CourseType.create(course_type: 'Regular Niños Mar/Jue AM 1', course_days: 'Mar/Jue', course_schedule: '7:30 - 9:00')
  CourseType.create(course_type: 'Regular Niños Mar/Jue AM 2', course_days: 'Mar/Jue', course_schedule: '10:30 - 12:00')
  CourseType.create(course_type: 'Regular Niños Mar/Jue Tarde', course_days: 'Mar/Jue', course_schedule: '3:30 - 5:00')
  CourseType.create(course_type: 'Regular Ado. Lun/Mie AM 1', course_days: 'Lun/Mie', course_schedule: '7:30 - 9:30')
  CourseType.create(course_type: 'Regular Ado. Lun/Mie AM 2', course_days: 'Lun/Mie', course_schedule: '10:00 - 12:00')
  CourseType.create(course_type: 'Regular Ado. Lun/Mie Tarde', course_days: 'Lun/Mie', course_schedule: '3:00 - 5:00')
  CourseType.create(course_type: 'Regular Ado. Mar/Jue AM 1', course_days: 'Mar/Jue', course_schedule: '7:30 - 9:30')
  CourseType.create(course_type: 'Regular Ado. Mar/Jue AM 2', course_days: 'Mar/Jue', course_schedule: '10:00 - 12:00')
  CourseType.create(course_type: 'Regular Ado. Mar/Jue Tarde', course_days: 'Mar/Jue', course_schedule: '3:00 - 5:00')
end

# Data for 'banks' table
class Bank < ActiveRecord::Base
  Bank.create(bank_name: 'Banco Mercantil')
  Bank.create(bank_name: 'Banesco')
  Bank.create(bank_name: 'Banco de Venezuela')
  Bank.create(bank_name: 'Banco Provincial')
  Bank.create(bank_name: 'Banco Exterior')
  Bank.create(bank_name: 'BOD')
  Bank.create(bank_name: 'BNC')
  Bank.create(bank_name: 'Banco Bicentenario')
  Bank.create(bank_name: 'Banco del Tesoro')
  Bank.create(bank_name: 'Bancaribe')
  Bank.create(bank_name: 'Banco Fondo Común')
  Bank.create(bank_name: 'Banco Industrial')
  Bank.create(bank_name: 'Banco Caroní')
  Bank.create(bank_name: 'Sofitasa')
  Bank.create(bank_name: 'Banplus')
  Bank.create(bank_name: 'Banco Activo')
  Bank.create(bank_name: 'Del Sur')
  Bank.create(bank_name: '100% Banco')
end

# Data for 'users' table
class User < ActiveRecord::Base
  User.create(user_name: 'prueba', user_cedula: '123456', user_password: 123, access_level: 'Admin')
end

# Data for 'offices' table
class Office < ActiveRecord::Base
  Office.create(office_name: 'La Floresta')
  Office.create(office_name: 'Paseo Las Delicias I')
end
