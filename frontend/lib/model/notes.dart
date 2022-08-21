class Notes {
  String? id;
  String? userid;
  String? title;
  String? content;
  DateTime? dateAddedOn;

  Notes({this.id, this.userid, this.title, this.content, this.dateAddedOn});

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      id: map['id'],
      userid: map['userid'],
      title: map['title'],
      content: map['content'],
      dateAddedOn: DateTime.tryParse(map['dateAddedOn']),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userid": userid,
      "title": title,
      "content": content,
      "dateAddedOn": dateAddedOn!.toIso8601String()
    };
  }
}
