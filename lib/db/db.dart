import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/imc.dart';

class DB {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "diobb");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await createTableIMC(db); // IMC
  }

  Future<void> createTableIMC(Database db) async {
    await db.execute('''
      CREATE TABLE imc (
        localId TEXT PRIMARY KEY,
        nome TEXT,
        peso DOUBLE,
        altura DOUBLE,
        data TEXT,
        resultado DOUBLE,
        classificacao TEXT
      )
    ''');
  }

  Future<void> addIMC(IMC imc) async {
    final dbClient = await db;
    await dbClient.insert('imc', {
      'localId': imc.localId,
      'nome': imc.nome,
      'peso': imc.peso,
      'altura': imc.altura,
      'data': imc.data,
      'resultado': imc.resultado,
      'classificacao': imc.classificacao
    });
    print("imc save");
  }

  Future<List<IMC>> getIMCDB() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query('imc');
    List<IMC> imc = [];
    maps.forEach((map) {
      if (map['status'] != "delete") {
        imc.add(IMC(
          localId: map['localId'],
          nome: map['nome'],
          peso: map['peso'],
          altura: map['altura'],
          data: map['data'],
          resultado: map['resultado'],
          classificacao: map['classificacao']
        ));
      }
    });
    print(maps.length);
    return imc;
  }
}
