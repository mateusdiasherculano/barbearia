import 'package:flutter/material.dart';

class BarberDashboardPage extends StatefulWidget {
  const BarberDashboardPage({Key? key}) : super(key: key);

  @override
  State<BarberDashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<BarberDashboardPage> {
  int _selectedIndex = 0;
  final DateTime _currentDate = DateTime.now();
  final DateTime _nextClientDate = DateTime(2024, 8, 11);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  "Dashboard",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // Next client card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.person, size: 18),
                        SizedBox(width: 8),
                        Text('John D.'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.calendar_today, size: 18),
                        SizedBox(width: 8),
                        Text('Mon, Aug 12'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.access_time, size: 18),
                        SizedBox(width: 8),
                        Text('1 PM'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                            onPressed: () {}, child: const Text('Reschedule')),
                        TextButton(
                            onPressed: () {}, child: const Text('Add Service')),
                        TextButton(
                            onPressed: () {}, child: const Text('Add Note')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Calendar label
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Calendar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Month'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Calendar grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      const Text(
                        'August',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: GridView.builder(
                          itemCount: 35,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            childAspectRatio: 1.2,
                          ),
                          itemBuilder: (context, index) {
                            int day = index + 1;
                            bool isCurrentDate = day == _currentDate.day &&
                                _currentDate.month == 8;
                            bool isNextClient = day == _nextClientDate.day;

                            return Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isCurrentDate
                                      ? Colors.black
                                      : Colors.transparent,
                                  border: isNextClient && !isCurrentDate
                                      ? Border.all(color: Colors.black)
                                      : null,
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  '$day',
                                  style: TextStyle(
                                    color: isCurrentDate
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: isCurrentDate || isNextClient
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.circle, size: 6),
                          SizedBox(width: 4),
                          Text("Current date"),
                          SizedBox(width: 12),
                          Icon(Icons.circle_outlined, size: 6),
                          SizedBox(width: 4),
                          Text("Next client"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
