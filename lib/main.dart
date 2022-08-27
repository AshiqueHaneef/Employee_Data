import 'package:employee/data/repositories/employees_api_provider.dart';
import 'package:employee/data/repositories/employees_local_provider.dart';
import 'package:employee/data/repositories/employees_repository.dart';
import 'package:employee/providers/employees_provider.dart';
import 'package:employee/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final employeeSharedProvider =
      EmployeesLocalProvider(sharedPreferences: sharedPreferences);
  final caches = [
    employeeSharedProvider,
  ];

  final sources = [
    employeeSharedProvider,
    EmployeesApiProvider(),
  ];
  runApp(
    ChangeNotifierProvider(
      create: (context) => EmployeesProvider(
        employeesRepository: EmployeesRepository(
          caches: caches,
          sources: sources,
        ),
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Data',
      home: HomeScreen(),
    );
  }
}
