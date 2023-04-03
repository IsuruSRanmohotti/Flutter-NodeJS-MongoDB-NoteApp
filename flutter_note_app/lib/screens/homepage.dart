import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_app/providers/notes_provider.dart';
import 'package:flutter_note_app/screens/add_note.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);

    return (notesProvider.isLoading == false)
        ? SafeArea(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: const Text("Notes App"),
              ),
              body:ListView(
                      children: [
                        TextField(
                          onChanged: (val) {
                            setState(() {});
                            searchQuery = val;
                          },
                          decoration: InputDecoration(hintText: "Search"),
                        ),
                        (notesProvider.getFilteredNotes(searchQuery).isNotEmpty)?
                        GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: notesProvider.getFilteredNotes(searchQuery).length,
                          itemBuilder: (context, index) {
                            Note currentNote = notesProvider.getFilteredNotes(searchQuery)[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => AddNewPage(
                                              isUpdate: true,
                                              note: currentNote,
                                            )));
                              },
                              onLongPress: () {
                                notesProvider.deleteNote(currentNote);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentNote.title!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        currentNote.content!,
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ): const Center(
                      child: Text("No notes yet"),
                    ),
                      ],
                    ),
                  
              floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: ((context) => const AddNewPage(
                                  isUpdate: false,
                                ))));
                  },
                  child: const Icon(Icons.add)),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
