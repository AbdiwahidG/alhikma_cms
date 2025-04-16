import 'package:alhikma_cms/config/theme.dart';
import 'package:flutter/material.dart';

import 'package:alhikma_cms/utils/responsive_helper.dart';
// import 'package:intl/intl.dart';
// import 'package:alhikma_cms/models/task.dart';

class GanttView extends StatefulWidget {
  const GanttView({super.key});

  @override
  _GanttViewState createState() => _GanttViewState();
}

class _GanttViewState extends State<GanttView> {
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Q1 2025 and zoom controls
          Padding(
            padding: EdgeInsets.all(isMobile ? 8.0 : 16.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isLightTheme ? Colors.grey[200] : const Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_view_month,
                        color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Q1 2025',
                        style: TextStyle(
                          color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Zoom:',
                  style: TextStyle(
                    color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                  ),
                ),
                const SizedBox(width: 8),
                _buildZoomButton('Day'),
                _buildZoomButton('Week'),
                _buildZoomButton('Month', isSelected: true),
                _buildZoomButton('Year'),
              ],
            ),
          ),
          
          // Gantt chart container
          Expanded(
            child: SingleChildScrollView(
              controller: _horizontalScrollController,
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: isMobile ? 600 : 800,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Month labels
                    Padding(
                      padding: EdgeInsets.only(left: isMobile ? 80 : 120, right: 16),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                'January',
                                style: TextStyle(
                                  color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                'February',
                                style: TextStyle(
                                  color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Text(
                                'March',
                                style: TextStyle(
                                  color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Today indicator
                    Padding(
                      padding: const EdgeInsets.only(right: 32.0, top: 8, bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Today',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Gantt chart content
                    Expanded(
                      child: SingleChildScrollView(
                        controller: _verticalScrollController,
                        child: SizedBox(
                          width: isMobile ? 600 : 800,
                          child: Column(
                            children: [
                              _buildGanttSection('Site Preparation', [
                                _buildGanttTask('Site Clearing', 
                                  DateTime(2025, 1, 5), 
                                  DateTime(2025, 1, 15), 
                                  AppTheme.primaryColor.withOpacity(0.8), 
                                  0.1),
                                _buildGanttTask('Excavation', 
                                  DateTime(2025, 1, 20), 
                                  DateTime(2025, 2, 5), 
                                  AppTheme.primaryColor.withOpacity(0.8), 
                                  0.1),
                              ]),
                              
                              _buildGanttSection('Foundation Work', [
                                _buildGanttTask('Footings', 
                                  DateTime(2025, 2, 10), 
                                  DateTime(2025, 2, 20), 
                                  AppTheme.successColor, 
                                  0.3),
                                _buildGanttTask('Foundation Walls', 
                                  DateTime(2025, 2, 21), 
                                  DateTime(2025, 3, 7), 
                                  AppTheme.successColor, 
                                  0.5),
                                _buildGanttTask('Waterproofing', 
                                  DateTime(2025, 3, 8), 
                                  DateTime(2025, 3, 14), 
                                  AppTheme.successColor, 
                                  0.7),
                                _buildGanttMilestone('Foundation Complete', DateTime(2025, 3, 15)),
                              ]),
                              
                              _buildGanttSection('Steel Framework', [
                                _buildGanttTask('Column Installation', 
                                  DateTime(2025, 3, 17), 
                                  DateTime(2025, 3, 21), 
                                  AppTheme.warningColor, 
                                  0.0),
                                _buildGanttTask('Beams', 
                                  DateTime(2025, 3, 24), 
                                  DateTime(2025, 3, 31), 
                                  AppTheme.warningColor, 
                                  0.0),
                              ]),
                              
                              _buildGanttSection('Electrical Work', [
                                _buildGanttTask('Electrical Rough-In', 
                                  DateTime(2025, 4, 3), 
                                  DateTime(2025, 4, 14), 
                                  AppTheme.infoColor, 
                                  0.0),
                              ]),
                              
                              _buildGanttSection('Masonry & Finish', [
                                _buildGanttTask('Start', 
                                  DateTime(2025, 4, 15), 
                                  DateTime(2025, 4, 15), 
                                  AppTheme.errorColor, 
                                  0.0),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Legend
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 8.0 : 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildLegendItem('Site Prep', AppTheme.primaryColor.withOpacity(0.8)),
                  _buildLegendItem('Foundation', AppTheme.successColor),
                  _buildLegendItem('Steel Framework', AppTheme.warningColor),
                  _buildLegendItem('Electrical', AppTheme.infoColor),
                  _buildLegendItem('Masonry & Finish', AppTheme.errorColor),
                  _buildLegendItem('Milestone', AppTheme.primaryColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildZoomButton(String label, {bool isSelected = false}) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: () {
        setState(() {
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : (isLightTheme ? Colors.grey[200] : const Color(0xFF2A2A2A)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : (isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildGanttSection(String title, List<Widget> tasks) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(
              color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        ...tasks,
        Divider(
          color: isLightTheme ? Colors.grey[300] : const Color(0xFF2A2A2A),
          thickness: 1,
        ),
      ],
    );
  }

  Widget _buildGanttTask(String name, DateTime start, DateTime end, Color color, double progress) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    
    // Calculate task position
   // final double totalWidth = isMobile ? 600 - 80 : 800 - 120;
    final double labelWidth = isMobile ? 80 : 120;
    
    // Calculate position (days since Jan 1, 2025 / 90 days in quarter)
    final int startDays = start.difference(DateTime(2025, 1, 1)).inDays;
    final int endDays = end.difference(DateTime(2025, 1, 1)).inDays;
    final double startPercent = startDays / 90;
    final double endPercent = endDays / 90;
    
    return SizedBox(
      height: isMobile ? 32 : 40,
      child: Row(
        children: [
          // Task label
          SizedBox(
            width: labelWidth,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(
                  color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                  fontSize: isMobile ? 12 : 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Chart area
          Expanded(
            child: CustomPaint(
              painter: GanttTaskPainter(
                context: context,
                isLightTheme: isLightTheme,
                startPercent: startPercent,
                endPercent: endPercent,
                progress: progress,
                color: color,
                isMobile: isMobile,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGanttMilestone(String name, DateTime date) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    
    // Calculate milestone position
    final double labelWidth = isMobile ? 80 : 120;
    
    // Calculate position (days since Jan 1, 2025 / 90 days in quarter)
    final int days = date.difference(DateTime(2025, 1, 1)).inDays;
    final double percent = days / 90;
    
    return SizedBox(
      height: isMobile ? 32 : 40,
      child: Row(
        children: [
          // Milestone label
          SizedBox(
            width: labelWidth,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(
                  color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                  fontSize: isMobile ? 12 : 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Chart area
          Expanded(
            child: CustomPaint(
              painter: GanttMilestonePainter(
                context: context,
                isLightTheme: isLightTheme,
                percent: percent,
                color: AppTheme.primaryColor,
                isMobile: isMobile,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class GanttTaskPainter extends CustomPainter {
  final BuildContext context;
  final bool isLightTheme;
  final double startPercent;
  final double endPercent;
  final double progress;
  final Color color;
  final bool isMobile;

  GanttTaskPainter({
    required this.context,
    required this.isLightTheme,
    required this.startPercent,
    required this.endPercent,
    required this.progress,
    required this.color,
    required this.isMobile,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw grid lines
    final gridPaint = Paint()
      ..color = isLightTheme ? Colors.grey[300]! : const Color(0xFF2A2A2A)
      ..strokeWidth = 1;

    // Draw vertical grid lines at 1/3 and 2/3 of the width
    canvas.drawLine(
      Offset(size.width / 3, 0),
      Offset(size.width / 3, size.height),
      gridPaint,
    );

    canvas.drawLine(
      Offset(2 * size.width / 3, 0),
      Offset(2 * size.width / 3, size.height),
      gridPaint,
    );

    // Draw task bar
    if (startPercent <= 1.0 && endPercent >= 0.0) {
      // Ensure task is within the visible range (clamp)
      final actualStartPercent = startPercent.clamp(0.0, 1.0);
      final actualEndPercent = endPercent.clamp(0.0, 1.0);
      
      final startX = actualStartPercent * size.width;
      final endX = actualEndPercent * size.width;
      
      if (startX < endX) {
        final taskWidth = endX - startX;
        
        // Draw task background
        final taskBackgroundRect = RRect.fromRectAndRadius(
          Rect.fromLTWH(
            startX,
            size.height / 2 - (isMobile ? 6 : 8),
            taskWidth,
            isMobile ? 12 : 16,
          ),
          const Radius.circular(4),
        );
        
        final taskBackgroundPaint = Paint()
          ..color = color.withOpacity(0.2)
          ..style = PaintingStyle.fill;
        
        canvas.drawRRect(taskBackgroundRect, taskBackgroundPaint);
        
        // Draw border
        final borderPaint = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;
        
        canvas.drawRRect(taskBackgroundRect, borderPaint);
        
        // Draw progress
        if (progress > 0) {
          final progressWidth = taskWidth * progress;
          
          if (progressWidth > 0) {
            final progressRect = RRect.fromRectAndCorners(
              Rect.fromLTWH(
                startX,
                size.height / 2 - (isMobile ? 6 : 8),
                progressWidth,
                isMobile ? 12 : 16,
              ),
              topLeft: const Radius.circular(4),
              bottomLeft: const Radius.circular(4),
              topRight: progressWidth < taskWidth ? Radius.zero : const Radius.circular(4),
              bottomRight: progressWidth < taskWidth ? Radius.zero : const Radius.circular(4),
            );
            
            final progressPaint = Paint()
              ..color = color
              ..style = PaintingStyle.fill;
            
            canvas.drawRRect(progressRect, progressPaint);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class GanttMilestonePainter extends CustomPainter {
  final BuildContext context;
  final bool isLightTheme;
  final double percent;
  final Color color;
  final bool isMobile;

  GanttMilestonePainter({
    required this.context,
    required this.isLightTheme,
    required this.percent,
    required this.color,
    required this.isMobile,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw grid lines
    final gridPaint = Paint()
      ..color = isLightTheme ? Colors.grey[300]! : const Color(0xFF2A2A2A)
      ..strokeWidth = 1;

    // Draw vertical grid lines at 1/3 and 2/3 of the width
    canvas.drawLine(
      Offset(size.width / 3, 0),
      Offset(size.width / 3, size.height),
      gridPaint,
    );

    canvas.drawLine(
      Offset(2 * size.width / 3, 0),
      Offset(2 * size.width / 3, size.height),
      gridPaint,
    );

    // Draw milestone diamond
    if (percent >= 0.0 && percent <= 1.0) {
      final centerX = percent * size.width;
      final centerY = size.height / 2;
      final milestonePaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;
      
      final milestoneBorderPaint = Paint()
        ..color = isLightTheme ? Colors.white : const Color(0xFF2A2A2A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      
      // Create diamond shape
      final diamondSize = isMobile ? 12.0 : 16.0;
      final path = Path();
      path.moveTo(centerX, centerY - diamondSize / 2); // Top
      path.lineTo(centerX + diamondSize / 2, centerY); // Right
      path.lineTo(centerX, centerY + diamondSize / 2); // Bottom
      path.lineTo(centerX - diamondSize / 2, centerY); // Left
      path.close();
      
      canvas.drawPath(path, milestonePaint);
      canvas.drawPath(path, milestoneBorderPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}






 