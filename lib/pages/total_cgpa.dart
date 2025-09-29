import 'package:flutter/material.dart';

class TotalCGPage extends StatefulWidget {
  @override
  _TotalCGPageState createState() => _TotalCGPageState();
}

class _TotalCGPageState extends State<TotalCGPage> {
  List<TextEditingController> creditControllers = [];
  List<TextEditingController> cgpaControllers = [];

  double? overallCGPA;
  double? totalCredits;

  void _addSemester() {
    setState(() {
      creditControllers.add(TextEditingController());
      cgpaControllers.add(TextEditingController());
    });
  }

  void _removeSemester(int index) {
    setState(() {
      creditControllers.removeAt(index);
      cgpaControllers.removeAt(index);
      // Reset results when semesters are modified
      overallCGPA = null;
      totalCredits = null;
    });
  }

  void _calculateCGPA() {
    double totalPoints = 0;
    double sumCredits = 0;

    for (int i = 0; i < creditControllers.length; i++) {
      double credit = double.tryParse(creditControllers[i].text) ?? 0;
      double cgpa = double.tryParse(cgpaControllers[i].text) ?? 0;

      totalPoints += credit * cgpa;
      sumCredits += credit;
    }

    setState(() {
      overallCGPA = sumCredits > 0 ? totalPoints / sumCredits : 0.0;
      totalCredits = sumCredits;
    });
  }

  Widget _buildResultCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.shade50,
            Colors.blue.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.purple.shade100),
      ),
      child: Column(
        children: [
          Text(
            "Overall Academic Summary",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade800,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMetricCard(
                "Total Credits",
                "${totalCredits!.toStringAsFixed(1)}",
                Icons.school_rounded,
                Colors.blue.shade700,
              ),
              _buildMetricCard(
                "Overall CGPA",
                overallCGPA!.toStringAsFixed(2),
                Icons.assessment_rounded,
                Colors.purple.shade700,
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _getCGPAColor(overallCGPA!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _getCGPAIcon(overallCGPA!),
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  _getCGPAStatus(overallCGPA!),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            "You have successfully completed ${totalCredits!.toStringAsFixed(1)} credits with Overall CGPA ${overallCGPA!.toStringAsFixed(2)}.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Color _getCGPAColor(double cgpa) {
    if (cgpa >= 3.75) return Colors.green.shade600;
    if (cgpa >= 3.25) return Colors.blue.shade600;
    if (cgpa >= 2.75) return Colors.orange.shade600;
    if (cgpa >= 2.00) return Colors.orange.shade800;
    return Colors.red.shade600;
  }

  IconData _getCGPAIcon(double cgpa) {
    if (cgpa >= 3.75) return Icons.emoji_events_rounded;
    if (cgpa >= 3.25) return Icons.thumb_up_rounded;
    if (cgpa >= 2.75) return Icons.check_circle_rounded;
    if (cgpa >= 2.00) return Icons.warning_amber_rounded;
    return Icons.error_outline_rounded;
  }

  String _getCGPAStatus(double cgpa) {
    if (cgpa >= 3.75) return "Excellent Performance!";
    if (cgpa >= 3.25) return "Very Good Performance";
    if (cgpa >= 2.75) return "Good Performance";
    if (cgpa >= 2.00) return "Satisfactory Performance";
    return "Needs Improvement";
  }

  Widget _buildSemesterCard(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.school_rounded,
                          size: 16,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        "Semester ${index + 1}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ],
                  ),
                  if (creditControllers.length > 1)
                    IconButton(
                      icon: Icon(Icons.delete_outline, color: Colors.red.shade400),
                      onPressed: () => _removeSemester(index),
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Completed Credits",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: creditControllers[index],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            hintText: "e.g., 15.0",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Semester CGPA",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: cgpaControllers[index],
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            hintText: "0-4",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                            suffixIcon: Icon(
                              Icons.grading_rounded,
                              size: 20,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Total CGPA Calculator",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.purple.shade800,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Calculate Overall CGPA",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade900,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Add your semester credits and GPA to calculate your cumulative CGPA",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Add Semester Button
                  Container(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _addSemester,
                      icon: Icon(Icons.add_circle_outline_rounded),
                      label: Text("Add New Semester"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade600,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // Semester List
                  if (creditControllers.isNotEmpty) ...[
                    ...List.generate(creditControllers.length, _buildSemesterCard),
                    SizedBox(height: 20),
                    
                    // Calculate Button
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _calculateCGPA,
                        child: Text(
                          "Calculate Overall CGPA",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade600,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                  
                  // Results
                  if (overallCGPA != null && totalCredits != null) 
                    _buildResultCard(),
                  
                  // Empty State
                  if (creditControllers.isEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 60),
                      padding: EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Icon(
                            Icons.timeline_rounded,
                            size: 80,
                            color: Colors.grey.shade300,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "No semesters added yet",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Click 'Add New Semester' to start calculating your overall CGPA",
                            style: TextStyle(
                              color: Colors.grey.shade400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}