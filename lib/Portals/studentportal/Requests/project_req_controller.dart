import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_navigator/CustomWidgets/Snakbar.dart';
import 'package:get/get.dart';

class ProjectRequestController extends GetxController {
  // Variable to store all fetched project data
  var projectList = <Map<String, dynamic>>[].obs;

  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void onInit() {
    super.onInit();
    if (currentUser != null) {
      fetchProjectDetails(currentUser!.uid);
    }
  }

  // Fetch project details for the specific student
  Future<void> fetchProjectDetails(String studentId) async {
    try {
      // Fetch the project details where 'studentId' matches
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection('projects')
          .where('studentId', isEqualTo: studentId)
          .get();
      projectList.clear();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          var projectData = doc.data();
          projectData['projectId'] = doc.id;
          projectList.add(projectData);
        }
        print('Projects fetched: ${projectList.length}');
      } else {
        print('No project found for this student');
      }
    } catch (e) {
      showErrorSnackbar('Failed to fetch project details: $e');
    }
  }

  Future<void> deleteProject(String projectId) async {
    try {
      if (projectId.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('projects')
            .doc(projectId)
            .delete();
        projectList.removeWhere((project) => project['projectId'] == projectId);
        showSuccessSnackbar('Project deleted successfully');
      } else {
        showErrorSnackbar('No project found to delete');
      }
    } catch (e) {
      showErrorSnackbar('Failed to delete project: $e');
    }
  }

  // Access project data by index
  Map<String, dynamic>? getProjectByIndex(int index) {
    if (index < projectList.length) {
      return projectList[index];
    }
    return null;
  }
}
