import 'package:sqlite_app/db/lite_db.dart';
import 'package:sqlite_app/models/person.dart';

class DbHelper extends LiteDb {

   getAllData()async{
    List<Person>person=[];

    String sqlTxt = "SELECT * FROM person";
    List<Map>myMap=await inquery(sqlTxt);
    for(int i=0;i<myMap.length;i++){
     person.add(Person.fromMap(myMap[i]));
    }
    return person;


  }
   insertNewPerson(Person person) async {
     String sql = '''
       INSERT INTO PERSON(name, age, salary)
       VALUES ( '${person.name}' , ${person.age} , ${person.salary})
    ''';
     int result = await insert(sql);
     return result;
   }
   updatePerson(Person person) async {
     String sql = '''
       UPDATE PERSON SET 
       name = '${person.name}',
       age = ${person.age},
       salary = ${person.salary}
       WHERE 
       id = ${person.id}
    ''';
     int result = await update(sql);
     return result;
   }
   deletePerson(Person person)async{
     String sql ='''
    DELETE FROM PERSON
    WHERE id=${person.id}
    ''';
     int result=await delete(sql);
     return result;
   }


}
