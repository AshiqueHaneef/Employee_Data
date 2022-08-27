import 'package:employee/data/models/employee.dart';
import 'package:employee/data/repositories/employees_repository.dart';
import 'package:flutter/material.dart';

class EmployeesProvider extends ChangeNotifier {
  final EmployeesRepository employeesRepository;

  List<Employee> _employees = [];
  bool _isLoading = false;

  EmployeesProvider({required this.employeesRepository});

  List<Employee> get employees => _employees;
  bool get isLoading => _isLoading;

  void fetchEmployees() async {
    _isLoading = true;
    notifyListeners();

    _employees = await employeesRepository.fetchEmployees();

    _isLoading = false;
    notifyListeners();
  }

  // void searchEmployees(String query) async {
  //   _isLoading = true;
  //   notifyListeners();

  //   _employees = await employeesRepository.searchEmployees(query);

  //   _isLoading = false;
  //   notifyListeners();
  // }
}
