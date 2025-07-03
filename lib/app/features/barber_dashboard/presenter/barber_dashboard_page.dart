import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/custom_bottom_nav_item.dart';
import '../utils/next_client_card.dart';

class BarberDashboardPage extends StatefulWidget {
  const BarberDashboardPage({super.key});

  @override
  State<BarberDashboardPage> createState() => _BarberDashboardPageState();
}

class _BarberDashboardPageState extends State<BarberDashboardPage> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80), // espaço pro bottom nav
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),
                const NextClientCard(
                  clientName: 'John D.',
                  dateText: 'Fri, Jun 20',
                  timeText: '1 PM',
                ),
                const SizedBox(height: 24),
                _buildCalendarLabel(),
                const SizedBox(height: 8),
                _buildCalendar(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildTitle() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: Text(
          "Dashboard",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildCalendarLabel() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Calendar', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Month'),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TableCalendar(
              headerStyle: const HeaderStyle(
                  formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              onDaySelected: _onDaySelected,
              calendarFormat: CalendarFormat.month,
              calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.black38,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomBottomNavItem(
            icon: Icons.dashboard,
            label: 'Dashboard',
            isSelected: Modular.to.path.endsWith('/BarberDashboard'),
            onTap: () => Modular.to.navigate('/BarberDashboard'),
          ),
          CustomBottomNavItem(
            icon: Icons.schedule,
            label: 'Scheduling',
            isSelected: Modular.to.path.endsWith('/BarberDashboard/scheduling'),
            onTap: () => Modular.to.navigate('/BarberDashboard/scheduling'),
          ),
          CustomBottomNavItem(
            icon: Icons.settings,
            label: 'Settings',
            isSelected: Modular.to.path.endsWith('/BarberDashboard/settings'),
            onTap: () => Modular.to.navigate('/BarberDashboard/settings'),
          ),
        ],
      ),
    );
  }
}
