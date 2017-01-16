# Environments
require './config/environments/development' if settings.development?

# Controllers
require './controllers/bank_accounts_controller'
require './controllers/courses_controller'
require './controllers/filters'
require './controllers/grades_controller'
require './controllers/login_controller'
require './controllers/password_controller'
require './controllers/providers_controller'
require './controllers/students_controller'
require './controllers/teachers_controller'

# Models
require './models/concerns/payment_statuses'
require './models/bank_accounts_model'
require './models/banks_model'
require './models/course_teachers_model'
require './models/course_types_model'
require './models/courses_model'
require './models/grades_model'
require './models/levels_model'
require './models/offices_model'
require './models/payments_model'
require './models/providers_model'
require './models/sections_model'
require './models/students_model'
require './models/teacher_hours_model'
require './models/teachers_model'
require './models/users_model'

# Routes
require './routes/bank_accounts'
require './routes/courses'
require './routes/payments'
require './routes/providers'
require './routes/sections'
require './routes/students'
require './routes/teachers'
require './routes/users'
