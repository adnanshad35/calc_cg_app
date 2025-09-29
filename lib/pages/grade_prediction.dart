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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grade Prediction")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Text("Course Type: ", style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: courseType,
                  items: ["Theory", "Lab"]
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      courseType = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            if (courseType == "Theory")
              Column(
                children: [
                  // Table header
                  Row(
                    children: [
                      Expanded(child: Text("Assessment", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text("Out of", style: TextStyle(fontWeight: FontWeight.bold))),
                      Expanded(child: Text("Marks", style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Fixed assessments with numeric input for marks
                  _buildRow("MidTerm", "30", isDropdown: false),
                  _buildRow("Final", "40", isDropdown: false),
                  _buildRow("Tutorial", "10", isDropdown: false),
                  _buildRow("Attendance", outOfValues["Attendance"]!, isDropdown: true),
                  _buildRow("Assignment", outOfValues["Assignment"]!, isDropdown: true),
                  _buildRow("Viva", outOfValues["Viva"]!, isDropdown: true),
                  _buildRow("Presentation", outOfValues["Presentation"]!, isDropdown: true),

                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: _calculateTotalMarks,
                      child: Text("Predict Grade"))
                ],
              ),
            if (courseType == "Lab")
              Center(
                  child: Padding(
                padding: EdgeInsets.all(20),
                child: Text("Lab Course: Under Construction",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              )),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String assessment, String defaultOutOf, {required bool isDropdown}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(child: Text(assessment)),
          Expanded(
            child: isDropdown
                ? DropdownButton<String>(
                    value: outOfValues[assessment],
                    items: outOfOptions
                        .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        outOfValues[assessment] = value!;
                      });
                    },
                  )
                : Text(defaultOutOf),
          ),
          Expanded(
            child: TextField(
              controller: marksControllers[assessment],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Enter marks"),
            ),
          ),
        ],
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

  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text("Predicted Result"),
            content: Text(
                "Total Marks: $total / $maxTotal\nPercentage: ${percentage.toStringAsFixed(2)}%\nPredicted Grade: $grade"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"))
            ],
          ));
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
