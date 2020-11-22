
import 'package:flutter/cupertino.dart';
import 'package:todo_flutter_provider/models/Notes.dart';

class NotesProvider extends ChangeNotifier{

  //Notes list
  List<Notes> _notes = List<Notes>();
  List<Notes> get getNotes{
    return _notes;
  }

  //function to add data to list
  void addNotes(String title, String description){
    Notes note = new Notes(title,description);
    _notes.add(note);
    notifyListeners();
  }
  void removeNotes(int index){
    _notes.removeAt(index);
    notifyListeners();
  }
}