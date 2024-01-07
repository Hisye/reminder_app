import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewReminder extends StatefulWidget {
  late final Function addReminder;
  NewReminder(this.addReminder);

  @override
  State<NewReminder> createState() => _NewReminderState();
}

class _NewReminderState extends State<NewReminder> {
  //Define the variable 
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late TextEditingController _dateController;

//init state to get the dateTime.now() into the form
  @override
  void initState() {
    super.initState();
    _dateController =
        TextEditingController(text: DateFormat('dd-MM-yyyy').format(_selectedDate));
  }

  late DateTime _selectedDate = DateTime.now();

//submit data
  void submitData() {
    final enteredTitle = titleController.text;
    final enteredDescription = descriptionController.text;

//to verify data entry
    if (enteredTitle.isEmpty || enteredDescription.isEmpty) {
      print('Title and description cannot be empty.');
      return;
    }

    widget.addReminder(enteredTitle, enteredDescription, _selectedDate);
    Navigator.of(context).pop();
    print('#Debug1 - Passing 1..');
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2033),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'New Task',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                        prefixIcon: const Icon(
                          Icons.note_add,
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        floatingLabelStyle: const TextStyle(
                          fontSize: 18,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1.5),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      controller: titleController,
                      onFieldSubmitted: (_) => submitData(),
                      //onChanged: (val) => { titleInput = val},   // Note: 1st approach
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                        prefixIcon: const Icon(
                          Icons.comment,
                          size: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        floatingLabelStyle: const TextStyle(
                          fontSize: 18,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1.5),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      controller: descriptionController,
                      onFieldSubmitted: (_) => submitData(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        labelStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                        prefixIcon: const Icon(Icons.calendar_today, size: 20),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        floatingLabelStyle: const TextStyle(
                          fontSize: 18,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1.5),
                            borderRadius: BorderRadius.circular(10)),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _presentDatePicker();
                            });
                          },
                          child: const Icon(Icons.edit),
                        ),
                      ),
                      readOnly: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                          ),
                          onPressed: () {
                            submitData();
                          },
                          child: const Text('Add Reminder', style: TextStyle(color: Colors.white),),
                        ),
                        const SizedBox(width: 10,),
                        TextButton(onPressed: () {
                          Navigator.of(context).pop();
                        }, child: const Text('Cancel', selectionColor: Colors.blueGrey,))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}
