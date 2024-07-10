import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqlite_app/manager/db_helper.dart';

import '../models/person.dart';

class PersonDetails extends StatefulWidget {
  const PersonDetails({super.key, required this.person});
  final Person person;


  @override
  State<PersonDetails> createState() => _PersonDetailsState();
}

class _PersonDetailsState extends State<PersonDetails> {
  DbHelper dbHelper=DbHelper();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController positionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.person.name;
    ageController.text = widget.person.age.toString();
    salaryController.text = widget.person.salary.toString();
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        title: Text(widget.person.name),
        backgroundColor: Colors.pink,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 15.0, left: 15.0),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'name',
                    icon: Icon(Icons.title),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 15.0, left: 15.0),
                child: TextField(
                  controller: ageController,
                  decoration: const InputDecoration(
                    labelText: 'age',
                    icon: Icon(Icons.apps_outage_outlined),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 15.0, left: 15.0),
                child: TextField(
                  controller: salaryController,
                  decoration: const InputDecoration(
                    labelText: 'salary',
                    icon: Icon(Icons.monetization_on_sharp),
                  ),
                ),
              ),

              // Fourth Element
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: Colors.green,
                            textStyle: const TextStyle(color: Colors.white),
                            padding: const EdgeInsets.all(8.0)
                        ) ,
                        child: const Text( 'Save',textScaleFactor: 1.5,),
                        onPressed: () {
                          Person person=widget.person;
                          person.name=nameController.text;
                          person.age=int.parse(ageController.text);
                          person.salary=double.parse(salaryController.text);
                          _saveData(person);


                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            backgroundColor: Colors.red,
                            textStyle: const TextStyle(color: Colors.white),
                            padding: const EdgeInsets.all(8.0)
                        ) ,
                        child: const Text( 'Delete',textScaleFactor: 1.5,),
                        onPressed: () async {
                          await _deletePerson(widget.person);

                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _saveData(Person person)async{
    if(person.id==0)
      {
        await dbHelper.insertNewPerson(person);

      }else{
      await dbHelper.updatePerson(person);
    }
    moveToBack();


  }
  _deletePerson(Person person)async{
    if(person.id>0)
      await dbHelper.deletePerson(person);
    moveToBack();
  }
  void moveToBack(){
    Navigator.pop(context,true);
  }
}
