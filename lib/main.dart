import 'package:flutter/material.dart';
import 'pages/instant_cg.dart';
import 'pages/total_cgpa.dart';
import 'pages/measurement.dart';
import 'pages/grade_prediction.dart';

void main() {
  runApp(CalcCGApp());
}

class CalcCGApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calc CG',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Inter',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<MenuCard> menuItems = [
    MenuCard(
      title: "Instant CG",
      icon: Icons.calculate_rounded,
      color: Colors.blue,
      route: InstantCGPage(),
    ),
    MenuCard(
      title: "Total CGPA",
      icon: Icons.bar_chart_rounded,
      color: Colors.green,
      route: TotalCGPage(),
    ),
    MenuCard(
      title: "Measurement",
      icon: Icons.straighten_rounded,
      color: Colors.orange,
      route: MeasurementPage(),
    ),
    MenuCard(
      title: "Grade Prediction",
      icon: Icons.trending_up_rounded,
      color: Colors.purple,
      route: GradePredictionPage(),
    ),
    MenuCard(
      title: "Others",
      icon: Icons.more_horiz_rounded,
      color: Colors.grey,
      route: Scaffold(
        appBar: AppBar(title: Text("Others")),
        body: Center(child: Text("Others Page: Under Construction")),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          "Calc CG",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "CGPA Calculator",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Choose a tool to get started",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Grid Menu
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return _buildMenuCard(item, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(MenuCard item, BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => item.route),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                item.color.withOpacity(0.1),
                item.color.withOpacity(0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  size: 28,
                  color: item.color,
                ),
              ),
              SizedBox(height: 12),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuCard {
  final String title;
  final IconData icon;
  final Color color;
  final Widget route;

  MenuCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });
}