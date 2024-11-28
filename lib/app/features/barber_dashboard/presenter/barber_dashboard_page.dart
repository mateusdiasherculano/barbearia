import 'package:flutter/material.dart';

class BarberDashboardPage extends StatefulWidget {
  const BarberDashboardPage({Key? key}) : super(key: key);

  @override
  State<BarberDashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<BarberDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(
          'voce esta logado',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
