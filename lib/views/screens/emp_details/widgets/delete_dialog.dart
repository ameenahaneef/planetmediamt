import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:planetmediamt/controllers/employee_controller.dart';
import 'package:planetmediamt/utils/constants.dart';

  final EmployeeController _controller = Get.put(EmployeeController());


void showDeleteConfirmationDialog(BuildContext context, int employeeId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this employee?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                _controller.deleteEmployee(employeeId);
                Navigator.of(context).pop();
                Get.snackbar(
                  'Success',
                  'Employee deleted successfully',
                  backgroundColor:textColor,
                );
              },
            ),
          ],
        );
      },
    );
  }