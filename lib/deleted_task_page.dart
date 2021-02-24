import 'package:flutter/material.dart';
import 'package:todo_app/networker.dart';
import 'package:provider/provider.dart';

class DeletedTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Networker networker = Provider.of<Networker>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Recently Deleted Tasks'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 740,
              child: ListView.builder(
                itemCount: networker.deletedTasks.length,
                itemBuilder: (context, int i) {
                  return ListTile(
                    title: Text(networker.deletedTasks[i].taskName),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'DELETED',
                          style: TextStyle(color: Colors.red),
                        ),
                        Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
