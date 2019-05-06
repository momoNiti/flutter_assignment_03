import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Completed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CompletedState();
  }
}

class CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('todo')
            .where('done', isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Todo"),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        QuerySnapshot query = await Firestore.instance
                            .collection('todo')
                            .where('done', isEqualTo: true)
                            .getDocuments();
                        query.documents.forEach((each) {
                          final DocumentReference postRef = Firestore.instance
                              .document('todo/' + each.documentID);
                          Firestore.instance
                              .runTransaction((Transaction tx) async {
                            DocumentSnapshot postSnapshot =
                                await tx.get(postRef);
                            if (postSnapshot.exists) {
                              await tx.delete(postRef);
                            }
                          });
                        });
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
