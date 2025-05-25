// import 'package:flutter/material.dart';

// enum CustomerFilter { all, active, inactive }

// class FilterChipBuilder {
//   static Widget buildFilterChip(
//     String label,
//     CustomerFilter filter,
//     CustomerFilter selectedFilter,
//     int count,
//     Color color,
//     VoidCallback onTap,
//   ) {
//     final isSelected = selectedFilter == filter;

//     return GestureDetector(
//       onTap: onTap,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: isSelected ? color : color.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//             color: isSelected ? color : color.withOpacity(0.3),
//             width: 1.5,
//           ),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               label,
//               style: TextStyle(
//                 color: isSelected ? Colors.white : color,
//                 fontSize: 13,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(width: 6),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//               decoration: BoxDecoration(
//                 color: isSelected
//                     ? Colors.white.withOpacity(0.2)
//                     : color.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Text(
//                 count.toString(),
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : color,
//                   fontSize: 11,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
