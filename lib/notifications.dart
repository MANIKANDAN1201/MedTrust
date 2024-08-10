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

              return ListTile(
                title: Text(message),
                subtitle: Text('${timestamp.toLocal()}'),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                tileColor:
                    Colors.grey[200], // Optional: style the tile background
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(12), // Optional: rounded corners
                ),
              );
            },
          );
        },
      ),
    );
  }
}
