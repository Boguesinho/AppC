import 'package:path/path.dart';
import 'package:sctproject/classes/spHelper.dart';
import 'package:sctproject/models/sesion.dart';
import 'package:sctproject/models/solve.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider {
  //CONSTANTES PARA LA TABLA TIEMPOS
  static const String TABLE_TIEMPOS = "Tiempos";
  static const String COLUMN_IDSOLVE = "idSolve";
  static const String COLUMN_TIEMPO = "tiempo";
  static const String COLUMN_SCRAMBLE = "scramble";
  static const String COLUMN_MASDOS = "masdos";
  static const String COLUMN_DNF = "dnf";
  static const String COLUMN_FAVORITO = "favorito";
  static const String COLUMN_EMOTICON = "emoticon";
  static const String COLUMN_FOREIGN_SESIONES = "Sesiones_idSesion";
  static const String COLUMN_FOREIGN_SESIONES_CATEGORIAS =
      "Sesiones_Categorias_idCategoria";

  //CONSTANTES PARA LA TABLA SESIONES
  static const String TABLE_SESIONES = "Sesiones";
  static const String COLUMN_IDSESION = "idSesion";
  static const String COLUMN_NOMBRESESION = "nombreSesion";
  static const String COLUMN_FOREIGN_CATEGORIAS = "Categorias_idCategoria";

  //CONSTANTES PARA LA TABLA CATEGORIAS
  static const String TABLE_CATEGORIAS = "Categorias";
  static const String COLUMN_IDCATEGORIA = "idCategoria";
  static const String COLUMN_NOMBRECATEGORIA = "nombreCategoria";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  var listaCategoriasStr = {
    "Rubiks Cube",
    "2x2",
    "4x4",
    "5x5",
    "6x6",
    "7x7",
    "Clock",
    "Megaminx",
    "Pyraminx",
    "Skewb",
    "Square-One",
  };

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'Timer.db'),
      version: 1,
      onConfigure: _onConfigure,
      onCreate: (Database database, int version) async {
        print("Creando Tablas");

        //HABILITAR LLAVES FORÁNEAS
        await database.execute("PRAGMA foreign_keys = ON");

        //CREAR TABLA DE CATEGORIAS
        await database.execute("CREATE TABLE IF NOT EXISTS $TABLE_CATEGORIAS"
            "($COLUMN_IDCATEGORIA INTEGER NOT NULL, $COLUMN_NOMBRECATEGORIA TEXT NOT NULL, PRIMARY KEY ($COLUMN_IDCATEGORIA AUTOINCREMENT));");

        for (int i = 0; i < listaCategoriasStr.length; i++) {
          await database.execute(
              "INSERT INTO $TABLE_CATEGORIAS ($COLUMN_NOMBRECATEGORIA) values ('${listaCategoriasStr.toList()[i]}');");
        }

        //CREAR TABLA DE SESIONES
        await database.execute(
          "CREATE TABLE IF NOT EXISTS $TABLE_SESIONES ("
          "$COLUMN_IDSESION INTEGER NOT NULL,"
          "$COLUMN_NOMBRESESION TEXT NOT NULL,"
          "$COLUMN_FOREIGN_CATEGORIAS INTEGER,"
          "PRIMARY KEY ($COLUMN_IDSESION AUTOINCREMENT)"
          ");",
        );

        for (int i = 0; i < listaCategoriasStr.length; i++) {
          await database.execute(
              "INSERT INTO $TABLE_SESIONES ($COLUMN_NOMBRESESION, $COLUMN_FOREIGN_CATEGORIAS) values ('Sesión General', ${i + 1});");
        }

        //CREAR TABLA DE TIEMPOS
        await database.execute(
          "CREATE TABLE IF NOT EXISTS $TABLE_TIEMPOS ("
          "$COLUMN_IDSOLVE INTEGER NOT NULL,"
          "$COLUMN_TIEMPO DOUBLE NOT NULL,"
          "$COLUMN_SCRAMBLE TEXT NOT NULL,"
          "$COLUMN_MASDOS INTEGER NOT NULL,"
          "$COLUMN_DNF INTEGER NOT NULL,"
          "$COLUMN_FAVORITO INTEGER NOT NULL,"
          "$COLUMN_EMOTICON INTEGER NOT NULL,"
          "$COLUMN_FOREIGN_SESIONES INTEGER,"
          "$COLUMN_FOREIGN_SESIONES_CATEGORIAS INTEGER,"
          "PRIMARY KEY ($COLUMN_IDSOLVE AUTOINCREMENT)"
          ");",
        );
      },
    );
  }

  Future<List<Solve>> getSolves(int idSesionSeleccionada) async {
    final db = await database;

    var solves = await db.rawQuery("SELECT "
        "a.$COLUMN_IDSOLVE,"
        "a.$COLUMN_TIEMPO,"
        "a.$COLUMN_SCRAMBLE,"
        "a.$COLUMN_MASDOS,"
        "a.$COLUMN_DNF,"
        "a.$COLUMN_FAVORITO,"
        "a.$COLUMN_EMOTICON,"
        "a.$COLUMN_FOREIGN_SESIONES,"
        "a.$COLUMN_FOREIGN_SESIONES_CATEGORIAS "
        "FROM $TABLE_TIEMPOS a, $TABLE_SESIONES b, $TABLE_CATEGORIAS c "
        "WHERE a.$COLUMN_FOREIGN_SESIONES = $idSesionSeleccionada "
        "AND a.$COLUMN_FOREIGN_SESIONES = b.$COLUMN_IDSESION "
        "AND b.$COLUMN_FOREIGN_CATEGORIAS = c.$COLUMN_IDCATEGORIA");

    List<Solve> solveList = List<Solve>();

    solves.forEach((currentSolve) {
      Solve solve = Solve.fromMap(currentSolve);
      solveList.add(solve);
    });

    return solveList;
  }

  Future<List<Solve>> getSolvesLimite(
      int idSesionSeleccionada, int limiteFilas) async {
    final db = await database;

    var solves = await db.rawQuery("SELECT "
        "a.$COLUMN_IDSOLVE,"
        "a.$COLUMN_TIEMPO,"
        "a.$COLUMN_SCRAMBLE,"
        "a.$COLUMN_MASDOS,"
        "a.$COLUMN_DNF,"
        "a.$COLUMN_FAVORITO,"
        "a.$COLUMN_EMOTICON,"
        "a.$COLUMN_FOREIGN_SESIONES,"
        "a.$COLUMN_FOREIGN_SESIONES_CATEGORIAS "
        "FROM $TABLE_TIEMPOS a, $TABLE_SESIONES b, $TABLE_CATEGORIAS c "
        "WHERE a.$COLUMN_FOREIGN_SESIONES = $idSesionSeleccionada "
        "AND a.$COLUMN_FOREIGN_SESIONES = b.$COLUMN_IDSESION "
        "AND b.$COLUMN_FOREIGN_CATEGORIAS = c.$COLUMN_IDCATEGORIA"
        " LIMIT $limiteFilas");

    List<Solve> solveList = List<Solve>();

    solves.forEach((currentSolve) {
      Solve solve = Solve.fromMap(currentSolve);
      solveList.add(solve);
    });

    return solveList;
  }

  Future<List<Sesion>> getSesiones() async {
    final db = await database;

    var sesiones = await db.query(TABLE_SESIONES);

    List<Sesion> listaSesiones = List<Sesion>();

    sesiones.forEach((sesionActual) {
      Sesion sesion = Sesion.fromMap(sesionActual);
      listaSesiones.add(sesion);
    });

    return listaSesiones;
  }

  Future<Solve> insert(Solve solve) async {
    final db = await database;
    db.rawInsert("INSERT INTO $TABLE_TIEMPOS "
        " ($COLUMN_TIEMPO, $COLUMN_SCRAMBLE, $COLUMN_MASDOS,"
        " $COLUMN_DNF, $COLUMN_FAVORITO, $COLUMN_EMOTICON, "
        "$COLUMN_FOREIGN_SESIONES, $COLUMN_FOREIGN_SESIONES_CATEGORIAS)"
        " VALUES (${solve.tiempo}, '${solve.scramble}', ${solve.masdos}, ${solve.dnf},"
        " ${solve.favorito}, ${solve.emoticon}, ${solve.sesion}, ${solve.categoria});");

    //solve.idSolve = await db.insert(TABLE_TIEMPOS, solve.toMap());
    return solve;
  }

  Future<Sesion> insertSesion(Sesion sesion) async {
    final db = await database;
    db.rawInsert("INSERT INTO $TABLE_SESIONES "
        " ($COLUMN_NOMBRESESION, $COLUMN_FOREIGN_CATEGORIAS) "
        "VALUES ('${sesion.nombreSesion}', ${sesion.foreignCategorias});");

    return sesion;
  }

  Future<int> setCategoriaSeleccionada(int idSesionSeleccionada) async {
    final db = await database;

    var result = await db.rawQuery("SELECT a.$COLUMN_NOMBRECATEGORIA "
        "FROM $TABLE_CATEGORIAS a, $TABLE_SESIONES b "
        "WHERE b.$COLUMN_IDSESION = $idSesionSeleccionada "
        "AND b.$COLUMN_FOREIGN_CATEGORIAS = a.$COLUMN_IDCATEGORIA");

    SPHelper.setString(
        'categoriaSeleccionada', '${result[0]["$COLUMN_NOMBRECATEGORIA"]}');

    SPHelper.setInt(
        'categoriaSeleccionadaInt', result[0]["$COLUMN_IDCATEGORIA"]);

    return 0;
  }

  Future<int> setSesionSeleccionada(int idSesionSeleccionada) async {
    final db = await database;

    var result = await db.rawQuery(
        "SELECT $COLUMN_NOMBRESESION FROM $TABLE_SESIONES WHERE $COLUMN_IDSESION = $idSesionSeleccionada");

    SPHelper.setString(
        'sesionSeleccionada', '${result[0]["$COLUMN_NOMBRESESION"]}');

    SPHelper.setInt('sesionSeleccionadaInt', result[0]["$COLUMN_IDSESION"]);

    await setCategoriaSeleccionada(idSesionSeleccionada);

    return 0;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_TIEMPOS,
      where: "idSolve = ?",
      whereArgs: [id],
    );
  }

  Future<int> deleteLast() async {
    final db = await database;
    var ultimoIndex = await DatabaseProvider.db.obtenerUltimoIndex();

    return await db.delete(
      TABLE_TIEMPOS,
      where: "idSolve = ?",
      whereArgs: [ultimoIndex[0].idSolve],
    );
  }

  Future<int> deleteAll() async {
    final db = await database;

    return await db.rawDelete("DELETE FROM $TABLE_TIEMPOS");
  }

  Future<int> update(Solve solve) async {
    final db = await database;

    return await db.update(
      TABLE_TIEMPOS,
      solve.toMap(),
      where: "idSolve = ?",
      whereArgs: [solve.idSolve],
    );
  }

  Future<List<Solve>> obtenerUltimoIndex() async {
    final db = await database;

    var solves = await db.query(TABLE_TIEMPOS,
        columns: [
          COLUMN_IDSOLVE,
        ],
        limit: 1,
        orderBy: "idSolve desc");

    List<Solve> solveList = List<Solve>();

    solves.forEach((currentSolve) {
      Solve solve = Solve.fromMap(currentSolve);

      solveList.add(solve);
    });

    return solveList;
  }

  Future<int> updateEmoticon(int emoticon) async {
    final db = await database;
    var ultimoIndex = await DatabaseProvider.db.obtenerUltimoIndex();

    return await db.rawUpdate(
        "UPDATE $TABLE_TIEMPOS SET $COLUMN_EMOTICON=$emoticon WHERE $COLUMN_IDSOLVE=${ultimoIndex[0].idSolve}");
  }

  Future<int> updateFavorito(bool favorito) async {
    final db = await database;
    var ultimoIndex = await DatabaseProvider.db.obtenerUltimoIndex();
    int favoritoEnInt = favorito ? 1 : 0;

    return await db.rawUpdate(
        "UPDATE $TABLE_TIEMPOS SET $COLUMN_FAVORITO=$favoritoEnInt WHERE $COLUMN_IDSOLVE=${ultimoIndex[0].idSolve}");
  }

  Future<int> updateDnf(bool dnf) async {
    final db = await database;
    var ultimoIndex = await DatabaseProvider.db.obtenerUltimoIndex();
    int dnfEnInt = dnf ? 1 : 0;

    return await db.rawUpdate(
        "UPDATE $TABLE_TIEMPOS SET $COLUMN_DNF=$dnfEnInt WHERE $COLUMN_IDSOLVE=${ultimoIndex[0].idSolve}");
  }

  Future<int> updateMasDos(bool masdos) async {
    final db = await database;
    var ultimoIndex = await DatabaseProvider.db.obtenerUltimoIndex();
    int masdosEnInt = masdos ? 1 : 0;

    return await db.rawUpdate(
        "UPDATE $TABLE_TIEMPOS SET $COLUMN_MASDOS=$masdosEnInt WHERE $COLUMN_IDSOLVE=${ultimoIndex[0].idSolve}");
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }
}
