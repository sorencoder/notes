import 'package:flutter/cupertino.dart';
import 'package:notesapp/model/notes.dart';
import 'package:notesapp/services/api_service.dart';

class NotesProvider with ChangeNotifier {
  NotesProvider() {
    fetchNotes();
  }
  List<Notes> notes = [];

  //add a note to the database & notify the UI
  void addNote(Notes note) {
    notes.add(note);
    notifyListeners();
    ApiService.addNote(note);
  }

  //update a note to the database & notify the UI
  void updateNote(Notes note) {
    int indexofNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexofNote] = note;
    notifyListeners();
    ApiService.addNote(note);
  }

  //delete a note to the database & notify the UI
  void deleteNote(Notes note) {
    int indexofNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexofNote);
    notifyListeners();
    ApiService.deleteNote(note);
  }

  //fetch a note to the database & notify the UI
  void fetchNotes() async {
    notes = await ApiService.fetchNotes("ishwar");
    notifyListeners();
    // sortNotes();
    // isLoading = false;
  }
}
