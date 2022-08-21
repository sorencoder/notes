import 'package:flutter/cupertino.dart';
import 'package:notesapp/model/notes.dart';
import 'package:notesapp/services/api_service.dart';

class NotesProvider with ChangeNotifier {
  NotesProvider() {
    fetchNotes();
  }
  List<Notes> notes = [];

  void addNote(Notes note) {
    notes.add(note);
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Notes note) {
    int indexofNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexofNote] = note;
    notifyListeners();
    ApiService.addNote(note);
  }

  void deleteNote(Notes note) {
    int indexofNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexofNote);
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void fetchNotes() async {
    notes = await ApiService.fetchNotes("ishwar");
    notifyListeners();
    // sortNotes();
    // isLoading = false;
  }
}
