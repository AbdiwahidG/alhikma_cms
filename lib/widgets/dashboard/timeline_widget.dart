import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:alhikma_cms/utils/responsive_helper.dart';

class TimelineWidget extends StatefulWidget {
  const TimelineWidget({super.key});

  @override
  State<TimelineWidget> createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
  }

  final Map<DateTime, List<String>> _events = {
    DateTime.utc(2025, 4, 13): ['Project Kick-off Meeting'],
    DateTime.utc(2025, 4, 20): ['Initial Design Review'],
    DateTime.utc(2025, 5, 5): ['First Prototype Release'],
    DateTime.utc(2025, 5, 15): ['User Testing Phase 1'],
    DateTime.utc(2025, 5, 25): ['Development Sprint 1 Review'],
  };

  List<String> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    //final isTablet = ResponsiveHelper.isTablet(context);
    
    // Adjust format based on screen size
    if (isMobile && _calendarFormat != CalendarFormat.week) {
      _calendarFormat = CalendarFormat.week;
    }
    
    return Card(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with title and actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Timeline',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                // Format toggle
                if (!isMobile) // Hide on mobile to save space
                  SegmentedButton<CalendarFormat>(
                    segments: const [
                      ButtonSegment(
                        value: CalendarFormat.week,
                        label: Text('Week'),
                        icon: Icon(Icons.view_week),
                      ),
                      ButtonSegment(
                        value: CalendarFormat.month,
                        label: Text('Month'),
                        icon: Icon(Icons.calendar_month),
                      ),
                    ],
                    selected: <CalendarFormat>{_calendarFormat},
                    onSelectionChanged: (Set<CalendarFormat> selection) {
                      setState(() {
                        _calendarFormat = selection.first;
                      });
                    },
                  ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Calendar
            SingleChildScrollView(
              child: TableCalendar(
                firstDay: DateTime.utc(2025, 1, 1),
                lastDay: DateTime.utc(2025, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: CalendarStyle(
                  outsideDaysVisible: false,
                  weekendTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    fontSize: isMobile ? 12 : 14,
                    //color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              
                  ),
                  holidayTextStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  // Adjust font sizes
                  defaultTextStyle: TextStyle(
                    fontSize: isMobile ? 12 : 14,
                  ),
                  
                  selectedTextStyle: TextStyle(
                    fontSize: isMobile ? 12 : 14,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  todayTextStyle: TextStyle(
                    fontSize: isMobile ? 12 : 14,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                headerStyle: HeaderStyle(
                  titleTextStyle: TextStyle(
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                  formatButtonVisible: false,
                  titleCentered: true,
                  headerPadding: EdgeInsets.symmetric(
                    vertical: isMobile ? 8.0 : 16.0,
                  ),
                  leftChevronIcon: Icon(
                    Icons.chevron_left,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: isMobile ? 18 : 24,
                  ),
                  rightChevronIcon: Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.onSurface,
                    size: isMobile ? 18 : 24,
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
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                // Adjust calendar size for mobile
                daysOfWeekHeight: isMobile ? 16 : 24,
                rowHeight: isMobile ? 42 : 54,
              ),
            ),
            
            const Divider(height: 24),
            
            // Events section header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Events for ${_selectedDay?.day ?? _focusedDay.day} ${_getMonthName(_selectedDay?.month ?? _focusedDay.month)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 14 : 16,
                  ),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.add),
                  label: Text(isMobile ? 'Add' : 'Add Event'),
                  onPressed: () {},
                ),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // Events list
            Expanded(
              child: _getEventsForDay(_selectedDay ?? _focusedDay).isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_busy,
                          size: 48,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No events scheduled',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: _getEventsForDay(_selectedDay ?? _focusedDay).length,
                    itemBuilder: (context, index) {
                      final events = _getEventsForDay(_selectedDay ?? _focusedDay);
                      return _buildEventItem(context, events[index], isMobile);
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildEventItem(BuildContext context, String event, bool isMobile) {
    return Card(
      margin: EdgeInsets.only(bottom: isMobile ? 8 : 12),
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: isMobile ? 12 : 16,
          vertical: isMobile ? 4 : 8,
        ),
        leading: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
        ),
        title: Text(
          event,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 14 : 16,
          ),
        ),
        subtitle: Text(
          'Scheduled for ${_formatTime(_selectedDay ?? _focusedDay)}',
          style: TextStyle(
            fontSize: isMobile ? 12 : 14,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                size: isMobile ? 18 : 20,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                size: isMobile ? 18 : 20,
                color: Colors.red,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
  
  String _getMonthName(int month) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }
  
  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:00';
  }
}