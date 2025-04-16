import 'package:flutter/material.dart';

class MaterialDataTable extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final bool showCheckboxColumn;
  final int? totalItems;
  final int? currentPage;
  final int? itemsPerPage;
  final Function(int)? onPageChanged;
  final Function(int)? onRowsPerPageChanged;

  const MaterialDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.showCheckboxColumn = false,
    this.totalItems,
    this.currentPage,
    this.itemsPerPage,
    this.onPageChanged,
    this.onRowsPerPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              showCheckboxColumn: showCheckboxColumn,
              headingRowColor: MaterialStateProperty.all(
                isDarkMode ? Colors.grey[900] : Colors.grey[50],
              ),
              columns: columns,
              rows: rows,
            ),
          ),
        ),
        if (totalItems != null && itemsPerPage != null) ...[
          const SizedBox(height: 16),
          _buildPagination(context),
        ],
      ],
    );
  }

  Widget _buildPagination(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final totalPages = (totalItems! / itemsPerPage!).ceil();
    final start = ((currentPage! - 1) * itemsPerPage!) + 1;
    final end = currentPage! * itemsPerPage! > totalItems!
        ? totalItems!
        : currentPage! * itemsPerPage!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Showing $start to $end of $totalItems entries',
          style: TextStyle(
            color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: currentPage == 1
                  ? null
                  : () => onPageChanged?.call(currentPage! - 1),
              icon: const Icon(Icons.chevron_left),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '$currentPage of $totalPages',
                style: TextStyle(
                  color: isDarkMode ? Colors.grey[200] : Colors.grey[800],
                ),
              ),
            ),
            IconButton(
              onPressed: currentPage == totalPages
                  ? null
                  : () => onPageChanged?.call(currentPage! + 1),
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      ],
    );
  }
} 