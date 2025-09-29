import 'package:flutter/material.dart';

class TotalCGPage extends StatefulWidget {
  @override
  _TotalCGPageState createState() => _TotalCGPageState();
}

class _TotalCGPageState extends State<TotalCGPage> {
  final TextEditingController _semesterCountController = TextEditingController();
  int semesterCount = 0;

  List<TextEditingController> creditControllers = [];
  List<TextEditingController> cgpaControllers = [];

  double? overallCGPA;
  double? totalCredits;

  void _generateFields() {
    int count = int.tryParse(_semesterCountController.text) ?? 0;
    setState(() {
      semesterCount = count;
      creditControllers =
          List.generate(count, (index) => TextEditingController());
      cgpaControllers =
          List.generate(count, (index) => TextEditingController());
      overallCGPA = null;
      totalCredits = null;
    });
  }

  void _calculateCGPA() {
    double totalPoints = 0;
    double sumCredits = 0;

    for (int i = 0; i < semesterCount; i++) {
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

  Widget _buildResultTable() {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Semester')),
        DataColumn(label: Text('Credit')),
        DataColumn(label: Text('CGPA')),
      ],
      rows: List.generate(semesterCount, (index) {
        return DataRow(cells: [
          DataCell(Text('Semester ${index + 1}')),
          DataCell(Text(creditControllers[index].text)),
          DataCell(Text(cgpaControllers[index].text)),
        ]);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Total CGPA")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("How many semesters?"),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _semesterCountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter number of semesters",
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
            if (semesterCount > 0)
              Column(
                children: List.generate(semesterCount, (index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("Semester ${index + 1}"),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Credit"),
                                TextField(
                                  controller: creditControllers[index],
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  decoration: InputDecoration(
                                    hintText: "Completed credit",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("CGPA"),
                                TextField(
                                  controller: cgpaControllers[index],
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  decoration: InputDecoration(
                                    hintText: "0-4",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            if (semesterCount > 0)
              Center(
                child: ElevatedButton(
                  onPressed: _calculateCGPA,
                  child: Text("Calculate CGPA"),
                ),
              ),
            SizedBox(height: 20),
            if (overallCGPA != null && totalCredits != null)
              Column(
                children: [
                  _buildResultTable(),
                  SizedBox(height: 20),
                  Text(
                    "You have successfully completed ${totalCredits!.toStringAsFixed(1)} credits with Overall CGPA ${overallCGPA!.toStringAsFixed(2)}.",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
