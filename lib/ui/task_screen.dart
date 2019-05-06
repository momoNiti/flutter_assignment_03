import 'package:flutter/material.dart';
import 'package:flutter_assignment_03/ui/new_subject_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Task extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskState();
  }
}

class TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('todo')
            .where('done', isEqualTo: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Todo"),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewSubject()));
                      },
                    )
                  ],
                ),
                body: Center(
                  child: snapshot.data.documents.length == 0
                      ? Text(
                          "No data found..",
                          style: TextStyle(fontSize: 18.0),
                        )
                      : ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          padding: const EdgeInsets.all(15.0),
                          itemBuilder: (context, position) {
                            return Column(
                              children: <Widget>[
                                Divider(
                                  height: 5.0,
                                ),
                                CheckboxListTile(
                                  title: Text(snapshot.data.documents[position]
                                      ['title']),
                                  value: snapshot.data.documents[position]
                                      ['done'],
                                  onChanged: (bool value) {
                                    final DocumentReference postRef =
                                        Firestore.instance.document('todo/' +
                                            snapshot.data.documents[position]
                                                .documentID);
                                    Firestore.instance
                                        .runTransaction((Transaction tx) async {
                                      DocumentSnapshot postSnapshot =
                                          await tx.get(postRef);
                                      if (postSnapshot.exists) {
                                        await tx.update(postRef,
                                            <String, dynamic>{'done': value});
                                      }
                                    });
                                  },
                                )
                              ],
                            );
                          },
                        ),
                ));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
