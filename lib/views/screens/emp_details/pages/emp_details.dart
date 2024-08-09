import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planetmediamt/controllers/employee_controller.dart';
import 'package:planetmediamt/utils/constants.dart';

class EmployeeDetails extends StatelessWidget {
  final int employeeId;
  final Color containerColor;

  const EmployeeDetails(
      {super.key, required this.employeeId, required this.containerColor});

  @override
  Widget build(BuildContext context) {
    final EmployeeController _controller = Get.find<EmployeeController>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.fetchEmployeeById(employeeId);
    });

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          'Employee Details',
          style: TextStyle(color: textColor),
        ),
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final employee = _controller.selectedEmployee.value;
        if (employee == null) {
          return Center(
            child: Text(
              'Employee not found',
              style: TextStyle(color: textColor),
            ),
          );
        }

        return Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: employee.profileImage.isNotEmpty
                            ? NetworkImage(employee.profileImage)
                            : null,
                        child: employee.profileImage.isEmpty
                            ? const Icon(
                                Icons.person,
                                size: 50,
                              )
                            : null,
                      ),
                      height20,
                      Text(
                        'Name: ${employee.employeeName}',
                        style: style,
                      ),
                      height10,
                      Text(
                        'Age: ${employee.employeeAge}',
                        style: style,
                      ),
                      height10,
                      Text(
                        'Salary: \$${employee.employeeSalary}',
                        style: style,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
