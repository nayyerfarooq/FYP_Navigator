// lib/screens/dashboard/student_dashboard.dart
import 'package:flutter/material.dart';

class StudentDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
      ),
      body: Center(
        child: Text(
          'Welcome Student!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
