import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  String? text;
  void Function({required String todoText}) onPressed;
  AddTodo({Key? key, this.text, required this.onPressed}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController todo = TextEditingController();

  void onSubmitted () {
    // widget.text = todo.text;
    if(todo.text.isNotEmpty) {
      print(todo.text);
      widget.onPressed(todoText: todo.text);
      todo.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Add Todo:'),
        TextField(
          onSubmitted: (value) {
            onSubmitted();
            print('textfield print: $value');
          },
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Write something here...'
          ),
          controller: todo,
        ),
        ElevatedButton(
            onPressed: (){
              // widget.text = todo.text;
              if(todo.text.isNotEmpty) {
                print(todo.text);
                widget.onPressed(todoText: todo.text);
                todo.text = '';
              }
            }, child: Text('Add'))
      ],
    );
  }
}
