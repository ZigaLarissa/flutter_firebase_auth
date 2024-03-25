import 'package:flutter/material.dart';
// import 'package:flutter_firebase_auth/data/categories.dart';
// import 'package:flutter_firebase_auth/models/categories.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:horizontal_week_calendar/horizontal_week_calendar.dart';
import 'package:intl/intl.dart';

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          const SizedBox(height: 30),
          const Text(
            'Agenda',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          HorizontalWeekCalendar(
            weekStartFrom: WeekStartFrom.Monday,
            activeBackgroundColor: Colors.purple,
            activeTextColor: Colors.white,
            inactiveBackgroundColor: Colors.purple.withOpacity(.3),
            inactiveTextColor: Colors.white,
            disabledTextColor: Colors.grey,
            disabledBackgroundColor: Colors.grey.withOpacity(.3),
            activeNavigatorColor: Colors.purple,
            inactiveNavigatorColor: Colors.grey,
            monthColor: Colors.purple,
            onDateChange: (date) {
              setState(() {
                selectedDate = date;
              });
            },
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Selected Date",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  DateFormat('dd MMM yyyy').format(selectedDate),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
