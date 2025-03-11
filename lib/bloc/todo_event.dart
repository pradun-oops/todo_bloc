import 'package:todo/models/todo_model.dart';

abstract class TodoEvent {}

class GetToDoEvent extends TodoEvent {
  final List<ToDoModel> mData;
  GetToDoEvent({required this.mData});
}

class AddToDoEvent extends TodoEvent {
  String title;
  String description;
  String createdAt;
  AddToDoEvent({
    required this.title,
    required this.description,
    required this.createdAt,
  });
}

class DeleteToDoEvent extends TodoEvent {
  final int id;
  DeleteToDoEvent({required this.id});
}
