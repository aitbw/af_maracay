# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  create_table "bancos", primary_key: "idBanco", force: :cascade do |t|
    t.string "nombreBanco", limit: 100, null: false
  end

  add_index "bancos", ["idBanco"], name: "idBanco_UNIQUE", unique: true, using: :btree

  create_table "cuentasBanco", primary_key: "idCuentaBanco", force: :cascade do |t|
    t.integer "idProfesor",   limit: 4,  null: false
    t.integer "idBanco",      limit: 4,  null: false
    t.string  "numeroCuenta", limit: 50, null: false
    t.string  "tipoCuenta",   limit: 50, null: false
  end

  add_index "cuentasBanco", ["idBanco"], name: "fk_cuentasBanco_bancos1_idx", using: :btree
  add_index "cuentasBanco", ["idCuentaBanco"], name: "idCuentaBanco_UNIQUE", unique: true, using: :btree
  add_index "cuentasBanco", ["idProfesor"], name: "fk_cuentasBanco_profesores1_idx", using: :btree

  create_table "cuotasEstudiantes", primary_key: "idCuota", force: :cascade do |t|
    t.integer "idEstudiante",     limit: 4,  null: false
    t.integer "idUsuario",        limit: 4,  null: false
    t.float   "montoCuota",       limit: 24, null: false
    t.string  "tipoPago",         limit: 50, null: false
    t.date    "fechaEmision",                null: false
    t.date    "fechaExpiracion",             null: false
    t.string  "banco",            limit: 50
    t.string  "numeroReferencia", limit: 50
  end

  add_index "cuotasEstudiantes", ["idCuota"], name: "idCuota_UNIQUE", unique: true, using: :btree
  add_index "cuotasEstudiantes", ["idEstudiante"], name: "cuota_estudiante_idx", using: :btree
  add_index "cuotasEstudiantes", ["idUsuario"], name: "fk_cuotasEstudiantes_usuarios1_idx", using: :btree

  create_table "cursos", primary_key: "idCurso", force: :cascade do |t|
    t.integer "idTipoCurso",    limit: 4,  null: false
    t.string  "nivelCurso",     limit: 50, null: false
    t.integer "capacidadCurso", limit: 4,  null: false
    t.date    "inicioCurso",               null: false
    t.date    "finCurso",                  null: false
    t.integer "horasCurso",     limit: 4,  null: false
  end

  add_index "cursos", ["idCurso"], name: "idCurso_UNIQUE", unique: true, using: :btree
  add_index "cursos", ["idTipoCurso"], name: "tipo_curso_idx", using: :btree

  create_table "cursos_has_sedes", id: false, force: :cascade do |t|
    t.integer "cursos_idCurso", limit: 4, null: false
    t.integer "sedes_idSede",   limit: 4, null: false
  end

  add_index "cursos_has_sedes", ["cursos_idCurso"], name: "fk_cursos_has_sedes_cursos1_idx", using: :btree
  add_index "cursos_has_sedes", ["sedes_idSede"], name: "fk_cursos_has_sedes_sedes1_idx", using: :btree

  create_table "escalafon", primary_key: "idSalario", force: :cascade do |t|
    t.string "tipoSalario", limit: 200, null: false
    t.float  "pagoHora",    limit: 24,  null: false
  end

  add_index "escalafon", ["idSalario"], name: "idTipoSalario_UNIQUE", unique: true, using: :btree

  create_table "estudiantes", primary_key: "idEstudiante", force: :cascade do |t|
    t.integer "idSeccion",          limit: 4,   null: false
    t.string  "nombreEstudiante",   limit: 150, null: false
    t.string  "correoEstudiante",   limit: 150, null: false
    t.string  "telefonoEstudiante", limit: 15,  null: false
    t.string  "cedulaEstudiante",   limit: 10,  null: false
  end

  add_index "estudiantes", ["cedulaEstudiante"], name: "cedulaEstudiante_UNIQUE", unique: true, using: :btree
  add_index "estudiantes", ["correoEstudiante"], name: "correoEstudiante_UNIQUE", unique: true, using: :btree
  add_index "estudiantes", ["idEstudiante"], name: "ID_UNIQUE", unique: true, using: :btree
  add_index "estudiantes", ["idSeccion"], name: "grupo_estudiante_idx", using: :btree

  create_table "horasProfesores", primary_key: "idHora", force: :cascade do |t|
    t.integer "idProfesor",     limit: 4, null: false
    t.integer "idSeccion",      limit: 4, null: false
    t.integer "horasCubiertas", limit: 4, null: false
    t.date    "fechaHoras",               null: false
  end

  add_index "horasProfesores", ["idHora"], name: "idClase_UNIQUE", unique: true, using: :btree
  add_index "horasProfesores", ["idProfesor"], name: "horas_profesor_idx", using: :btree
  add_index "horasProfesores", ["idSeccion"], name: "horas_seccion_idx", using: :btree

  create_table "inscripcionesEstudiantes", primary_key: "idInscripcion", force: :cascade do |t|
    t.integer "idEstudiante",     limit: 4,  null: false
    t.integer "idUsuario",        limit: 4,  null: false
    t.float   "costoInscripcion", limit: 24, null: false
    t.string  "tipoPago",         limit: 50, null: false
    t.date    "fechaEmision",                null: false
    t.date    "fechaExpiracion",             null: false
    t.string  "banco",            limit: 50
    t.string  "numeroReferencia", limit: 50
  end

  add_index "inscripcionesEstudiantes", ["idEstudiante"], name: "inscripcion_estudiante_idx", using: :btree
  add_index "inscripcionesEstudiantes", ["idInscripcion"], name: "idInscripcion_UNIQUE", unique: true, using: :btree
  add_index "inscripcionesEstudiantes", ["idUsuario"], name: "fk_incripcionesEstudiantes_usuarios1_idx", using: :btree

  create_table "inventario", primary_key: "idItem", force: :cascade do |t|
    t.string  "nombreItem",   limit: 100, null: false
    t.integer "cantidadItem", limit: 4,   null: false
  end

  add_index "inventario", ["idItem"], name: "idInventario_UNIQUE", unique: true, using: :btree

  create_table "inventario_has_movimientos", id: false, force: :cascade do |t|
    t.integer "inventario_idItem",        limit: 4, null: false
    t.integer "movimientos_idMovimiento", limit: 4, null: false
  end

  add_index "inventario_has_movimientos", ["inventario_idItem"], name: "fk_inventario_has_movimientos_inventario1_idx", using: :btree
  add_index "inventario_has_movimientos", ["movimientos_idMovimiento"], name: "fk_inventario_has_movimientos_movimientos1_idx", using: :btree

  create_table "inventario_has_sedes", id: false, force: :cascade do |t|
    t.integer "inventario_idItem", limit: 4, null: false
    t.integer "sedes_idSede",      limit: 4, null: false
  end

  add_index "inventario_has_sedes", ["inventario_idItem"], name: "fk_inventario_has_sedes_inventario1_idx", using: :btree
  add_index "inventario_has_sedes", ["sedes_idSede"], name: "fk_inventario_has_sedes_sedes1_idx", using: :btree

  create_table "movimientos", primary_key: "idMovimiento", force: :cascade do |t|
    t.string  "tipoMovimiento",     limit: 50, null: false
    t.integer "cantidadMovimiento", limit: 4,  null: false
    t.date    "fechaMovimiento"
  end

  add_index "movimientos", ["idMovimiento"], name: "idMovimiento_UNIQUE", unique: true, using: :btree

  create_table "profesores", primary_key: "idProfesor", force: :cascade do |t|
    t.string "nombreProfesor",   limit: 150, null: false
    t.string "correoProfesor",   limit: 150, null: false
    t.string "telefonoProfesor", limit: 15,  null: false
    t.string "cedulaProfesor",   limit: 10,  null: false
    t.date   "fechaIngreso",                 null: false
  end

  add_index "profesores", ["cedulaProfesor"], name: "cedulaProfesor_UNIQUE", unique: true, using: :btree
  add_index "profesores", ["correoProfesor"], name: "correoProfesor_UNIQUE", unique: true, using: :btree
  add_index "profesores", ["idProfesor"], name: "idProfesor_UNIQUE", unique: true, using: :btree

  create_table "profesores_has_escalafon", id: false, force: :cascade do |t|
    t.integer "profesores_idProfesor", limit: 4, null: false
    t.integer "escalafon_idSalario",   limit: 4, null: false
  end

  add_index "profesores_has_escalafon", ["escalafon_idSalario"], name: "fk_profesores_has_escalafon_escalafon1_idx", using: :btree
  add_index "profesores_has_escalafon", ["profesores_idProfesor"], name: "fk_profesores_has_escalafon_profesores1_idx", using: :btree

  create_table "secciones", primary_key: "idSeccion", force: :cascade do |t|
    t.integer "idCurso",       limit: 4,  null: false
    t.integer "idProfesor",    limit: 4,  null: false
    t.string  "codigoSeccion", limit: 50, null: false
  end

  add_index "secciones", ["idCurso"], name: "curso_grupo_idx", using: :btree
  add_index "secciones", ["idProfesor"], name: "profesor_seccion_idx", using: :btree
  add_index "secciones", ["idSeccion"], name: "idGrupo_UNIQUE", unique: true, using: :btree

  create_table "sedes", primary_key: "idSede", force: :cascade do |t|
    t.string "nombreSede",   limit: 75,  null: false
    t.string "locacionSede", limit: 100, null: false
    t.string "telefonoSede", limit: 15,  null: false
  end

  add_index "sedes", ["idSede"], name: "idSede_UNIQUE", unique: true, using: :btree

  create_table "sedes_has_movimientos", id: false, force: :cascade do |t|
    t.integer "sedes_idSede",             limit: 4, null: false
    t.integer "movimientos_idMovimiento", limit: 4, null: false
  end

  add_index "sedes_has_movimientos", ["movimientos_idMovimiento"], name: "fk_sedes_has_movimientos_movimientos1_idx", using: :btree
  add_index "sedes_has_movimientos", ["sedes_idSede"], name: "fk_sedes_has_movimientos_sedes1_idx", using: :btree

  create_table "tiposCursos", primary_key: "idTipoCurso", force: :cascade do |t|
    t.string "tipoCurso",    limit: 50, null: false
    t.string "diasCurso",    limit: 50, null: false
    t.string "horarioCurso", limit: 50, null: false
  end

  add_index "tiposCursos", ["idTipoCurso"], name: "idTipoCurso_UNIQUE", unique: true, using: :btree

  create_table "tiposCursos_has_escalafon", id: false, force: :cascade do |t|
    t.integer "tiposCursos_idTipoCurso", limit: 4, null: false
    t.integer "escalafon_idSalario",     limit: 4, null: false
  end

  add_index "tiposCursos_has_escalafon", ["escalafon_idSalario"], name: "fk_tiposCursos_has_escalafon_escalafon1_idx", using: :btree
  add_index "tiposCursos_has_escalafon", ["tiposCursos_idTipoCurso"], name: "fk_tiposCursos_has_escalafon_tiposCursos1_idx", using: :btree

  create_table "usuarios", primary_key: "idUsuario", force: :cascade do |t|
    t.string "nombreUsuario",   limit: 150, null: false
    t.string "cedulaUsuario",   limit: 10,  null: false
    t.string "passwordUsuario", limit: 255, null: false
    t.string "nivelAcceso",     limit: 50,  null: false
  end

  add_index "usuarios", ["cedulaUsuario"], name: "cedulaUsuario_UNIQUE", unique: true, using: :btree
  add_index "usuarios", ["idUsuario"], name: "idUsuario_UNIQUE", unique: true, using: :btree

  add_foreign_key "cuentasBanco", "bancos", column: "idBanco", primary_key: "idBanco", name: "fk_cuentasBanco_bancos1"
  add_foreign_key "cuentasBanco", "profesores", column: "idProfesor", primary_key: "idProfesor", name: "fk_cuentasBanco_profesores1", on_update: :cascade
  add_foreign_key "cuotasEstudiantes", "estudiantes", column: "idEstudiante", primary_key: "idEstudiante", name: "cuota_estudiante", on_update: :cascade
  add_foreign_key "cuotasEstudiantes", "usuarios", column: "idUsuario", primary_key: "idUsuario", name: "fk_cuotasEstudiantes_usuarios1", on_update: :cascade
  add_foreign_key "cursos", "tiposCursos", column: "idTipoCurso", primary_key: "idTipoCurso", name: "tipo_curso", on_update: :cascade
  add_foreign_key "cursos_has_sedes", "cursos", column: "cursos_idCurso", primary_key: "idCurso", name: "fk_cursos_has_sedes_cursos1", on_update: :cascade
  add_foreign_key "cursos_has_sedes", "sedes", column: "sedes_idSede", primary_key: "idSede", name: "fk_cursos_has_sedes_sedes1", on_update: :cascade
  add_foreign_key "estudiantes", "secciones", column: "idSeccion", primary_key: "idSeccion", name: "seccion_estudiante", on_update: :cascade
  add_foreign_key "horasProfesores", "profesores", column: "idProfesor", primary_key: "idProfesor", name: "horas_profesor", on_update: :cascade
  add_foreign_key "horasProfesores", "secciones", column: "idSeccion", primary_key: "idSeccion", name: "horas_seccion", on_update: :cascade
  add_foreign_key "inscripcionesEstudiantes", "estudiantes", column: "idEstudiante", primary_key: "idEstudiante", name: "inscripcion_estudiante", on_update: :cascade
  add_foreign_key "inscripcionesEstudiantes", "usuarios", column: "idUsuario", primary_key: "idUsuario", name: "fk_incripcionesEstudiantes_usuarios1", on_update: :cascade
  add_foreign_key "inventario_has_movimientos", "inventario", column: "inventario_idItem", primary_key: "idItem", name: "fk_inventario_has_movimientos_inventario1", on_update: :cascade
  add_foreign_key "inventario_has_movimientos", "movimientos", column: "movimientos_idMovimiento", primary_key: "idMovimiento", name: "fk_inventario_has_movimientos_movimientos1", on_update: :cascade
  add_foreign_key "inventario_has_sedes", "inventario", column: "inventario_idItem", primary_key: "idItem", name: "fk_inventario_has_sedes_inventario1", on_update: :cascade
  add_foreign_key "inventario_has_sedes", "sedes", column: "sedes_idSede", primary_key: "idSede", name: "fk_inventario_has_sedes_sedes1", on_update: :cascade
  add_foreign_key "profesores_has_escalafon", "escalafon", column: "escalafon_idSalario", primary_key: "idSalario", name: "fk_profesores_has_escalafon_escalafon1", on_update: :cascade
  add_foreign_key "profesores_has_escalafon", "profesores", column: "profesores_idProfesor", primary_key: "idProfesor", name: "fk_profesores_has_escalafon_profesores1", on_update: :cascade
  add_foreign_key "secciones", "cursos", column: "idCurso", primary_key: "idCurso", name: "curso_seccion", on_update: :cascade
  add_foreign_key "secciones", "profesores", column: "idProfesor", primary_key: "idProfesor", name: "profesor_seccion", on_update: :cascade
  add_foreign_key "sedes_has_movimientos", "movimientos", column: "movimientos_idMovimiento", primary_key: "idMovimiento", name: "fk_sedes_has_movimientos_movimientos1", on_update: :cascade
  add_foreign_key "sedes_has_movimientos", "sedes", column: "sedes_idSede", primary_key: "idSede", name: "fk_sedes_has_movimientos_sedes1", on_update: :cascade
  add_foreign_key "tiposCursos_has_escalafon", "escalafon", column: "escalafon_idSalario", primary_key: "idSalario", name: "fk_tiposCursos_has_escalafon_escalafon1", on_update: :cascade
  add_foreign_key "tiposCursos_has_escalafon", "tiposCursos", column: "tiposCursos_idTipoCurso", primary_key: "idTipoCurso", name: "fk_tiposCursos_has_escalafon_tiposCursos1", on_update: :cascade
end
