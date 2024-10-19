import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_project_controller.dart';

class AddProject extends StatelessWidget {
  final AddProjectController controller = Get.put(AddProjectController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Final Year Project"),
        backgroundColor: Colors.tealAccent[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              Text(
                "Enter Project Details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.tealAccent[700],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),

              // Project Name
              TextFormField(
                controller: controller.projectNameController,
                decoration: InputDecoration(
                  labelText: 'Project Name',
                  labelStyle: TextStyle(color: Colors.tealAccent[700]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Session
              TextFormField(
                controller: controller.sessionController,
                decoration: InputDecoration(
                  labelText: 'Session (e.g. 2020-2024)',
                  labelStyle: TextStyle(color: Colors.tealAccent[700]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Partner
              TextFormField(
                controller: controller.partnerController,
                decoration: InputDecoration(
                  labelText: 'Partner (Optional)',
                  labelStyle: TextStyle(color: Colors.tealAccent[700]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Supervisor (Dropdown from Firebase)
              Obx(() {
                if (controller.supervisors.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }
                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Supervisor',
                    labelStyle: TextStyle(color: Colors.tealAccent[700]),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  value: controller.selectedSupervisor.value.isEmpty ? null : controller.selectedSupervisor.value,
                  items: controller.supervisors
                      .map((supervisor) => DropdownMenuItem(
                    value: supervisor,
                    child: Text(supervisor),
                  ))
                      .toList(),
                  onChanged: (value) {
                    controller.selectedSupervisor.value = value!;
                  },
                );
              }),
              SizedBox(height: 16),

              // Domain of Project
              Obx(() {
                return DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Domain of Project',
                    labelStyle: TextStyle(color: Colors.tealAccent[700]),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  value: controller.selectedDomain.value.isEmpty ? null : controller.selectedDomain.value,
                  items: controller.domains
                      .map((domain) => DropdownMenuItem(
                    value: domain,
                    child: Text(domain),
                  ))
                      .toList(),
                  onChanged: (value) {
                    controller.selectedDomain.value = value!;
                  },
                );
              }),
              SizedBox(height: 16),

              // Project Description
              TextFormField(
                controller: controller.descriptionController,
                decoration: InputDecoration(
                  labelText: 'Project Description',
                  labelStyle: TextStyle(color: Colors.tealAccent[700]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                maxLines: 2,
              ),
              SizedBox(height: 24),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  controller.submitProject();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent[700],
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text('Submit Project',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
