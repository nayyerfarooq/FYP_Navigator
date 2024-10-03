import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_navigator/CustomWidgets/Snakbar.dart';
import 'package:get/get.dart';

Future<void> createSuperVisorAndAddData(String name, String email,
    String password, String department) async {
  try {
    // Create a user account with email and password
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    String uid = userCredential.user!.uid;

    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    // Create a new user document with the UID as the document ID
    await users.doc(uid).set({
      'name': name,
      'email': email,
      'password':password,
       'role':'supervisor',
      'department': department,
      'createdAt': FieldValue.serverTimestamp(), // Optional: add timestamp
    });
     Get.back();
    showSuccessSnackbar('User account created and data added successfully with UID: $uid');
  } catch (e) {
    showErrorSnackbar('Error creating user or adding data: $e');
  }
}

Future<void> deleteSupervisor(String supervisorId) async {
  try {
    // Reference to the Firestore collection
    CollectionReference supervisorsCollection = FirebaseFirestore.instance.collection('Users');

    await supervisorsCollection.doc(supervisorId).delete();

    showSuccessSnackbar('Supervisor with ID: $supervisorId deleted successfully.');
  } catch (e) {
    showErrorSnackbar('Error deleting supervisor: $e');
  }
}
