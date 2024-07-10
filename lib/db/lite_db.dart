import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class LiteDb {
  static Database? _database;
  Future<Database?>get getInstance async{
    if(_database==null)
      {
          _database=await init();
          return _database;
        }
    else{
      return _database;
      }
  }
  init() async {
    ///get bd location
    var datapathPath=await getDatabasesPath();
    String path=join(datapathPath,'mybd.db');
    // open the database
    Database database = await openDatabase(path, version: 2,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
            ''' CREATE TABLE PERSON (id INTEGER  PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, age INTEGER);
                CREATE TABLE ACCOUNT (id INTEGER  PRIMARY KEY AUTOINCREMENT, PERSON_ID INTEGER NOT  NULL, ACCOUNT INTEGER NOT NULL, VALUE REAL);
              '''
          );},
        onUpgrade: (Database db, int oldVersion, int newVersion) async {
          if (newVersion >= 2) {
            await db.execute('''
            ALTER TABLE PERSON ADD COLUMN salary REAL NULL;
            
            
            ''');
          }
        }

    );

    print('data base has been created');
    return database;

  }
  inquery(String sqlTxt)async{
    Database? db=await getInstance;
    List<Map> list = await db!.rawQuery(sqlTxt);
    return list;


  }
  insert(String sqlTxt)async{
    Database? db=await getInstance;
    int count = await db!.rawInsert(sqlTxt);
    return count;


  }
  update(String sqlTxt)async{
    Database? db=await getInstance;
    int count = await db!.rawUpdate(sqlTxt);
    return count;


  }
  delete(String sqlTxt)async{
    Database? db=await getInstance;
    int count = await db!.rawDelete(sqlTxt);
    return count;


  }

}