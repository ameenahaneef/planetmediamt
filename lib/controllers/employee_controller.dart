import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planetmediamt/models/apiservices/employee_servies.dart';
import 'package:planetmediamt/models/employee_model.dart';

class EmployeeController extends GetxController {
  var employees = <Employee>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var selectedEmployee = Rxn<Employee>();
  var showRetryButton = false.obs;
  final EmployeeService _employeeService = EmployeeService();

  @override
  void onInit() {
    super.onInit();
    fetchEmployees();
  }

  void fetchEmployees() async {
    try {
      isLoading(true);
      errorMessage.value = '';
      showRetryButton(false);
      var employeeList = await _employeeService.fetchEmployees();

      employees.assignAll(employeeList);
    } catch (e) {
      if (e is RateLimitException) {
        showRetryButton(true);
      } else {
        Get.snackbar('Error', 'Failed to load employees',
            backgroundColor: Colors.white);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchEmployeeById(int id) async {
    try {
      isLoading(true);
      errorMessage.value = '';
      var employee = await _employeeService.fetchEmployeeById(id);
      selectedEmployee.value = employee;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  void addEmployee(String name, String salary, String age) async {
    try {
      await _employeeService.createEmployee(name, salary, age);
      fetchEmployees();
    } catch (e) {
      print(e.toString());
    }
  }

  void updateEmployee(int id, String name, String salary, String age) async {
    try {
      await _employeeService.updateEmployee(id, name, salary, age);
      fetchEmployees();
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteEmployee(int id) async {
    try {
      isLoading(true);
      errorMessage.value = '';
      await EmployeeService.deleteEmployee(id);
      employees.removeWhere((employee) => employee.id == id);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  void retryFetch() {
    fetchEmployees();
  }
}
