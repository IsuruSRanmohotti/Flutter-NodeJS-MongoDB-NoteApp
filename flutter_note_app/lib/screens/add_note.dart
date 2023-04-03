import 'package:flutter/material.dart';
import 'package:flutter_note_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/note.dart';

class AddNewPage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewPage({Key? key, required this.isUpdate, this.note})
      : super(key: key);

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {
  FocusNode notefocus = FocusNode();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  void addNewNote() {
    Note newNote = Note(
      id: const Uuid().v1(),
      userID: "User",
      title: titleController.text,
      content: contentController.text,
      dateadded: DateTime.now(),
    );

    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void updateNote() {
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    widget.note!.dateadded = DateTime.now();
    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isUpdate == true) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                if (widget.isUpdate == true) {
                  updateNote();
                } else {
                  addNewNote();
                }
              },
              icon: const Icon(Icons.check))
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onSubmitted: (val) {
                if (val != "") {
                  notefocus.requestFocus();
                }
              },
              autofocus: (widget.isUpdate == true) ? false : true,
              controller: titleController,
              style: const TextStyle(fontSize: 25),
              decoration: const InputDecoration(
                  hintText: "Title", border: InputBorder.none),
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                focusNode: notefocus,
                maxLines: null,
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                    hintText: "Description", border: InputBorder.none),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
