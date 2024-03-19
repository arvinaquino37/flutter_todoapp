import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoList extends StatefulWidget {
  List<String> todoList;
  Function() updateLocalData;
  TodoList({Key? key, required this.todoList, required this.updateLocalData}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  void onItemClicked({required int index}){
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
            onPressed: (){
              setState(() {
                widget.todoList.removeAt(index);
              });
              widget.updateLocalData();
              Navigator.pop(context);
            },
            child: Text('Mark as Done')
        ),
      );
    },);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.todoList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          secondaryBackground: Container(color: Colors.red, child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.delete),
              ))),
          background: Container(color: Colors.green, child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.check),
              ))),
          onDismissed: (direction) {
            setState(() {
              widget.todoList.removeAt(index);
              widget.updateLocalData();
            });

            // setState(() {});
          },
          child: ListTile(
            /* onLongPress: (){
              print(index);
              setState(() {
                todoList.removeAt(index);
              });
            }, */
            onTap: (){
              // print('$index number');
              onItemClicked(index: index);
            },
            leading: CircleAvatar(
                maxRadius: 15,
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                child: Text('${index + 1}')),
            title: Text('${widget.todoList[index]}'),
          ),
        );
      },);
  }
}
