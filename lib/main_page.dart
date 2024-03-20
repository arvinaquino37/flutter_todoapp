import 'package:flutter/material.dart';
import 'package:flutter_todoapp/add_todo.dart';
import 'package:flutter_todoapp/widget/todoList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String text = 'Simple Text';
  List<String> todoList = [];

  void changeText({required String todoText}) {
    if(todoList.contains(todoText)){
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text('Already Exist'),
          content: Text('This todo data already exist'),
          actions: [
            TextButton(
                onPressed: (){
              Navigator.pop(context);
            }, child: Text('Close', style: TextStyle(color: Colors.black),))
          ],
        );
      },);
      return;
    }
    // print('Hello World');
    setState(() {
      // text = 'Hello World';
      todoList.insert(0, todoText); // insert data in a specific index
      // todoList.add(todoText);
      text = todoText;
      print('main page: $text');
    });
    updateLocalData();
    Navigator.pop(context);
  }

  void updateLocalData() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save an list of strings to 'items' key.
    await prefs.setStringList('todoList', todoList);
    setState(() {});
  }

  void readLocalData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
// Try reading data from the 'items' key. If it doesn't exist, returns null.
    final List<String>? items = prefs.getStringList('todoList');
    // todoList = items!;
    setState(() {
      // prefs == [] ? Text('Empty Todo') : (prefs.getStringList('todoList') ?? []).toList();
      todoList = (prefs.getStringList('todoList') ?? []).toList();
    });
  }

  void onItemClicked() {
    showModalBottomSheet(
      context: context, builder: (context) {
      return Padding(
        // padding: EdgeInsets.zero,
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 200,
          child: Padding(
              padding: EdgeInsets.all(20),
              child: AddTodo(onPressed: changeText,)),
        ),
      );
    },);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readLocalData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.blueGrey[900],
              child: Center(child: Text('Todo App', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse('https://www.linkedin.com/in/arvindaleaquino/'));
              },
              leading: Icon(Icons.person),
              title: Text('About Me', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse('mailto:arvinaquino37@gmail.com'));
              },
              leading: Icon(Icons.email),
              title: Text('Contact Me', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
           InkWell(
             onTap: onItemClicked,
             child: Padding(
                padding: EdgeInsets.all(10),
                child: Icon(Icons.add)),
           )
        ],
        // backgroundColor: Colors.blue[200],
        centerTitle: true,
        title: Text('Flutter Todo App', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: todoList.isEmpty
          ? Center(child: Text('Empty Todo List', style: TextStyle(fontWeight: FontWeight.bold),))
          : TodoList(todoList: todoList, updateLocalData: updateLocalData,),
      /* floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey[900]),
          onPressed: (){}, child: Text('Add', style: TextStyle(color: Colors.white),)) */
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // FloatingActionButton(onPressed: (){}, child: Icon(Icons.edit, color: Colors.white), shape: CircleBorder(), backgroundColor: Colors.blueGrey[900]),
          // SizedBox(height: 10,),
          // FloatingActionButton(onPressed: (){}, child: Icon(Icons.delete, color: Colors.white), shape: CircleBorder(), backgroundColor: Colors.blueGrey[900]),
          // SizedBox(height: 10,),
          FloatingActionButton(onPressed: onItemClicked, child: Icon(Icons.add, color: Colors.white), shape: CircleBorder(), backgroundColor: Colors.blueGrey[900]),
        ],
      ),
    );
  }
}
