import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/bloc/todo_event.dart';
import 'package:todo/bloc/todo_state_bloc.dart';
import 'package:todo/helper/db_helper.dart';
import 'package:todo/models/todo_model.dart';

class TodoBloc extends Bloc<TodoEvent, TodoBlocState> {
  final DbHelper dbHelper;
  TodoBloc()
    : dbHelper = DbHelper.getInstance(),
      super(TodoBlocState(mData: [])) {
    on<GetToDoEvent>((event, emit) async {
      List<ToDoModel> todos = await dbHelper.fetchAllToDo();
      emit(TodoBlocState(mData: todos));
    });

    on<AddToDoEvent>((event, emit) async {
      bool? check = await dbHelper.addToDo(
        newToDo: ToDoModel(
          title: event.title,
          description: event.description,
          createdAt: event.createdAt,
        ),
      );
      if (check) {
        List<ToDoModel> todos = await dbHelper.fetchAllToDo();
        emit(TodoBlocState(mData: todos));
      }
    });

    on<DeleteToDoEvent>((event, emit) async {
      bool check = await dbHelper.deleteToDo(event.id);
      if (check) {
        List<ToDoModel> todos = await dbHelper.fetchAllToDo();
        emit(TodoBlocState(mData: todos));
      }
    });
  }
}
