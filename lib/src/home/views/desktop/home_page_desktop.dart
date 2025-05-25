import 'package:flutter/material.dart';

class HomePageDesktop extends StatefulWidget {
  const HomePageDesktop({super.key});

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  final int totalCustomers = 1500;
  final int inProgress = 450;
  final int resolved = 1050;
  final int unresolved = 350;
  final int totalAgents = 75;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'CRM Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, size: 30),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Customer Dashboard',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatCard(
                    'Total Customers',
                    totalCustomers,
                    color: Colors.blue,
                    icon: Icons.people,
                  ),
                  _buildStatCard(
                    'In Progress',
                    inProgress,
                    color: Colors.orange,
                    icon: Icons.access_time,
                  ),
                  _buildStatCard(
                    'Resolved',
                    resolved,
                    color: Colors.green,
                    icon: Icons.check_circle,
                  ),
                  _buildStatCard(
                    'Unresolved',
                    unresolved,
                    color: Colors.red,
                    icon: Icons.error,
                  ),
                ],
              ),
              const SizedBox(height: 40),

              const Text(
                'Agent Dashboard',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),
              _buildStatCard(
                'Total Agents',
                totalAgents,
                color: Colors.purple,
                icon: Icons.group,
              ),
              const SizedBox(height: 40),

              const Text(
                'Sales/Customer Trends',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'Chart Placeholder',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    int count, {
    Color color = Colors.blue,
    IconData? icon,
  }) {
    return GestureDetector(
      onTap: () {},
      child: MouseRegion(
        onEnter: (_) => {},
        onExit: (_) => {},
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: color.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      count.toString(),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
                Icon(icon ?? Icons.pie_chart, size: 40, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
