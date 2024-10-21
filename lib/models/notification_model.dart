class NotificationModel {
  final int? id; // id will be auto-incremented by the database
  final String title;
  final String text;

  NotificationModel({this.id, required this.title, required this.text});

  // Convert NotificationModel to a Map to store in the database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
    };
  }

  // Create a NotificationModel from a Map (retrieved from the database)
  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'],
      title: map['title'],
      text: map['text'],
    );
  }
}
