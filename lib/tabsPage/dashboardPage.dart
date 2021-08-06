import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic currentTime = DateFormat.jm().format(DateTime.now());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          currentTime,
          textAlign: TextAlign.center,
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
      ),
    );
  }
}
