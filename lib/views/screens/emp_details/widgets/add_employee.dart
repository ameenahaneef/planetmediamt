import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:planetmediamt/controllers/employee_controller.dart';
import 'package:planetmediamt/utils/constants.dart';
  final EmployeeController _controller = Get.put(EmployeeController());


void showAddEmployeeDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController ageController = TextEditingController();
    final TextEditingController salaryController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Employee'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: ageController,
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: salaryController,
                decoration: const InputDecoration(labelText: 'Salary'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                _controller.addEmployee(
                  nameController.text,
                  salaryController.text,
                  ageController.text,
                );
                Navigator.of(context).pop();
                Get.snackbar(
                  'Success',
                  'Employee added successfully',
                  backgroundColor: textColor,
                );
              },
            ),
          ],
        );
      },
    );
  }