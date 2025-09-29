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
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calc CG")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MenuButton(
                title: "Instant CG",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InstantCGPage()),
                  );
                },
              ),
              MenuButton(
                title: "Total CGPA",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TotalCGPage()),
                  );
                },
              ),
              MenuButton(
                title: "Measurement",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MeasurementPage()),
                  );
                },
              ),
              MenuButton(
                title: "Grade Prediction",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GradePredictionPage()),
                  );
                },
              ),
              MenuButton(
                title: "Others",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Scaffold(
                        appBar: AppBar(title: Text("Others")),
                        body: Center(
                            child: Text("Others Page: Under Construction")),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  MenuButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: 200,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(padding: EdgeInsets.all(16)),
        child: Text(title, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
