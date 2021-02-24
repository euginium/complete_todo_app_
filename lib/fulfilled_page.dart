import 'package:flutter/material.dart';
import 'package:todo_app/networker.dart';
import 'package:provider/provider.dart';

class FulfilledTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Networker networker = Provider.of<Networker>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Fulfilled Tasks'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 740,
              child: ListView.builder(
                itemCount: networker.fulfilledTasks.length,
                itemBuilder: (context, int i) {
                  return ListTile(
                    title: Text(networker.fulfilledTasks[i].taskName),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'FULFILLED',
                          style: TextStyle(color: Colors.green),
                        ),
                        Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
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
