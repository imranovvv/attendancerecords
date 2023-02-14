import 'package:flutter/material.dart';
import 'user.dart';

class AttendanceDetails extends StatelessWidget {
  // In the constructor, require a record.
  const AttendanceDetails({super.key, required this.record});

  // Declare a field that holds the record.
  final User record;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Details'),
      ),
      body: Card(
        margin: const EdgeInsets.all(4),
        elevation: 8,
        child: ListTile(
          // Name
          title: Text(
            record.user,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            // Phone number
            record.phone,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          trailing: Text(
            // Date/Timeago
            record.checkIn.toString(),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
