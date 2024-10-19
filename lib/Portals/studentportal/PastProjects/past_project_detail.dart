import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fyp_navigator/CustomWidgets/Snakbar.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final String projectId;

  ProjectDetailsScreen({required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text('Project Details'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('PastProjects')
            .doc(projectId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading project details.'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('Project not found.'));
          }

          var projectData = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Project Name: ${projectData['projectName']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('Description: ${projectData['description']}'),
                const SizedBox(height: 10),
                Text('Supervisor: ${projectData['supervisor']}'),
                const SizedBox(height: 10),
                Text('Student1: ${projectData['Student1'] ?? 'None'}'),
                const SizedBox(height: 10),
                Text('Student2: ${projectData['Student2'] ?? 'None'}'),
                const SizedBox(height: 20),
                // Display download button if SRS document URL is available
                projectData.containsKey('fileUrl') && projectData['fileUrl'] != null
                    ? ElevatedButton.icon(
                  onPressed: () async {
                    String srsFileUrl = projectData['fileUrl'];
                    if (await canLaunchUrl(Uri.parse(srsFileUrl))) {
                      await launchUrl(Uri.parse(srsFileUrl), mode: LaunchMode.externalApplication);
                    } else {
                      showErrorSnackbar('Failed to open the document.');
                    }
                  },
                  icon: const Icon(Icons.download),
                  label: const Text('Download SRS Document'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                )
                    : const Text('No SRS document available', style: TextStyle(color: Colors.red)),
              ],
            ),
          );
        },
      ),
    );
  }
}
