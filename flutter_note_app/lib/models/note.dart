class Note {
  String? id;
  String? userID;
  String? title;
  String? content;
  DateTime? dateadded;

  Note({this.id, this.content, this.dateadded, this.title, this.userID});

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map["id"],
      userID: map["userID"],
      content: map["content"],
      dateadded: DateTime.tryParse(map["dateAdded"]),
      title: map["title"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "userID":userID,
      "title":title,
      "content":content,
      "dateAdded": dateadded!.toIso8601String(),
    };
  }
}
