import 'package:flutter/material.dart';

class MeasurementPage extends StatelessWidget {
  final List<Map<String, String>> gradeList = [
    {"Marks": "80–100", "Grade": "A+", "GPA": "4.00"},
    {"Marks": "75–79", "Grade": "A", "GPA": "3.75"},
    {"Marks": "70–74", "Grade": "A-", "GPA": "3.50"},
    {"Marks": "65–69", "Grade": "B+", "GPA": "3.25"},
    {"Marks": "60–64", "Grade": "B", "GPA": "3.00"},
    {"Marks": "55–59", "Grade": "B-", "GPA": "2.75"},
    {"Marks": "50–54", "Grade": "C+", "GPA": "2.50"},
    {"Marks": "45–49", "Grade": "C", "GPA": "2.25"},
    {"Marks": "40–44", "Grade": "D", "GPA": "2.00"},
    {"Marks": "0–39", "Grade": "F", "GPA": "0.00"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Measurement / Grading System")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Grading System",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            DataTable(
              columns: const [
                DataColumn(label: Text('Marks')),
                DataColumn(label: Text('Grade')),
                DataColumn(label: Text('GPA')),
              ],
              rows: gradeList
                  .map(
                    (item) => DataRow(
                      cells: [
                        DataCell(Text(item["Marks"]!)),
                        DataCell(Text(item["Grade"]!)),
                        DataCell(Text(item["GPA"]!)),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
