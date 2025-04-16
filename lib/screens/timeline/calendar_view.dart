import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:alhikma_cms/models/task.dart';
import 'package:alhikma_cms/config/theme.dart';
import 'package:alhikma_cms/utils/responsive_helper.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  _CalendarViewState createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  final Map<DateTime, List<Task>> _events = {
    DateTime.utc(2025, 3, 2): [
      Task(
        id: '1',
        name: 'Foundation',
        category: 'Foundation',
        startDate: DateTime(2025, 3, 2),
        endDate: DateTime(2025, 3, 2),
        status: 'In Progress',
        assignedTo: 'JD',
        categoryColor: Colors.green,
      ),
    ],
    DateTime.utc(2025, 3, 5): [
      Task(
        id: '2',
        name: 'Foundation',
        category: 'Foundation',
        startDate: DateTime(2025, 3, 5),
        endDate: DateTime(2025, 3, 5),
        status: 'In Progress',
        assignedTo: 'JD',
        categoryColor: Colors.green,
      ),
    ],
    DateTime.utc(2025, 3, 9): [
      Task(
        id: '3',
        name: 'Foundation',
        category: 'Foundation',
        startDate: DateTime(2025, 3, 9),
        endDate: DateTime(2025, 3, 9),
        status: 'In Progress',
        assignedTo: 'JD',
        categoryColor: Colors.green,
      ),
    ],
    DateTime.utc(2025, 3, 14): [
      Task(
        id: '4',
        name: 'Foundation',
        category: 'Foundation',
        startDate: DateTime(2025, 3, 14),
        endDate: DateTime(2025, 3, 14),
        status: 'In Progress',
        assignedTo: 'JD',
        categoryColor: Colors.green,
      ),
      Task(
        id: '5',
        name: 'Site Inspection',
        category: 'Site Prep',
        startDate: DateTime(2025, 3, 14),
        endDate: DateTime(2025, 3, 14),
        status: 'In Progress',
        assignedTo: 'MR',
        categoryColor: Colors.blue,
      ),
    ],
    DateTime.utc(2025, 3, 19): [
      Task(
        id: '6',
        name: 'Column Installation',
        category: 'Steel Frame',
        startDate: DateTime(2025, 3, 19),
        endDate: DateTime(2025, 3, 21),
        status: 'Scheduled',
        assignedTo: 'KL',
        categoryColor: Colors.orange,
      ),
    ],
    DateTime.utc(2025, 3, 20): [
      Task(
        id: '7',
        name: 'Column Installation',
        category: 'Steel Frame',
        startDate: DateTime(2025, 3, 20),
        endDate: DateTime(2025, 3, 21),
        status: 'Scheduled',
        assignedTo: 'KL',
        categoryColor: Colors.orange,
      ),
    ],
    DateTime.utc(2025, 3, 21): [
      Task(
        id: '8',
        name: 'Column Installation',
        category: 'Steel Frame',
        startDate: DateTime(2025, 3, 21),
        endDate: DateTime(2025, 3, 21),
        status: 'Scheduled',
        assignedTo: 'KL',
        categoryColor: Colors.orange,
      ),
    ],
    DateTime.utc(2025, 3, 22): [
      Task(
        id: '9',
        name: 'Design Review',
        category: 'Milestone',
        startDate: DateTime(2025, 3, 22),
        endDate: DateTime(2025, 3, 22),
        status: 'Scheduled',
        assignedTo: 'All',
        categoryColor: Colors.amber,
        isMilestone: true,
      ),
    ],
    DateTime.utc(2025, 3, 28): [
      Task(
        id: '10',
        name: 'Waterproofing',
        category: 'Foundation',
        startDate: DateTime(2025, 3, 28),
        endDate: DateTime(2025, 3, 30),
        status: 'Scheduled',
        assignedTo: 'JD',
        categoryColor: Colors.green,
      ),
    ],
    DateTime.utc(2025, 3, 29): [
      Task(
        id: '11',
        name: 'Waterproofing',
        category: 'Foundation',
        startDate: DateTime(2025, 3, 29),
        endDate: DateTime(2025, 3, 30),
        status: 'Scheduled',
        assignedTo: 'JD',
        categoryColor: Colors.green,
      ),
    ],
    DateTime.utc(2025, 3, 30): [
      Task(
        id: '12',
        name: 'Waterproofing',
        category: 'Foundation',
        startDate: DateTime(2025, 3, 30),
        endDate: DateTime(2025, 3, 30),
        status: 'Scheduled',
        assignedTo: 'JD',
        categoryColor: Colors.green,
      ),
    ],
  };

  List<Task> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Container(
      margin: EdgeInsets.all(isMobile ? 8.0 : 16.0),
      decoration: BoxDecoration(
        color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2025, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              weekendTextStyle: TextStyle(
                color: isLightTheme ? Colors.black54 : Colors.white70,
              ),
              holidayTextStyle: TextStyle(
                color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
              ),
              todayDecoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                fontWeight: FontWeight.bold,
              ),
              selectedDecoration: BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              markerDecoration: BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
              markerSize: 7.0,
              markersMaxCount: 3,
              defaultTextStyle: TextStyle(
                color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
              ),
            ),
            headerStyle: HeaderStyle(
              titleTextStyle: TextStyle(
                color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              formatButtonVisible: false,
              titleCentered: true,
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
              ),
            ),
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(
                color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
              ),
              weekendStyle: TextStyle(
                color: isLightTheme ? Colors.black54 : Colors.white70,
              ),
            ),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
          ),
          Divider(
            color: isLightTheme ? Colors.grey[300] : const Color(0xFF2A2A2A),
            thickness: 1,
          ),
          Expanded(
            child: _getEventsForDay(_selectedDay ?? _focusedDay).isEmpty
                ? Center(
                    child: Text(
                      'No events for selected day',
                      style: TextStyle(
                        color: isLightTheme ? Colors.black54 : Colors.white54,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(isMobile ? 8.0 : 16.0),
                    itemCount: _getEventsForDay(_selectedDay ?? _focusedDay).length,
                    itemBuilder: (context, index) {
                      final task = _getEventsForDay(_selectedDay ?? _focusedDay)[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        color: isLightTheme ? Colors.white : const Color(0xFF2A2A2A),
                        child: ListTile(
                          leading: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: task.categoryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          title: Text(
                            task.name,
                            style: TextStyle(
                              color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            task.category,
                            style: TextStyle(
                              color: isLightTheme ? Colors.black54 : Colors.white54,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: isLightTheme ? Colors.grey[200] : Colors.grey[800],
                                child: Text(
                                  task.assignedTo,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: Icon(
                                  Icons.more_vert,
                                  color: isLightTheme ? Colors.black54 : Colors.white54,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}