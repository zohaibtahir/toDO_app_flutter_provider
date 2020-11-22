import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_flutter_provider/models/Notes.dart';
import 'package:todo_flutter_provider/models/NotesProvider.dart';

class Home_Screen extends StatelessWidget {

  BuildContext myContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("To Do using provider"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<NotesProvider>(
          builder: (context,NotesProvider data,child){
            return data.getNotes.length !=0 ? ListView.builder(
              itemCount: data.getNotes.length,
                itemBuilder: (context,index){
                return CardList(data.getNotes[index],index);
                },
            ): GestureDetector(onTap: (){
                showAlertDialouge(context);
            },child: Center(
              child: Text("Add some notes",style: TextStyle(color: Colors.black87),),
            ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showAlertDialouge(context);
      },
        backgroundColor: Colors.green,
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}

class CardList extends StatelessWidget {
  final Notes notes;
  int index;

  CardList(this.notes, this.index);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
      child: Builder(
        builder: (BuildContext context){
          BuildContext rootContext = context;
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  )
              ),
              child: ListTile(
                leading: Icon(
                    Icons.note,
                  color: Colors.white,
                ),
                title: Text(notes.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                subtitle: Text(notes.description,style: TextStyle(color: Colors.white)),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,),
              ),
            ),
            secondaryActions: [
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red[400],
                icon: Icons.delete,
                onTap: (){
                  print("Hello Deleted");
                  Provider.of<NotesProvider>(rootContext,listen: false).removeNotes(index);
                },
              )
            ],
          );
        },
      ),
    );
  }
}
showAlertDialouge(BuildContext context){
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();

  Widget okButton = FlatButton(
      onPressed: (){
        Provider.of<NotesProvider>(context,listen: false).addNotes(_title.text, _description.text);
        Navigator.of(context).pop();
      },
      child: Text("Add Note"),
  );

  AlertDialog alert = AlertDialog(
    title: Text("Add a new note"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: _title,
          decoration: InputDecoration(hintText: "Enter Title"),
        ),
        TextField(
          controller: _description,
          decoration: InputDecoration(hintText: "Enter Desciption"),
        ),
      ],
    ),
    actions: [
      okButton,
    ],
  );
  showDialog(
      context: context,
    builder: (BuildContext context){
        return alert;
    }
  );
}
