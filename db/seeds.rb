# Data for 'course_types' table
class CourseType < ActiveRecord::Base
  CourseType.create(course_modality: 'Intensivo AM 1', course_days: 'Lun/Mar/Mie/Jue', course_schedule: '7:30 AM - 9:30 AM')
  CourseType.create(course_modality: 'Intensivo AM 2', course_days: 'Lun/Mar/Mie/Jue', course_schedule: '10:00 AM - 12:00 PM')
  CourseType.create(course_modality: 'Intensivo Tarde', course_days: 'Lun/Mar/Mie/Jue', course_schedule: '4:00 PM - 6:00 PM')
  CourseType.create(course_modality: 'Intensivo Nocturno', course_days: 'Lun/Mar/Mie/Jue', course_schedule: '6:00 PM - 8:00 PM')
  CourseType.create(course_modality: 'Sabatino AM', course_days: 'Sábados', course_schedule: '8:00 AM - 12:00 AM')
  CourseType.create(course_modality: 'Sabatino PM', course_days: 'Sábados', course_schedule: '1:00 PM - 5:00 PM')
  CourseType.create(course_modality: 'Regular Lun/Mie AM 1', course_days: 'Lun/Mie', course_schedule: '7:30 AM - 9:30 AM')
  CourseType.create(course_modality: 'Regular Lun/Mie AM 2', course_days: 'Lun/Mie', course_schedule: '10:00 AM - 12:00 PM')
  CourseType.create(course_modality: 'Regular Lun/Mie Tarde', course_days: 'Lun/Mie', course_schedule: '4:00 PM - 6:00 PM')
  CourseType.create(course_modality: 'Regular Lun/Mie Nocturno', course_days: 'Lun/Mie', course_schedule: '6:00 PM - 8:00 PM')
  CourseType.create(course_modality: 'Regular Mar/Jue AM 1', course_days: 'Mar/Jue', course_schedule: '7:30 AM - 9:30 AM')
  CourseType.create(course_modality: 'Regular Mar/Jue AM 2', course_days: 'Mar/Jue', course_schedule: '10:00 AM - 12:00 PM')
  CourseType.create(course_modality: 'Regular Mar/Jue Tarde', course_days: 'Mar/Jue', course_schedule: '4:00 PM - 6:00 PM')
  CourseType.create(course_modality: 'Regular Mar/Jue Nocturno', course_days: 'Mar/Jue', course_schedule: '6:00 PM - 8:00 PM')
  CourseType.create(course_modality: 'Regular Niños Lun/Mie AM 1', course_days: 'Lun/Mie', course_schedule: '7:30 AM - 9:00 AM')
  CourseType.create(course_modality: 'Regular Niños Lun/Mie AM 2', course_days: 'Lun/Mie', course_schedule: '10:30 AM - 12:00 PM')
  CourseType.create(course_modality: 'Regular Niños Lun/Mie Tarde', course_days: 'Lun/Mie', course_schedule: '3:30 PM - 5:00 PM')
  CourseType.create(course_modality: 'Regular Niños Mar/Jue AM 1', course_days: 'Mar/Jue', course_schedule: '7:30 AM - 9:00 AM')
  CourseType.create(course_modality: 'Regular Niños Mar/Jue AM 2', course_days: 'Mar/Jue', course_schedule: '10:30 AM - 12:00 PM')
  CourseType.create(course_modality: 'Regular Niños Mar/Jue Tarde', course_days: 'Mar/Jue', course_schedule: '3:30 PM - 5:00 PM')
  CourseType.create(course_modality: 'Regular Ado. Lun/Mie AM 1', course_days: 'Lun/Mie', course_schedule: '7:30 AM - 9:30 AM')
  CourseType.create(course_modality: 'Regular Ado. Lun/Mie AM 2', course_days: 'Lun/Mie', course_schedule: '10:00 AM - 12:00 PM')
  CourseType.create(course_modality: 'Regular Ado. Lun/Mie Tarde', course_days: 'Lun/Mie', course_schedule: '3:00 PM - 5:00 PM')
  CourseType.create(course_modality: 'Regular Ado. Mar/Jue AM 1', course_days: 'Mar/Jue', course_schedule: '7:30 AM - 9:30 AM')
  CourseType.create(course_modality: 'Regular Ado. Mar/Jue AM 2', course_days: 'Mar/Jue', course_schedule: '10:00 AM - 12:00 PM')
  CourseType.create(course_modality: 'Regular Ado. Mar/Jue Tarde', course_days: 'Mar/Jue', course_schedule: '3:00 PM - 5:00 PM')
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
  Bank.create(bank_name: 'Bancrecer')
  Bank.create(bank_name: 'Banplus')
  Bank.create(bank_name: 'Mi Banco')
  Bank.create(bank_name: 'Banco Soberano del Pueblo')
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

# Data for 'levels' table
class Level < ActiveRecord::Base
  Level.create(level_description: 'A1-01')
  Level.create(level_description: 'A1-02')
  Level.create(level_description: 'A1-03')
  Level.create(level_description: 'A1-04')
  Level.create(level_description: 'A1-05')
  Level.create(level_description: 'A2-06')
  Level.create(level_description: 'A2-07')
  Level.create(level_description: 'A2-08')
  Level.create(level_description: 'A2-09-A')
  Level.create(level_description: 'A2-09-B')
  Level.create(level_description: 'A2-09-C')
  Level.create(level_description: 'B1-10-A')
  Level.create(level_description: 'B1-10-B')
  Level.create(level_description: 'B1-10-C')
  Level.create(level_description: 'B1-11-A')
  Level.create(level_description: 'B1-11-B')
  Level.create(level_description: 'B1-11-C')
  Level.create(level_description: 'B1-12-A')
  Level.create(level_description: 'B1-12-B')
  Level.create(level_description: 'B1-12-C')
  Level.create(level_description: 'B2-13-A')
  Level.create(level_description: 'B2-13-B')
  Level.create(level_description: 'B2-13-C')
  Level.create(level_description: 'B2-14-A')
  Level.create(level_description: 'B2-14-B')
  Level.create(level_description: 'B2-14-C')
  Level.create(level_description: 'B2-15-A')
  Level.create(level_description: 'B2-15-B')
  Level.create(level_description: 'B2-15-C')
end
