import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/deleted_task_page.dart';
import 'package:todo_app/fulfilled_page.dart';
import 'package:todo_app/task_model.dart';
import 'networker.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Networker networker = Provider.of<Networker>(context);

    //tasklist builder function
    Widget _taskListBuilder() {
      if (networker.taskList.length > 0) {
        return ListView.builder(
          itemCount: networker.taskList.length,
          itemBuilder: (context, int i) {
            //Slidable widget below is from the flutter_slidder dependency
            return Slidable(
              actionPane: SlidableDrawerActionPane(),
              actions: [
                //DELETE TASK
                IconSlideAction(
                  onTap: () {
                    setState(() {
                      networker.deletedTasks.add(TaskModel(
                        taskName: networker.taskList[i].taskName,
                      ));
                      networker.taskList.removeAt(i);
                    });
                    return;
                  },
                  icon: Icons.delete,
                  color: Colors.red,
                ),
              ],
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.list),
                    title: Text(
                      '${networker.taskList[i].taskName}',
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      'date',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                      ),
                    ),
                    trailing: Checkbox(
                      value: networker.taskList[i].validator,
                      onChanged: (value) {
                        setState(() {
                          networker.taskList[i].validator = value;
                        });
                        // widget used below is from flutter_dialogs dependency
                        return showPlatformDialog(
                          context: (context),
                          builder: (_) => BasicDialogAlert(
                            title: Text('Complete Task'),
                            content: Text('Are you done with the task?'),
                            actions: [
                              //Cancel button
                              BasicDialogAction(
                                title: Text(
                                  'NOT YET',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  setState(() {
                                    networker.taskList[i].validator = !value;
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              //OK button
                              BasicDialogAction(
                                title: Text(
                                  'YES',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  setState(() {
                                    networker.fulfilledTasks.add(TaskModel(
                                        taskName:
                                            networker.taskList[i].taskName,
                                        validator: true));
                                    networker.taskList.removeAt(i);
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      activeColor: Colors.orangeAccent.shade700,
                    ),
                  ),
                  Divider(
                    indent: 18,
                    endIndent: 18,
                    thickness: 1.5,
                  ),
                ],
              ),
            );
          },
        );
      } else {
        return Center(
          child: Text(
            'There are no tasks today.\nPress the "+" to add new tasks',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
          ),
        );
      }
    }

    //todolist subtitle function
    Text _buildUnfulfilledTaskTextWidget() {
      if (networker.taskList.length <= 1) {
        return Text(
          'There is ${networker.taskList.length.toString()} unfulfilled task in total',
          style: TextStyle(fontSize: 20),
        );
      } else {
        return Text(
          'There are ${networker.taskList.length.toString()} unfulfilled tasks in total',
          style: TextStyle(fontSize: 20),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade700,
      body: SafeArea(
        child: Column(
          children: [
            //top headers
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                //simple
                                TextSpan(
                                  text: 'Simple',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 30,
                                  ),
                                ),
                                //todo
                                TextSpan(
                                  text: 'ToDo',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Icon(
                          Icons.check_circle_outline,
                          size: 30,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 12.0),
                          child: _buildUnfulfilledTaskTextWidget(),
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 2,
                      endIndent: 60,
                      indent: 10,
                    ),
                    Row(
                      children: [
                        FlatButton.icon(
                          icon: Icon(Icons.archive_outlined),
                          label: Text(
                            '${networker.deletedTasks.length.toString()} Recently deleted',
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DeletedTaskPage(),
                              ),
                            );
                          },
                        ),
                        FlatButton.icon(
                          icon: Icon(Icons.history),
                          label: Text(
                            '${networker.fulfilledTasks.length.toString()} fulfilled tasks',
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => FulfilledTaskPage()),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            //Tasks list
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: _taskListBuilder(),
                  ),
                  Positioned(
                    bottom: 15,
                    right: 15,
                    child: FloatingActionButton(
                      backgroundColor: Colors.blueGrey.shade700,
                      onPressed: () {
                        //widget used below is from adaptive_dialog dependency
                        return showTextInputDialog(
                          context: (context),
                          textFields: [
                            DialogTextField(
                              hintText: 'Input task',
                              maxLines: 1,
                              validator: (value) {
                                setState(() {
                                  networker.taskList.add(
                                    TaskModel(
                                      taskName: value,
                                      validator: false,
                                    ),
                                  );
                                });
                                return;
                              },
                            ),
                          ],
                          style: AdaptiveStyle.adaptive,
                          title: 'New Task',
                          cancelLabel: 'cancel',
                          okLabel: 'add task',
                        );
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
