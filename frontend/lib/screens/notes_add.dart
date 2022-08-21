import 'package:flutter/material.dart';
import 'package:notesapp/model/notes.dart';
import 'package:notesapp/provider/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewNote extends StatefulWidget {
  final bool isUpdate;
  final Notes? note;
  const AddNewNote({Key? key, required this.isUpdate, this.note})
      : super(key: key);

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  FocusNode noteFocus = FocusNode();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void addNewNote() {
    if (titleController.text != "") {
      Notes newNote = Notes(
          id: const Uuid().v1(),
          userid: 'ishwar',
          title: titleController.text,
          content: contentController.text,
          dateAddedOn: DateTime.now());
      Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Note Added')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Title can't be empty"),
        backgroundColor: Colors.red,
      ));
    }
  }

  void updateNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Note Updated')));
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Add Note'),
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
              child: IconButton(
                onPressed: () {
                  if (widget.isUpdate) {
                    updateNote();
                  } else {
                    addNewNote();
                  }
                },
                icon: const Icon(Icons.check),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 10, 0, 0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              autofocus: (widget.isUpdate == true) ? false : true,
              onSubmitted: (val) {
                if (val != "") {
                  noteFocus.requestFocus();
                }
              },
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                  hintText: 'Title', border: InputBorder.none),
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                focusNode: noteFocus,
                maxLines: null,
                style: const TextStyle(fontSize: 25),
                decoration: const InputDecoration(
                    hintText: 'Note', border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
