class Person{
   int id;
   String name;
   int age;
   double salary;
  Person({required this.id,required this.name,required this.age,this.salary=0,});
  factory Person.getNewEmpty(){
    return Person(id: 0,name: "",age: 0,salary: 0,);
  }
  factory Person.fromMap(Map<dynamic,dynamic>map){
    return Person(id: map['id']??0,name: map['name']??'',age: map['age']??0,
    salary: map['salary']??0
    );

  }
}