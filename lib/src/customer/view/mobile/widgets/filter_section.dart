import 'package:flutter/material.dart';

enum CustomerFilter { all, active, inactive }

class FilterSection extends StatelessWidget {
  final CustomerFilter selectedFilter;
  final Function(CustomerFilter) onFilterSelected;
  final int total;
  final int active;
  final int inactive;

  const FilterSection({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
    required this.total,
    required this.active,
    required this.inactive,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Filter by:',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildChip('All', CustomerFilter.all, total, Colors.blue),
                const SizedBox(width: 8),
                _buildChip(
                  'Active',
                  CustomerFilter.active,
                  active,
                  Colors.green,
                ),
                const SizedBox(width: 8),
                _buildChip(
                  'Inactive',
                  CustomerFilter.inactive,
                  inactive,
                  Colors.orange,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChip(
    String label,
    CustomerFilter filter,
    int count,
    Color color,
  ) {
    final isSelected = selectedFilter == filter;
    return ChoiceChip(
      label: Text('$label ($count)'),
      selected: isSelected,
      selectedColor: color.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected ? color : Colors.grey[600],
        fontWeight: FontWeight.w500,
      ),
      onSelected: (_) => onFilterSelected(filter),
    );
  }
}
