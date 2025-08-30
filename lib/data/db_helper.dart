import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:sembast/sembast_io.dart'
    show Database, DatabaseFactory, databaseFactoryIo;

class DbHelper {
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database? db;

  Future<Database> _openDb() async {
    final docsPath = await getApplicationDocumentsDirectory();
    final dbPath = join(docsPath.path, 'quotes.db');
    final db = await dbFactory.openDatabase(dbPath);
    return db;
  }
}
