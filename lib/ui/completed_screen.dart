import 'package:flutter/material.dart';
import 'package:flutter_assignment_02/model/todo.dart';

class Completed extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return CompletedState();
  }

}
class CompletedState extends State<Completed>{

  TodoProvider provider = TodoProvider();
  List<Todo> todoes;
  int count = 0;
  void getList() async{
    await provider.open("todo.db");
    provider.getTodoesDone().then((todoes){
      setState(() {
        this.todoes = todoes;
        count = todoes.length;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    getList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: (){
              provider.deleteTodoesDone();
            },
          )
        ],
      ),
      body: Center(
        child: count == 0? Text(
          "No data found..",
          style: TextStyle(
            fontSize: 18.0
          ),
          ):
        ListView.builder(
          itemCount: todoes.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position){
            return Column(
              children: <Widget>[
                Divider(height: 5.0,),
                CheckboxListTile(
                  title: Text(todoes[position].title),
                  value: todoes[position].done,
                  onChanged: (bool value){
                    setState(() {
                      todoes[position].done = value;
                    });
                    provider.update(todoes[position]);
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}