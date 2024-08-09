 import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:planetmediamt/controllers/employee_controller.dart';
import 'package:planetmediamt/models/employee_model.dart';

  final EmployeeController _controller = Get.put(EmployeeController());

void showEditDialog(BuildContext context, Employee employee, int index) {
    final TextEditingController nameController =
        TextEditingController(text: employee.employeeName);
    final TextEditingController ageController =
        TextEditingController(text: employee.employeeAge.toString());
    final TextEditingController salaryController =
        TextEditingController(text: employee.employeeSalary.toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Employee'),
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
              child: const Text('Save'),
              onPressed: () {
                _controller.updateEmployee(
                  employee.id!,
                  nameController.text,
                  salaryController.text,
                  ageController.text,
                );
                Navigator.of(context).pop();
               
              },
            ),
          ],
        );
      },
    );
  }
