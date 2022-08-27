import 'package:employee/screens/employee_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/employee.dart';
import '../providers/employees_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<EmployeesProvider>().fetchEmployees();
    });
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<EmployeesProvider>();
    return Scaffold(
      appBar: AppBar(
          title: const Text("Employe Data"), actions: [Icon(Icons.search)]),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: prov.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: prov.employees
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: EmployeeCard(
                            employee: e,
                          ),
                        ))
                    .toList()),
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  const EmployeeCard({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: Colors.black12,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EmployeeDetails(
                      employee: employee,
                    )));
      },
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          employee.profileImage ?? "",
        ),
        backgroundColor: Colors.blue,
      ),
      title: Text(employee.name),
      subtitle: Text("Company : ${employee.company?.name ?? ""}"),
    );
  }
}
