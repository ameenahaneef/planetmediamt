import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planetmediamt/controllers/employee_controller.dart';
import 'package:planetmediamt/utils/constants.dart';
import 'package:planetmediamt/views/screens/emp_details/pages/emp_details.dart';
import 'package:planetmediamt/views/screens/emp_details/widgets/add_employee.dart';
import 'package:planetmediamt/views/screens/emp_details/widgets/delete_dialog.dart';
import 'package:planetmediamt/views/screens/emp_details/widgets/edit_employee.dart';
import 'package:planetmediamt/views/screens/emp_details/widgets/logout_dialog.dart';

class EmployeeScreen extends StatelessWidget {
  final EmployeeController _controller = Get.put(EmployeeController());

  final List<Color> _containerColors = [
    Colors.pink[100]!,
    Colors.blue[100]!,
    Colors.green[100]!,
    Colors.yellow[100]!,
    Colors.orange[100]!,
    Colors.purple[100]!,
  ];

  EmployeeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        actions: [
          IconButton(
            onPressed: () {
              showLogoutConfirmationDialog(context);
            },
            icon: Icon(
              Icons.logout,
              color: textColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(() {
          if (_controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (_controller.employees.isEmpty) {
            return  Center(
              child: Text(
                "No Employees Found",
                style: TextStyle(color:textColor),
              ),
            );
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 1200
                  ? 6
                  : constraints.maxWidth > 800
                      ? 4
                      : 2;

              double childAspectRatio = constraints.maxWidth > 1200
                  ? 1 / 1.5
                  : constraints.maxWidth > 800
                      ? 1 / 1.5
                      : 3 / 4;

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: childAspectRatio,
                ),
                itemBuilder: (context, index) {
                  final employee = _controller.employees[index];
                  final containerColor =
                      _containerColors[index % _containerColors.length];
                  return GestureDetector(
                    onTap: () {
                      if (employee.id != null) {
                        Get.to(() => EmployeeDetails(
                              employeeId: employee.id!,
                              containerColor: containerColor,
                            ));
                      } else {
                        Get.snackbar(
                          'Error',
                          'Employee ID is missing',
                          backgroundColor: textColor,
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: containerColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    showEditDialog(context, employee, index);
                                  } else if (value == 'delete') {
                                    showDeleteConfirmationDialog(
                                        context, employee.id!);
                                  }
                                },
                                itemBuilder: (BuildContext context) {
                                  return [
                                    const PopupMenuItem(
                                      value: 'edit',
                                      child: Text('Edit'),
                                    ),
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Text('Delete'),
                                    ),
                                  ];
                                },
                                icon: const Icon(Icons.more_vert),
                              ),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: employee.profileImage.isNotEmpty
                                  ? NetworkImage(employee.profileImage)
                                  : null,
                              child: employee.profileImage.isEmpty
                                  ? const Icon(
                                      Icons.person,
                                      size: 30,
                                    )
                                  : null,
                            ),
                            Text(employee.employeeName),
                            Text('${employee.employeeAge}'),
                            Text('${employee.employeeSalary}'),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: _controller.employees.length,
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddEmployeeDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
