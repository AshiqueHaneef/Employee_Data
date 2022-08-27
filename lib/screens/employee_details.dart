import 'package:employee/data/models/employee.dart';
import 'package:flutter/material.dart';

class EmployeeDetails extends StatefulWidget {
  final Employee employee;
  const EmployeeDetails({Key? key, required this.employee}) : super(key: key);

  @override
  State<EmployeeDetails> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Employee Details")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                widget.employee.profileImage ?? "",
              ),
              radius: 60,
            ),
            dataText(data: "Name", value: widget.employee.name),
            dataText(data: "User name", value: widget.employee.username),
            dataText(data: "Email", value: widget.employee.email),
            dataText(data: "Phone", value: widget.employee.phone),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Address:"),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Text(
                        "${widget.employee.address.street}\n${widget.employee.address.suite}\n${widget.employee.address.city}\n${widget.employee.address.zipcode}\n",
                        overflow: TextOverflow.fade,
                        style: const TextStyle(fontSize: 12))),
              ],
            ),
            dataText(data: "Website", value: widget.employee.website),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Company Details:"),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Text(
                        "${widget.employee.company?.name} \n${widget.employee.company?.bs}\n${widget.employee.company?.catchPhrase}",
                        overflow: TextOverflow.fade,
                        style: TextStyle(fontSize: 12))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget dataText({String? data, String? value}) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data ?? "",
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            value ?? "",
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
