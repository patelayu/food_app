
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../Globals/allproducts.dart';
import '../model/products.dart';


class DBHelper {
  DBHelper._();

  static final DBHelper dbHelper = DBHelper._();

  final String databaseName = "foodProduct.db";
  final String tableName = "foodProduct";
  final String colId = "id";
  final String colName = "name";
  final String colImage = "image";
  final String colPrice = "price";
  final String colQuantity = "quantity";

  Database? db;

  Future<void> init() async {
    var directoryPath = await getDatabasesPath();
    String path = join(directoryPath, databaseName);

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          String query =
              "CREATE TABLE IF NOT EXISTS $tableName ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colImage BLOB, $colQuantity INTEGER, $colPrice INTEGER);";

          await db.execute(query);
        });
  }

  Future<void> insertRecord() async {
    await init();

    for (int i = 0; i < Global.food.length; i++) {
      Product data = Product.fromMap(data: Global.food[i]);

      String query =
          "INSERT INTO $tableName($colName, $colImage, $colPrice, $colQuantity) VALUES(?, ?, ?, ?);";
      List args = [
        data.name,
        data.image,
        data.price,
        data.quantity,
      ];

      await db!.rawInsert(query, args);
    }
  }

  Future<List<ProductDB>> fetchAllRecode() async {
    await init();
    await insertRecord();

    String query = "SELECT * FROM $tableName";

    List<Map<String, dynamic>> data = await db!.rawQuery(query);

    List<ProductDB> productDB =
    data.map((e) => ProductDB.fromMap(data: e)).toList();

    return productDB;
  }
}