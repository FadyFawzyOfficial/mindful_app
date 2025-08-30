import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:sembast/sembast_io.dart'
    show
        Database,
        DatabaseFactory,
        databaseFactoryIo,
        intMapStoreFactory,
        SembastStoreRefExtension,
        Finder;
import 'package:sembast/utils/import_export_io.dart';

import 'quote.dart';

class DbHelper {
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database? db;
  final store = intMapStoreFactory.store('quotes');

  //! 2. Create a static instance that will hold a single instance of the DbHelper class.
  static final _instance = DbHelper._internal();

  //! 1. Create a private constructor calling it _internal with an underscore.
  //? This will prevent direct instantiation of the class from outside.
  DbHelper._internal();

  //! 3. Create the factory constructor itself. Here, I'll return the instance.
  //? Note that differently form the constructors I generally use that always
  //? return an new instance of the class, with a factory constructor, you can
  //? decide what returns, and this means generally a new instance of the class or
  //! an existing one.
  factory DbHelper() => _instance;

  //! Make sure I open the database only once. I'll create a getter
  Future<Database> get _db async {
    db ??= await _openDb();
    return db!;
  }

  Future<Database> _openDb() async {
    final docsPath = await getApplicationDocumentsDirectory();
    final dbPath = join(docsPath.path, 'quotes.db');
    final db = await dbFactory.openDatabase(dbPath);
    return db;
  }

  Future<int> insertQuote(Quote quote) async {
    try {
      Database db = await _db;
      int id = await store.add(db, quote.toMap());
      return id;
    } on Exception catch (_) {
      return 0;
    }
  }

  Future<List<Quote>> getQuotes() async {
    Database db = await _db;
    final finder = Finder(sortOrders: [SortOrder('q')]);
    final quotesSnapShot = await store.find(db, finder: finder);
    return quotesSnapShot.map((item) {
      final quote = Quote.fromMap(item.value);
      quote.id = item.key;
      return quote;
    }).toList();
  }

  Future<bool> deleteQuote(int id) async {
    try {
      final db = await _db;
      await store.record(id).delete(db);
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
