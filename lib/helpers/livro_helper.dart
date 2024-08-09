import 'package:flutter_sqlite_app/domain/livro.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LivroHelper {
  //singleton
  //construtor interno
  static final LivroHelper _instance = LivroHelper.internal();

  //criação do factory para retornar a instância
  factory LivroHelper() => _instance;

  //LivroHelper.instance
  LivroHelper.internal();

  Database? _db;

  Future<Database?> get db async {
    if (_db == null) _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    String? databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "livros_aula.db");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
          await db.execute(
              "CREATE TABLE ${LivroContract.livroTable}(${LivroContract.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT, "
                  "                                 ${LivroContract.tituloColumn} TEXT, "
                  "                                 ${LivroContract.autorColumn} TEXT, "
                  "                                 ${LivroContract.anoPublicacaoColumn} INTEGER, "
                  "                                 ${LivroContract.avaliacaoColumn} REAL) ");
        }/*,
       onUpgrade: (Database db, int newerVersion, int olderVersion) =>{
              if(newerVersion == 2 && olderVersion == 1){
                //ALTER TABLE Y
              }
       }*/
      );
  }

  Future<Livro> saveLivro(Livro l) async {
    Database? dbLivro = await db;
    if (dbLivro != null) {
      l.id = await dbLivro.insert(LivroContract.livroTable, l.toMap());
    }
    return l;
  }

  Future<Livro?> getLivro(int id) async {
    Database? dbLivro = await db;
    if (dbLivro != null) {
      List<Map> maps = await dbLivro.query(LivroContract.livroTable,
          columns: [
            LivroContract.idColumn,
            LivroContract.tituloColumn,
            LivroContract.autorColumn,
            LivroContract.anoPublicacaoColumn,
            LivroContract.avaliacaoColumn
          ],
          where: "${LivroContract.idColumn} = ?",
          whereArgs: [id]);
      if (maps.length > 0)
        return Livro.fromMap(maps.first);
      else
        return null;
    }
    return null;
  }

  Future<int> deleteLivro(int id) async {
    Database? dbLivro = await db;
    if (dbLivro!= null) {
      return await dbLivro.delete(LivroContract.livroTable,
          where: "${LivroContract.idColumn} = ?", whereArgs: [id]);
    } else
      return 0;
  }

  Future<int> updateLivro(Livro l) async {
    Database? dbLivro = await db;
    if (dbLivro != null) {
      return await dbLivro.update(LivroContract.livroTable, l.toMap(),
          where: "${LivroContract.idColumn} = ?", whereArgs: [l.id]);
    } else {
      return 0;
    }
  }

  Future<List> getAll() async {
    Database? dbLivro = await db;
    if (dbLivro != null) {
      List listMap = await dbLivro.query(LivroContract.livroTable);
      List<Livro> listLivros = [];

      for (Map m in listMap) {
        listLivros.add(Livro.fromMap(m));
      }
      return listLivros;
    } else {
      return [];
    }
  }
}