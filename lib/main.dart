import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/View/Register.dart';
import 'package:flutterapp/firebase_options.dart';

void main() {
  runApp(const MyApp());
}

// 1 statement and collections in dart
void StatementAndCollections() {
  // if and else
  var name = 'testing';
  if (name == 'testing') {
    print('The name is rigth///');
  } else if (name == 'test') {
    print("The name is wrong///");
  } else {
    print("The name isn't work");
  }

  // Operators
  final age = 20;
  final higthAge = age * 2;
  print(" age: ${higthAge}");

  // Lists
  final listDart = ["Math", "Khmer", "English"];
  final oneName = listDart[0];
  print(listDart);
  print(oneName);

  // Sets
  final setsDart = {"Java", "Js", "Html", "Css"};
  setsDart.add("Java");
  setsDart.add("Python");
  print(setsDart);

  // Maps is using to hold key-value pairs of information
  var person = {"name": "sok", "age": 30};
  print(person);
  person['name'] = "newName";
  print(person);
  person['name'] = "men";
  print(person);
}

// 2 sound null safely in dart
void SoundNullSafely(String? firstName, String? middleName, String? lastName) {
  //  Making any type nullable
  String? name = null;
  name = 'name';
  print(name);
  name = null; // This is allowed because name is nullable
  print(name);
  List<String?> nullableList = ['one', null, 'three'];
  print(nullableList);

  // Cherry-picking non-null values
  final firstNonNull = firstName ?? middleName ?? lastName;
  print(firstNonNull);

  // Null-aware assignment operater
  String? names = firstName;
  // names ??= middleName;
  names ??= lastName;
  print(names);

  // Conditional invocation
  List<String>? nameList = ['MEN', "yo"];
  // List<String>? nameList = null?;
  final numberOfNames = nameList?.length;
  print(numberOfNames);
}

// 3 Enumeration Classes and objects
// 3.1 Enumeration
enum MyEnum { value1, value2, value3 }

void myEnumFunction(MyEnum myEnum) {
  switch (myEnum) {
    case MyEnum.value1:
      print("This is value 1");

    case MyEnum.value2:
      print("This is value 2");
    case MyEnum.value3:
      print("This is value 3");
      break;
  }
}

// 3.2 Classes
class person2 {
  // mehtods
  final String na;
  person2(this.na);
  void run() {
    print("running");
  }

  void walk() {
    print(na);
    print("walking");
  }

  void stop() {
    print("stopping");
  }
}

// inheritance and subclassing
class pa {
  void run() {
    print("running from pa");
  }

  void walk() {
    print("walking from pa");
  }
}

class Ta extends pa {}

// Abstract class
abstract class Person {
  void run();
  void walk();
  void stop();
}

// Factory Construtor
class PersonFactory {
  final String pname;
  PersonFactory(this.pname);
  factory PersonFactory.fa() {
    return PersonFactory('Factory Name');
  }
}

// Customer Operators
class CustomerPerson {
  String name;
  CustomerPerson(this.name);

  @override
  bool operator ==(covariant CustomerPerson other) => name == other.name;

  @override
  int get hashCode => name.hashCode;
}

void main2() {
  final person = person2('John Doe');
  person.run();
  person.walk();
  person.stop();

  final ta = Ta();
  ta.run();
  ta.walk();

  final fa = PersonFactory.fa();
  print(fa.pname);

  final person1 = CustomerPerson('John');
  final person24 = CustomerPerson('John');
  if (person24 == person1) {
    print("person24 is equal to person1");
  } else {
    print("person24 is not equal to person1");
  }
}

// 4 Advanced Dart Concepts
class AdvancedDart {
  final String name;
  AdvancedDart(this.name);
}

class Data {
  final String firstName;
  final String lastName;
  Data(this.firstName, this.lastName);
}

// extension using for adding logic to exisiting classes
extension Run on AdvancedDart {
  void run() {
    print('name $name is running');
  }
}

extension FullName on Data {
  String get fullName => '$firstName $lastName';
}

// future using for data to be returned in the future, as it's name suggests
Future<int> heavy(int a) {
  return Future.delayed(const Duration(seconds: 2), () {
    return a * 2;
  });
}

// Streams using for an asynchronous "pipe" of data
Stream<String> getName() {
  // return Stream.value("Foood");
  return Stream.periodic(const Duration(seconds: 1), (count) {
    return "Food $count";
  });
}

// Generators useing for generating "iterable", maked with sync* and async*
Iterable<int> generateNames() sync* {
  yield 1;
  yield 2;
  yield 3;
}

// Generics using for to avoid re-returing similar code
class GenericClass<A, D> {
  final A va1;
  final D va2;
  GenericClass(this.va1, this.va2);
}

// async and await using for Mechanism for controll asynchronous flow of data
void Ad() async {
  final meow = AdvancedDart('Meow');
  meow.run();

  final data = Data('John', 'Doe');
  print(data.fullName);

  final result = await heavy(10);
  print(result);

  // await for (final name in getName()) {
  //   print(name);
  // }

  for (final valuse in generateNames()) {
    print(valuse);
  }

  final name = GenericClass('John', 30);
  name;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    StatementAndCollections();
    SoundNullSafely(null, 'test', 'men');
    myEnumFunction(MyEnum.value1);
    main2();
    Ad();
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  // Action when Home is tapped
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  // Action when Settings is tapped
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text(
            'Flutter Course',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Action when settings icon is pressed
              },
            ),
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final user = FirebaseAuth.instance.currentUser;
                final emailVerified = user?.emailVerified ?? false;
                if (emailVerified) {
                  print('Email is verified');
                } else {
                  print('Email is not verified');
                }
                return const Text(
                  'Home',
                  style: TextStyle(fontSize: 24, color: Colors.green),
                );
              default:
                return const Text('Loading...');
            }
          },
        ),
      ),
    );
  }
}
