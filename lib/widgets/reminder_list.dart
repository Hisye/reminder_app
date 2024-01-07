import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder/model/reminder.dart';

class ReminderList extends StatefulWidget {
  final List<Reminder> reminders;
  final Function deleteReminder;

  ReminderList(this.reminders, this.deleteReminder);

  @override
  State<ReminderList> createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  
  @override
  Widget build(BuildContext context) {
    if (widget.reminders.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No reminder task yet..!',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    } else {
      //sort the date inside the list
      widget.reminders.sort((a, b) => a.date.compareTo(b.date));

      return ListView.builder(
        itemCount: widget.reminders.length,
        itemBuilder: (context, index) {
          Reminder reminder = widget.reminders[index];
          DateTime date = reminder.date ?? DateTime.now();
          String dateString = DateFormat('MMMM d, y').format(date);

          // Check if this is the first item or if the date has changed
          bool isFirstItem = index == 0;
          bool isNewDate =
              isFirstItem || !isSameDay(widget.reminders[index - 1].date, date);

          // Add print statements for debugging
          print(
              'Index: $index, Date: $dateString, isNewDate: $isNewDate, Reminder Date: ${reminder.date}');

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isNewDate)
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 5, left: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Divider(color: Colors.black,),
                      // const SizedBox(height: 5,),
                      Text(
                        formatDateString(date),
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              Card(
                color: reminder.isDone == true ? Colors.green : (reminder.isDone == false ? null : Colors.grey),
                child: ListTile(
                  title: Text(
                    reminder.title,
                    style: const TextStyle(fontSize: 18),
                  ),
                  subtitle: Text(reminder.description),
                  trailing: IconButton(
                    onPressed: () {
                      widget.deleteReminder(reminder.id);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  onLongPress: () {
                    setState(() {
                      // Add a null check before accessing isDone
                      if (reminder.isDone == null) {
                        reminder.isDone = false;
                      } else {
                        reminder.isDone = !reminder.isDone;
                      }
                    });
                  },
                ),
              ),
            ],
          );
        },
      );
    }
  }
  String formatDateString(DateTime date) {
    DateTime now = DateTime.now();
    if (isSameDay(date, now)) {
      return 'Today';
    } else if (isSameDay(date, now.add(const Duration(days: 1)))) {
      return 'Tomorrow';
    } else {
      return DateFormat('MMMM d, y').format(date);
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
