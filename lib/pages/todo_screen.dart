import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/bloc/todo_bloc.dart';
import 'package:todo/bloc/todo_event.dart';
import 'package:todo/bloc/todo_state_bloc.dart';
import 'package:todo/contant/app_route.dart';
import 'package:todo/contant/color.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/widget/custom_text.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoListState();
}

class _TodoListState extends State<TodoScreen> {
  List<ToDoModel> mData = [];

  DateFormat df = DateFormat.yMMMEd();

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(GetToDoEvent(mData: mData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: CustomText(text: 'TO DO'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<TodoBloc, TodoBlocState>(
        builder: (ctx, state) {
          mData = state.mData;
          return mData.isNotEmpty
              ? ListView.builder(
                itemCount: mData.length,
                itemBuilder: (context, index) {
                  var eachDate = DateTime.fromMicrosecondsSinceEpoch(
                    int.parse(mData[index].createdAt),
                  );
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: colorList[index]['color'],
                      ),
                      child: GestureDetector(
                        child: ListTile(
                          title: Row(
                            children: [
                              CustomText(text: mData[index].title, size: 20),
                              const Spacer(),
                              CustomText(text: df.format(eachDate), size: 15),
                            ],
                          ),
                          subtitle: CustomText(
                            text: mData[index].description,
                            size: 18,
                          ),
                          onLongPress: () {
                            showBottomSheet(
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.black),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          text: "Are you sure to delete?",
                                          size: 25,
                                        ),
                                        const SizedBox(height: 15),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Cancel"),
                                            ),
                                            const SizedBox(width: 20),
                                            OutlinedButton(
                                              onPressed: () async {
                                                context.read<TodoBloc>().add(
                                                  DeleteToDoEvent(
                                                    id: mData[index].id!,
                                                  ),
                                                );
                                                Navigator.pop(context);
                                              },
                                              child: Text("Delete"),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              )
              : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/logo/folder.png", width: 250),
                    const SizedBox(height: 15),
                    CustomText(text: "No ToDo yet...", size: 25),
                  ],
                ),
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoute.ROUTUE_ADD_TODO);
        },
        child: Icon(Icons.add, color: Colors.black, size: 35),
      ),
    );
  }
}
