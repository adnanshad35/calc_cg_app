import 'package:flutter/material.dart';

class InstantCGPage extends StatefulWidget {
  @override
  _InstantCGPageState createState() => _InstantCGPageState();
}

class _InstantCGPageState extends State<InstantCGPage> {
  final TextEditingController _courseCountController = TextEditingController();
  int courseCount = 0;

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

  void _generateFields() {
    int count = int.tryParse(_courseCountController.text) ?? 0;
    setState(() {
      courseCount = count;
      courseControllers =
          List.generate(count, (index) => TextEditingController());
      selectedCredits = List.generate(count, (index) => 3.0); // default
      selectedGrades = List.generate(count, (index) => "A+"); // default
      gpaResult = null;
      completedCredits = null;
    });
  }

  void _calculateGPA() {
    double totalPoints = 0;
    double totalCompletedCredits = 0;

    for (int i = 0; i < courseCount; i++) {
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

  Widget _buildResultTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Course Name')),
        DataColumn(label: Text('Course Credit')),
        DataColumn(label: Text('Course Grade')),
      ],
      rows: List.generate(courseCount, (index) {
        return DataRow(cells: [
          DataCell(Text(courseControllers[index].text)),
          DataCell(Text(selectedCredits[index].toString())),
          DataCell(Text(selectedGrades[index])),
        ]);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Instant CG")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("How many courses?"),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _courseCountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter number of courses",
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _generateFields,
                  child: Text("OK"),
                )
              ],
            ),
            SizedBox(height: 20),
            if (courseCount > 0)
              Column(
                children: List.generate(courseCount, (index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Course ${index + 1}"),
                          TextField(
                            controller: courseControllers[index],
                            decoration: InputDecoration(
                              labelText: "Course Name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Credit"),
                                    DropdownButton<double>(
                                      value: selectedCredits[index],
                                      items: creditOptions.map((credit) {
                                        return DropdownMenuItem<double>(
                                          value: credit,
                                          child: Text(credit.toString()),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedCredits[index] = value!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Grade"),
                                    DropdownButton<String>(
                                      value: selectedGrades[index],
                                      items: gradeMap.keys.map((grade) {
                                        return DropdownMenuItem<String>(
                                          value: grade,
                                          child: Text(grade),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedGrades[index] = value!;
                                        });
                                      },
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
                }),
              ),
            if (courseCount > 0)
              Center(
                child: ElevatedButton(
                  onPressed: _calculateGPA,
                  child: Text("Calculate GPA"),
                ),
              ),
            SizedBox(height: 20),
            if (gpaResult != null && completedCredits != null)
              Column(
                children: [
                  _buildResultTable(),
                  SizedBox(height: 20),
                  Text(
                    "You have successfully completed ${completedCredits!.toStringAsFixed(1)} credits with CG ${gpaResult!.toStringAsFixed(2)} in this semester.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
