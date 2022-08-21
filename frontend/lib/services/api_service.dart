import 'dart:convert';
import 'dart:developer';
import 'package:notesapp/model/notes.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class ApiService {
  static String _baseUrl = "https://lit-ravine-66836.herokuapp.com/notes";

  static Future<void> addNote(Notes note) async {
    Uri requestUri = Uri.parse(_baseUrl + "/add");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<void> deleteNote(Notes note) async {
    Uri requestUri = Uri.parse(_baseUrl + "/delete");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<List<Notes>> fetchNotes(String userid) async {
    Uri requestUri = Uri.parse(_baseUrl + "/lists");
    var response = await http.post(requestUri, body: {"userid": userid});
    var decoded = jsonDecode(response.body);
    log(decoded.toString());

    List<Notes> notes = [];
    for (var noteMap in decoded) {
      Notes newNote = Notes.fromMap(noteMap);
      notes.add(newNote);
    }

    return notes;
  }
}
