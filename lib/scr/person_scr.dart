
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlite_app/manager/db_helper.dart';
import 'package:sqlite_app/scr/person_details.dart';
import '../models/person.dart';

class PersonScr extends StatefulWidget {
  const PersonScr({Key? key}) : super(key: key);

  @override
  State<PersonScr> createState() => _PersonScrState();
}

class _PersonScrState extends State<PersonScr> {
  List<Person>? personList;
  DbHelper dbHelper=DbHelper();
  int count = 0;
  void updateList()async {
    personList = await dbHelper.getAllData();
    setState(() {});
    /*personList?.add(Person(id: 1, name: 'Ahmed', age: 23));
    personList?.add(Person(id: 2, name: 'Mohamed', age: 25));
    personList?.add(Person(id: 3, name: 'Ahmed', age: 30));
    personList?.add(Person(id: 4, name: 'Ali', age: 35));
    personList?.add(Person(id: 5, name: 'Ahmed', age: 40));*/
  }

  @override
  void initState() {
    updateList();
  }

  @override
  Widget build(BuildContext context) {
    if (personList==null)
      {
        personList=[];
        updateList();
      }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'daily app',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: personListView(
            data: personList!,
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Person.getNewEmpty());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }

  ListView personListView({
    required List<Person> data,
  }) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          color: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: CircleAvatar(
              child: Image.asset('assets/images/person.png'),
            ),
            title: Text(
              data[index].name,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            subtitle: Text(data[index].age.toString()+'\n'+data[index].salary.toString(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                )),
            trailing: IconButton(
              icon: Icon(
                Icons.info,
                color: Colors.white,
              ),
              onPressed: () {
                navigateToDetail(data[index]);
              },
            ),
          ),
        );
      },
      itemCount: data.length,
    );
  }

  void navigateToDetail(Person person) async {
    bool result = await Navigator.push(context as BuildContext,
        MaterialPageRoute(builder: (context) {
      return PersonDetails(person: person);
    }));
    if (result == true) {
      updateList();
    } else if (result == false) {
      const Text("No Notes to Show");
    }
  }
}
