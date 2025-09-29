import 'package:flutter/material.dart';

class GradePredictionPage extends StatefulWidget {
  @override
  _GradePredictionPageState createState() => _GradePredictionPageState();
}

class _GradePredictionPageState extends State<GradePredictionPage> {
  String courseType = "Theory"; // Default selection

  // Dropdown options
  final List<String> outOfOptions = ["0", "5", "10"];
  Map<String, String> outOfValues = {
    "Attendance": "0",
    "Assignment": "0",
    "Viva": "0",
    "Presentation": "0",
  };

  final Map<String, TextEditingController> marksControllers = {
    "MidTerm": TextEditingController(),
    "Final": TextEditingController(),
    "Tutorial": TextEditingController(),
    "Attendance": TextEditingController(),
    "Assignment": TextEditingController(),
    "Viva": TextEditingController(),
    "Presentation": TextEditingController(),
  };

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
        return Colors.red.shade600;
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
          "Grade Predictor",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.orange.shade800,
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
                  "Predict Your Course Grade",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade900,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Enter your assessment marks to predict your final grade",
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
                  // Course Type Selector
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.class_rounded,
                          color: Colors.orange.shade700,
                          size: 20,
                        ),
                        SizedBox(width: 12),
                        Text(
                          "Course Type:",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<String>(
                            value: courseType,
                            items: ["Theory", "Lab"].map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(
                                  type,
                                  style: TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                courseType = value!;
                              });
                            },
                            underline: SizedBox(),
                            icon: Icon(Icons.arrow_drop_down_rounded),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  if (courseType == "Theory") ...[
                    // Assessment Cards
                    Text(
                      "Assessment Marks",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 16),

                    // Fixed assessments
                    _buildAssessmentCard(
                      "MidTerm Exam",
                      "30",
                      marksControllers["MidTerm"]!,
                      isDropdown: false,
                      icon: Icons.quiz_rounded,
                      color: Colors.blue,
                    ),
                    _buildAssessmentCard(
                      "Final Exam",
                      "40",
                      marksControllers["Final"]!,
                      isDropdown: false,
                      icon: Icons.assignment_rounded,
                      color: Colors.purple,
                    ),
                    _buildAssessmentCard(
                      "Tutorial",
                      "10",
                      marksControllers["Tutorial"]!,
                      isDropdown: false,
                      icon: Icons.groups_rounded,
                      color: Colors.green,
                    ),
                    _buildAssessmentCard(
                      "Attendance",
                      outOfValues["Attendance"]!,
                      marksControllers["Attendance"]!,
                      isDropdown: true,
                      icon: Icons.person_rounded,
                      color: Colors.orange,
                    ),
                    _buildAssessmentCard(
                      "Assignment",
                      outOfValues["Assignment"]!,
                      marksControllers["Assignment"]!,
                      isDropdown: true,
                      icon: Icons.assignment_turned_in_rounded,
                      color: Colors.teal,
                    ),
                    _buildAssessmentCard(
                      "Viva",
                      outOfValues["Viva"]!,
                      marksControllers["Viva"]!,
                      isDropdown: true,
                      icon: Icons.mic_rounded,
                      color: Colors.red,
                    ),
                    _buildAssessmentCard(
                      "Presentation",
                      outOfValues["Presentation"]!,
                      marksControllers["Presentation"]!,
                      isDropdown: true,
                      icon: Icons.slideshow_rounded,
                      color: Colors.indigo,
                    ),

                    SizedBox(height: 24),
                    // Predict Button
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _calculateTotalMarks,
                        child: Text(
                          "Predict My Grade",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange.shade600,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],

                  if (courseType == "Lab")
                    Container(
                      margin: EdgeInsets.only(top: 60),
                      padding: EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Icon(
                            Icons.science_rounded,
                            size: 80,
                            color: Colors.grey.shade300,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Lab Course Feature",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "This feature is currently under development",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.orange.shade200),
                            ),
                            child: Text(
                              "Coming Soon",
                              style: TextStyle(
                                color: Colors.orange.shade800,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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

  Widget _buildAssessmentCard(
    String title,
    String maxMarks,
    TextEditingController controller, {
    required bool isDropdown,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 18, color: color),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Maximum Marks",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      isDropdown
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButton<String>(
                                value: outOfValues[title.split(' ')[0]],
                                items: outOfOptions.map((val) {
                                  return DropdownMenuItem(
                                    value: val,
                                    child: Text(
                                      val,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    outOfValues[title.split(' ')[0]] = value!;
                                  });
                                },
                                isExpanded: true,
                                underline: SizedBox(),
                                icon: Icon(Icons.arrow_drop_down_rounded, size: 20),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.shade50,
                              ),
                              child: Text(
                                maxMarks,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade700,
                                ),
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
                        "Your Marks",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      TextField(
                        controller: controller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter marks",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
    );
  }

  void _calculateTotalMarks() {
    int total = 0;
    int maxTotal = 0;

    // Sum user-entered marks & sum max marks
    marksControllers.forEach((key, controller) {
      int mark = int.tryParse(controller.text) ?? 0;
      total += mark;

      // Max marks
      int maxMark;
      if (key == "MidTerm") maxMark = 30;
      else if (key == "Final") maxMark = 40;
      else if (key == "Tutorial") maxMark = 10;
      else maxMark = int.tryParse(outOfValues[key]!) ?? 0;

      maxTotal += maxMark;
    });

    double percentage = (total / maxTotal) * 100;
    String grade = _getGrade(percentage);

    // Custom dialog for results
    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.orange.shade50,
                Colors.white,
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                size: 48,
                color: Colors.orange.shade700,
              ),
              SizedBox(height: 16),
              Text(
                "Grade Prediction Result",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade900,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    _buildResultRow("Total Marks", "$total / $maxTotal"),
                    _buildResultRow("Percentage", "${percentage.toStringAsFixed(2)}%"),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: _getGradeColor(grade).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _getGradeColor(grade).withOpacity(0.3)),
                      ),
                      child: Text(
                        "Predicted Grade: $grade",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _getGradeColor(grade),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Got It!"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade600,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  // Determine grade based on percentage
  String _getGrade(double percentage) {
    if (percentage >= 80)
      return "A+";
    else if (percentage >= 75)
      return "A";
    else if (percentage >= 70)
      return "A-";
    else if (percentage >= 65)
      return "B+";
    else if (percentage >= 60)
      return "B";
    else if (percentage >= 55)
      return "B-";
    else if (percentage >= 50)
      return "C+";
    else if (percentage >= 45)
      return "C";
    else if (percentage >= 40)
      return "D";
    else
      return "F";
  }
}
