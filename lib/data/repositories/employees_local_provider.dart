import 'package:employee/data/models/employee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:employee/data/repositories/employees_repository.dart';

class EmployeesLocalProvider implements EmployeesSource, EmployeesCache {
  final SharedPreferences sharedPreferences;
  final String key = 'employees';

  EmployeesLocalProvider({required this.sharedPreferences});

  @override
  Future<void> clear() async {
    await sharedPreferences.clear();
  }

  @override
  Future<List<Employee>> fetchEmployees() async {
    print('from shared');
    final json = sharedPreferences.getStringList(key) ?? [];
    return json.map((e) => Employee.fromJson(e)).toList();
  }

  @override
  Future<void> saveEmployees(List<Employee> employees) async {
    print('setting shared');
    final employeeJsonList = employees.map<String>((e) => e.toJson()).toList();
    await sharedPreferences.setStringList(key, employeeJsonList);
  }

  @override
  Future<List<Employee>> searchEmployees(String query) async {
    final allData = await fetchEmployees();
    query = query.toLowerCase();
    return allData
        .where((element) =>
            element.email.toLowerCase().contains(query) ||
            element.name.toLowerCase().contains(query))
        .toList();
  }
}
