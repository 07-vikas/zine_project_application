import 'package:flutter/material.dart';
import 'db/database_helper.dart';
import 'models/notification_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Storage App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotificationListScreen(),
    );
  }
}

class NotificationListScreen extends StatefulWidget {
  @override
  _NotificationListScreenState createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  final dbHelper = DatabaseHelper();

  // List to store notifications
  List<NotificationModel> notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications(); // Load notifications from database on app start
  }

  // Load notifications from SQLite database
  void _loadNotifications() async {
    final data = await dbHelper.getNotifications();
    setState(() {
      notifications = data;
    });
  }

  // Insert a dummy notification for testing purposes
  void _addDummyNotification() async {
    NotificationModel notification = NotificationModel(
      title: 'Test Notification',
      text: 'This is a test notification.',
    );
    await dbHelper.insertNotification(notification);
    _loadNotifications(); // Refresh the list after adding
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stored Notifications'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addDummyNotification, // Add a dummy notification
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index].title),
            subtitle: Text(notifications[index].text),
          );
        },
      ),
    );
  }
}
