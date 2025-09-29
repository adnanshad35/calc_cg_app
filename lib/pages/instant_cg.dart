import 'package:flutter/material.dart';

class InstantCGPage extends StatefulWidget {
  @override
  _InstantCGPageState createState() => _InstantCGPageState();
}

class _InstantCGPageState extends State<InstantCGPage> {
  // Grade mapping
  final Map<String, double> gradeMap = {
    "A+": 4.00,
    "A": 3.75,
    "A-": 3.50,
    "B+": 3.25,
    "B": 3.00,
    "B-": 2.75,
    "C+": 2.50,
    "C": 2.25,
    "D": 2.00,
    "F": 0.00,
  };

  // Available credit options
  final List<double> creditOptions = [1, 1.5, 2, 2.5, 3, 3.5, 4];

  List<TextEditingController> courseControllers = [];
  List<double> selectedCredits = [];
  List<String> selectedGrades = [];

  double? gpaResult;
  double? completedCredits;

  void _addCourse() {
    setState(() {
      courseControllers.add(TextEditingController());
      selectedCredits.add(3.0); // default credit
      selectedGrades.add("A+"); // default grade
    });
  }

  void _removeCourse(int index) {
    setState(() {
      courseControllers.removeAt(index);
      selectedCredits.removeAt(index);
      selectedGrades.removeAt(index);
      // Reset results when courses are modified
      gpaResult = null;
      completedCredits = null;
    });
  }

  void _calculateGPA() {
    double totalPoints = 0;
    double totalCompletedCredits = 0;

    for (int i = 0; i < courseControllers.length; i++) {
      double credit = selectedCredits[i];
      double gradeValue = gradeMap[selectedGrades[i]]!;

      // Only consider non-F courses
      if (selectedGrades[i] != "F") {
        totalPoints += credit * gradeValue;
        totalCompletedCredits += credit;
      }
    }

    setState(() {
      gpaResult = totalCompletedCredits > 0
          ? totalPoints / totalCompletedCredits
          : 0.0; // if all F, CG = 0
      completedCredits = totalCompletedCredits;
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
            Colors.blue.shade50,
            Colors.green.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Column(
        children: [
          Text(
            "Semester Results",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade800,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMetricCard(
                "Completed Credits",
                "${completedCredits!.toStringAsFixed(1)}",
                Icons.school_rounded,
                Colors.green,
              ),
              _buildMetricCard(
                "CGPA",
                gpaResult!.toStringAsFixed(2),
                Icons.assessment_rounded,
                Colors.blue,
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            "You have successfully completed ${completedCredits!.toStringAsFixed(1)} credits with CG ${gpaResult!.toStringAsFixed(2)} in this semester.",
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

  Widget _buildCourseCard(int index) {
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
                  Text(
                    "Course ${index + 1}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade800,
                    ),
                  ),
                  if (courseControllers.length > 1)
                    IconButton(
                      icon: Icon(Icons.delete_outline, color: Colors.red.shade400),
                      onPressed: () => _removeCourse(index),
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                ],
              ),
              SizedBox(height: 12),
              TextField(
                controller: courseControllers[index],
                decoration: InputDecoration(
                  labelText: "Course Name",
                  hintText: "Enter course name...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Credit Hours",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<double>(
                            value: selectedCredits[index],
                            items: creditOptions.map((credit) {
                              return DropdownMenuItem<double>(
                                value: credit,
                                child: Text(
                                  credit.toString(),
                                  style: TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCredits[index] = value!;
                              });
                            },
                            isExpanded: true,
                            underline: SizedBox(),
                            icon: Icon(Icons.arrow_drop_down_rounded),
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
                          "Grade",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<String>(
                            value: selectedGrades[index],
                            items: gradeMap.keys.map((grade) {
                              Color gradeColor = _getGradeColor(grade);
                              return DropdownMenuItem<String>(
                                value: grade,
                                child: Text(
                                  grade,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: gradeColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedGrades[index] = value!;
                              });
                            },
                            isExpanded: true,
                            underline: SizedBox(),
                            icon: Icon(Icons.arrow_drop_down_rounded),
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

  Color _getGradeColor(String grade) {
    switch (grade) {
      case "A+":
      case "A":
      case "A-":
        return Colors.green.shade700;
      case "B+":
      case "B":
      case "B-":
        return Colors.blue.shade700;
      case "C+":
      case "C":
        return Colors.orange.shade700;
      case "D":
        return Colors.red.shade700;
      case "F":
        return Colors.red.shade900;
      default:
        return Colors.grey.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Instant CG Calculator",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue.shade800,
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
                  "Calculate Your Semester GPA",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade900,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Add your courses, credits, and grades to calculate your instant CGPA",
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
                  // Add Course Button
                  Container(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _addCourse,
                      icon: Icon(Icons.add_circle_outline_rounded),
                      label: Text("Add New Course"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  // Course List
                  if (courseControllers.isNotEmpty) ...[
                    ...List.generate(courseControllers.length, _buildCourseCard),
                    SizedBox(height: 20),
                    
                    // Calculate Button
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _calculateGPA,
                        child: Text(
                          "Calculate GPA",
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
                  if (gpaResult != null && completedCredits != null) 
                    _buildResultCard(),
                  
                  // Empty State
                  if (courseControllers.isEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 60),
                      padding: EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Icon(
                            Icons.school_outlined,
                            size: 80,
                            color: Colors.grey.shade300,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "No courses added yet",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Click 'Add New Course' to get started",
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