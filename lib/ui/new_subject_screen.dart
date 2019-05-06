import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewSubject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewSubjectState();
  }
}

class NewSubjectState extends State<NewSubject> {
  final _formKey = GlobalKey<FormState>();

  final textController = TextEditingController();

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
              validator: (value) {
                if (value.isEmpty) {
                  return "Please fill subject";
                }
              },
              decoration: InputDecoration(
                  labelText: "Subject",
                  contentPadding: const EdgeInsets.all(15)),
            ),
            RaisedButton(
              child: Text("Save"),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  Firestore.instance
                      .collection('todo')
                      .document()
                      .setData({'title': textController.text, 'done': false});
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
