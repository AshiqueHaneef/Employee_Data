import 'dart:convert';
import 'package:employee/data/models/employee.dart';
import 'package:http/http.dart';
import 'employees_repository.dart';

class EmployeesApiProvider implements EmployeesSource {
  @override
  Future<List<Employee>> fetchEmployees() async {
    print('from api');
    final response =
        await get(Uri.parse('http://www.mocky.io/v2/5d565297300000680030a986'));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(body);
      return (body as List).map<Employee>((e) => Employee.fromMap(e)).toList();
    } else {
      throw Exception('Error while fetching data');
    }
  }
}
