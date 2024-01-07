import 'package:flutter/material.dart';
import 'package:reminder/model/reminder.dart';
import 'package:reminder/widgets/new_reminder.dart';
import 'package:reminder/widgets/reminder_list.dart';

void main() {
  runApp( MaterialApp(
    home: MyHomePage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.greenAccent,
      primarySwatch: Colors.lightGreen
    ),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Reminder> reminders = [];

  void addNewReminder(String title, String description, DateTime date) {
    final newReminder = Reminder(
        id: DateTime.now().toString(),
        title: title,
        description: description,
        date: date);

    print(newReminder);
    setState(() {
      reminders.add(newReminder);
    });
  }
// delete method to delete the reminder
  void _deleteReminder(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Reminder'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning,
                size: 50,
                color: Colors.red,
              ),
              SizedBox(height: 10),
              Text(
                'Are you sure you want to delete this reminder?',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  reminders.removeWhere((element) => element.id == id);
                });
                Navigator.of(context).pop(); 
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: const Icon(
            Icons.person_2_rounded,
          ),
          title: const Text('Reminder'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) =>
                        NewReminder(addNewReminder),
                  );
                },
                icon: const Icon(
                  Icons.add,
                )),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: ReminderList(reminders, _deleteReminder),
        ));
  }
}
