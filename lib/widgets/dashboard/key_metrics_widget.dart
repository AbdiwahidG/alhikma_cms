import 'package:flutter/material.dart';
import 'package:alhikma_cms/utils/responsive_helper.dart';

class KeyMetricsWidget extends StatelessWidget {
  const KeyMetricsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Use the ResponsiveHelper to determine layout properties
    int crossAxisCount;
    double childAspectRatio;
    double iconSize;
    double titleFontSize;
    double valueFontSize;
    double trendFontSize;
    EdgeInsets cardPadding;
    
    if (ResponsiveHelper.isMobile(context)) {
      crossAxisCount = 1;
      childAspectRatio = 2.4; // More horizontal on small screens
      iconSize = 20;
      titleFontSize = 12;
      valueFontSize = 20;
      trendFontSize = 10;
      cardPadding = const EdgeInsets.all(12.0);
    } else if (ResponsiveHelper.isTablet(context)) {
      crossAxisCount = 2;
      childAspectRatio = 2.4;
      iconSize = 22;
      titleFontSize = 13;
      valueFontSize = 22;
      trendFontSize = 11;
      cardPadding = const EdgeInsets.all(14.0);
    } else {
      crossAxisCount = 4;
      childAspectRatio = 2.0;
      iconSize = 24;
      titleFontSize = 14;
      valueFontSize = 24;
      trendFontSize = 12;
      cardPadding = const EdgeInsets.all(16.0);
    }

    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: ResponsiveHelper.isMobile(context) ? 12 : 16,
      crossAxisSpacing: ResponsiveHelper.isMobile(context) ? 12 : 16,
      childAspectRatio: childAspectRatio,
      children: [
        _buildMetricCard(
          context,
          title: 'Project Progress',
          value: '65%',
          icon: Icons.trending_up,
          color: Colors.blue,
          trend: '+5%',
          isPositive: true,
          iconSize: iconSize,
          titleFontSize: titleFontSize,
          valueFontSize: valueFontSize,
          trendFontSize: trendFontSize,
          cardPadding: cardPadding,
        ),
        _buildMetricCard(
          context,
          title: 'Budget Spent',
          value: '\$2.5M',
          icon: Icons.attach_money,
          color: Colors.green,
          trend: '-2%',
          isPositive: true,
          iconSize: iconSize,
          titleFontSize: titleFontSize,
          valueFontSize: valueFontSize,
          trendFontSize: trendFontSize,
          cardPadding: cardPadding,
        ),
        _buildMetricCard(
          context,
          title: 'Labour Hours',
          value: '12,500',
          icon: Icons.people,
          color: Colors.orange,
          trend: '+8%',
          isPositive: false,
          iconSize: iconSize,
          titleFontSize: titleFontSize,
          valueFontSize: valueFontSize,
          trendFontSize: trendFontSize,
          cardPadding: cardPadding,
        ),
        _buildMetricCard(
          context,
          title: 'Materials Used',
          value: '850 tons',
          icon: Icons.inventory,
          color: Colors.purple,
          trend: '+3%',
          isPositive: true,
          iconSize: iconSize,
          titleFontSize: titleFontSize,
          valueFontSize: valueFontSize,
          trendFontSize: trendFontSize,
          cardPadding: cardPadding,
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String trend,
    required bool isPositive,
    required double iconSize,
    required double titleFontSize,
    required double valueFontSize,
    required double trendFontSize,
    required EdgeInsets cardPadding,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: cardPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // More consistent spacing
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: iconSize,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: titleFontSize,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: valueFontSize,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Row(
              children: [
                Icon(
                  isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                  size: trendFontSize + 4, // Slightly larger than text
                  color: isPositive ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 4),
                Text(
                  trend,
                  style: TextStyle(
                    fontSize: trendFontSize,
                    color: isPositive ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    ' vs last month',
                    style: TextStyle(
                      fontSize: trendFontSize,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}