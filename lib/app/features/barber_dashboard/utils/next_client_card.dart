import 'package:flutter/material.dart';

class NextClientCard extends StatelessWidget {
  final String clientName;
  final String dateText;
  final String timeText;

  const NextClientCard({
    required this.clientName,
    required this.dateText,
    required this.timeText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.person, size: 18),
                const SizedBox(width: 8),
                Text(clientName),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18),
                const SizedBox(width: 8),
                Text(dateText),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time, size: 18),
                const SizedBox(width: 8),
                Text(timeText),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(onPressed: () {}, child: const Text('Reschedule')),
                TextButton(onPressed: () {}, child: const Text('Add Service')),
                TextButton(onPressed: () {}, child: const Text('Add Note')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
