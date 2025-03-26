import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String? id;
  String title;
  String description;
  bool isDone;
  String? uid;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
    this.isDone = false,
    this.uid,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    isDone: json['isDone'],
    uid: json['uid'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'isDone': isDone,
    'uid': uid,
  };

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isDone,
    String? uid,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      uid: uid ?? this.uid,
    );
  }

  TodoModel.fromDocumentSnapshot(DocumentSnapshot doc)
    : id = doc.id,
      title = doc['title'],
      description = doc['description'],
      isDone = doc['isDone'],
      uid = doc['uid'];
}
