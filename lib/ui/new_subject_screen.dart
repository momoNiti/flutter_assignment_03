import 'package:flutter/material.dart';
import 'package:flutter_assignment_03/model/todo.dart';

class NewSubject extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return NewSubjectState();
  }
}
class NewSubjectState extends State<NewSubject>{

  final _formKey = GlobalKey<FormState>();

  final textController = TextEditingController();

  TodoProvider provider = TodoProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Subject"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: textController,
              validator: (value){
                if (value.isEmpty){
                  return "Please fill subject";
                }
              },
              decoration: InputDecoration(
                labelText: "Subject",
                contentPadding: const EdgeInsets.all(15)
              ),
            ),
            RaisedButton(
              child: Text("Save"),
              onPressed: () async {
                if(_formKey.currentState.validate()){
                  await provider.open("todo.db");
                  Todo todo = Todo();
                  todo.title = textController.text;
                  todo.done = false;
                  await provider.insert(todo);
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    );
  }

}