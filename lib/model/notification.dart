class Notifications {
  final int id;
  final String title;
  final DateTime date;
  final String notificationMessage;

  Notifications({this.id, this.title, this.date, this.notificationMessage});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'date': date.toIso8601String(),
        'notificationMessage': notificationMessage
      };
}
