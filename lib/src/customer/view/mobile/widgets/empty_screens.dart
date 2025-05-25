import 'package:crmapp/src/customer/view/mobile/customer_screen_mobile.dart';
import 'package:flutter/material.dart';

class EmptyScreens {
  Widget buildEmptyState(String query) {
    String message;
    String description;
    IconData icon;

    if (query.isNotEmpty) {
      message = 'No customers found';
      description = 'No customers match your search criteria';
      icon = Icons.search_off;
    } else if (query == CustomerFilter.active) {
      message = 'No active customers';
      description = 'You don\'t have any active customers at the moment';
      icon = Icons.person_off;
    } else if (query == CustomerFilter.inactive) {
      message = 'No inactive customers';
      description = 'All your customers are currently active';
      icon = Icons.check_circle;
    } else {
      message = 'No customers yet';
      description = 'Start by adding your first customer';
      icon = Icons.people_outline;
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
