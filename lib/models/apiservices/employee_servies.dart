import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:planetmediamt/models/employee_model.dart';
import 'package:http/http.dart' as http;
import 'package:planetmediamt/utils/api_endpoints.dart';
import 'package:planetmediamt/utils/constants.dart';
class EmployeeService {
  
  
  Future<List<Employee>> fetchEmployees() async {
    await Future.delayed(const Duration(seconds: 2));
    final response = await http.get(Uri.parse(ApiEndpoints.employees));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['data'];
      return body.map((dynamic item) => Employee.fromJson(item)).toList();
    } else if(response.statusCode==429){
      Get.snackbar('Rate Limit Exceeded', 'Please try again after 60 seconds',
            backgroundColor: textColor, colorText: Colors.red);
      throw RateLimitException();
    }
    else {
      throw Exception('Failed to load employees');
    }
  }

 Future<Employee> fetchEmployeeById(int id) async {
    final response = await http.get(Uri.parse('${ApiEndpoints.employee}/$id'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        return Employee.fromJson(data['data']);
      } else if(response.statusCode==429){
      Get.snackbar('Rate Limit Exceeded', 'Please try again after 60 seconds',
            backgroundColor: textColor, colorText: Colors.red);
      throw RateLimitException();
    }
      
      else {
        throw Exception('Failed to load employee');
      }
    } else {
      throw Exception('Failed to load employee');
    }
  }
  
  Future<void> createEmployee(String name, String salary, String age) async {
    try {
      final response = await http.post(
      Uri.parse(ApiEndpoints.createEmployee),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "salary": salary,
        "age": age,
      }),
    );
      if (response.statusCode == 200|| response.statusCode == 200) {
        print('Employee created successfully');
      }else if(response.statusCode==429){
      Get.snackbar('Rate Limit Exceeded', 'Please try again after 60 seconds',
            backgroundColor: textColor, colorText: Colors.red);
      throw RateLimitException();
    } 
      
      else {
        print('Failed to create employee');
        throw Exception('Failed to create employee: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while creating employee: $e');
      throw Exception('Error occurred while creating employee');
    }
    

   
  }

  Future<void> updateEmployee(int id, String name, String salary, String age) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiEndpoints.updateEmployee}/$id'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'name': name,
          'salary': salary,
          'age': age,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success','Edited Successfully',backgroundColor: Colors.white);
      }else if(response.statusCode==429){
      Get.snackbar('Rate Limit Exceeded', 'Please try again after 60 seconds',
            backgroundColor: textColor, colorText: Colors.red);
      throw RateLimitException();
    } 
      
      else {
        throw Exception('Failed to update employee');
      }
    } catch (e) {
      throw Exception('Error occurred while updating employee');
    }
  }



  static Future<bool> deleteEmployee(int id) async {
    final url = Uri.parse('${ApiEndpoints.deleteEmployee}/$id');
    
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Deleted successfully',backgroundColor: textColor);
        return true;
      }else if(response.statusCode==429){
      Get.snackbar('Rate Limit Exceeded', 'Please try again after 60 seconds',
            backgroundColor: textColor, colorText: Colors.red);
      throw RateLimitException();
    }
      
       else {
        print('Failed to delete employee: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error deleting employee: $e');
      return false;
    }
  }

  }
  class RateLimitException implements Exception {}