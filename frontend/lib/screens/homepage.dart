import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/model/notes.dart';
import 'package:notesapp/provider/notes_provider.dart';
import 'package:notesapp/screens/notes_add.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: Colors.teal,
      ),
      body: SafeArea(
          child: (notesProvider.notes.isNotEmpty)
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: notesProvider.notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    Notes currentNote = notesProvider.notes[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => AddNewNote(
                                      isUpdate: true,
                                      note: currentNote,
                                    )));
                      },
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete ?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('No')),
                                  TextButton(
                                      onPressed: () {
                                        notesProvider.deleteNote(currentNote);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text('Note Deleted')));
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Yes')),
                                ],
                              );
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            // gradient: const LinearGradient(
                            //     begin: Alignment.centerLeft,
                            //     end: Alignment.centerRight,
                            //     colors: [Colors.purple, Colors.blue]),
                            border: Border.all(color: Colors.grey),
                            color: Colors.blue,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentNote.title!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              currentNote.content!,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey[700]),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : (notesProvider.notes.isEmpty)
                  ? const Center(
                      child: Text('No notes yet'),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const AddNewNote(
                        isUpdate: false,
                      )));
        }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
