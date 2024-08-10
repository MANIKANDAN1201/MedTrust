import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  final String message;

  const NotificationsScreen({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Color.fromARGB(255, 145, 183, 241), // Dark Blue Color
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Notifications')
            .orderBy('timestamp',
                descending: true) // Sort notifications by timestamp
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No notifications available.'));
          }

          final notifications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification =
                  notifications[index].data() as Map<String, dynamic>;
              final message = notification['message'];
              final timestamp =
                  (notification['timestamp'] as Timestamp).toDate();

              final formattedDate =
                  '${timestamp.toLocal().toString().split(' ')[0]}';
              final formattedTime =
                  '${timestamp.toLocal().toString().split(' ')[1]}';

              return Dismissible(
                key: Key(
                    notifications[index].id), // Use the document ID as the key
                background: Container(
                  color: Colors.red, // Background color when swiped
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  // Handle the deletion logic here (e.g., remove from list temporarily)
                  // Note: This will only remove the notification locally from the UI.
                  // To actually delete from Firestore, you would need to implement the deletion logic.
                },
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Color.fromARGB(
                      143, 123, 165, 241), // Use the color #9999D0
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Center(
                      child: Text(
                        message,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // White text for better contrast
                        ),
                      ),
                    ),
                    subtitle: Center(
                      child: Text(
                        'Date: $formattedDate\nTime: $formattedTime',
                        style: TextStyle(
                          color: Colors.white70, // Slightly transparent white
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
