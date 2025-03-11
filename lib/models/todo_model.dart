import 'package:todo/helper/db_helper.dart';

class ToDoModel {
  int? id;
  String title;
  String description;
  String createdAt;

  ToDoModel({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory ToDoModel.fromMap(Map<String, dynamic> map) {
    return ToDoModel(
      id: map[DbHelper.TODO_TABLE_ID],
      title: map[DbHelper.TODO_TITLE],
      description: map[DbHelper.TODO_DESCRIPTION],
      createdAt: map[DbHelper.TODO_CREATED_AT],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DbHelper.TODO_TABLE_ID: id,
      DbHelper.TODO_TITLE: title,
      DbHelper.TODO_DESCRIPTION: description,
      DbHelper.TODO_CREATED_AT: createdAt,
    };
  }
}
