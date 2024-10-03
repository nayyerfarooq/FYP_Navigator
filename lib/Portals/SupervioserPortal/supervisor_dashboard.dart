// lib/screens/dashboard/supervisor_dashboard.dart
import 'package:flutter/material.dart';

class SupervisorDashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Supervisor Dashboard'),
      ),
      body: Center(
        child: Text(
          'Welcome Supervisor!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
