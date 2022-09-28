import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project2/GenerateColor.dart';

import 'User.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<String> namesList = [
    "MohammadReza",
    "Mahdi",
    "Ali",
    "Reza",
    "Mina",
    "Sahar",
    "Sara",
    "Sanaz",
    "Hossein",
    "Ahmad"
  ];
  List<User> usersList = List.generate(
      namesList.length,
      (index) =>
          User(namesList[index], GenerateColor().getColor(namesList[index])));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyApp"),
      ),
      body: Container(
        color: Colors.grey.shade300,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView.builder(
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(usersList[index].name),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.endToStart) {
                      return await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Delete Item [${usersList[index].name}]"),
                            content: Text(
                                "Are You Sure to Delete ${usersList[index].name} ?"),
                            actions: [
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                                child: Text("NO"),
                              ),
                              OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text("YES",
                                      style: TextStyle(color: Colors.red))),
                            ],
                          );
                        },
                      );
                    } else {
                      return snackbar(usersList[index],index);
                    }
                  },
                  background: Card(
                    color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(children: [
                        Icon(Icons.archive_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Archive")
                      ]),
                    ),
                  ),
                  secondaryBackground: Card(
                    color: Colors.redAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Text("Delete"),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.archive_outlined),
                      ]),
                    ),
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      usersList.removeAt(index);
                    });
                  },
                  child: Card(
                    elevation: 0,
                    child: Container(
                      alignment: Alignment.center,
                      height: 100,
                      // color: usersList[index].color,
                      child: Text(
                        usersList[index].name,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                );
              },
              itemCount: usersList.length),
        ),
      ),
    );
  }

  bool snackbar(User user,int i) {
    bool result = true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Add To Archive"),
        action: SnackBarAction(label: "Dismiss",onPressed: (){

          setState(() {
            result = false;
            usersList.insert(i, user);
          });
        }),
      ),
    );
    return result;
  }
}
