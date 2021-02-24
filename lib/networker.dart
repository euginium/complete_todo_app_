import 'package:flutter/cupertino.dart';
import 'package:todo_app/task_model.dart';

class Networker with ChangeNotifier {
  List<TaskModel> taskList = [
    TaskModel(taskName: 'one', validator: false),
    TaskModel(taskName: 'two', validator: false),
    TaskModel(taskName: 'three', validator: false),
  ];

  List<TaskModel> deletedTasks = [];
  List<TaskModel> fulfilledTasks = [];
}
