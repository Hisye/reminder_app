//reminder class
class Reminder {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  bool isDone ;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isDone = false,
  });
}