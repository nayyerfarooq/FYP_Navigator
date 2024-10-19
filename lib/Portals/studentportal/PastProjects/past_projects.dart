import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp_navigator/Portals/studentportal/PastProjects/past_project_detail.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PastProjectListScreen extends StatelessWidget {
  final String session;

  PastProjectListScreen({required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects $session'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('projects')
            .where('session', isEqualTo: session) // Query by session
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error fetching projects.'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No projects found.'));
          }

          var projects = snapshot.data!.docs;

          return ListView.builder(
            itemCount: projects.length,
            itemBuilder: (context, index) {
              var project = projects[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(project['projectName'] ?? 'Untitled'),
                subtitle: Text(project['supervisor'] ?? 'No supervisor'),
                onTap: () {
                  Get.to(() => ProjectDetailsScreen(projectId: projects[index].id));
                },

              );
            },
          );
        },
      ),
    );
  }
}
