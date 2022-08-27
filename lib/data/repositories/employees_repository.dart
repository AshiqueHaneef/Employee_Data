import 'package:employee/data/models/employee.dart';

class EmployeesRepository {
  List<EmployeesSource> sources;
  List<EmployeesCache> caches;

  EmployeesRepository({
    required this.caches,
    required this.sources,
  });

  Future<List<Employee>> fetchEmployees() async {
    List<Employee>? employees;
    EmployeesSource? source;

    for (source in sources) {
      employees = await source.fetchEmployees();
      if (employees.isNotEmpty) {
        break;
      }
    }

    for (EmployeesCache cache in caches) {
      if ((cache as EmployeesSource) != source) {
        cache.saveEmployees(employees ?? []);
      }
    }

    return employees ?? [];
  }

  // Future<List<Employee>> searchEmployees(String query) async {
  //   final dataProvider = sources.whereType<EmployeesCache>().first;
  //   return (dataProvider as EmployeesSource).searchEmployees(query);
  // }
}

abstract class EmployeesSource {
  Future<List<Employee>> fetchEmployees();
  // Future<List<Employee>> searchEmployees(String query);
}

abstract class EmployeesCache {
  Future<void> saveEmployees(List<Employee> employees);
  Future<void> clear();
}
