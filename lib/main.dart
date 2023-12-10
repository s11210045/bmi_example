import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage>{
  var weightController = TextEditingController();
  var heightFtController = TextEditingController();
  var heightInchController = TextEditingController();

  var bmiScore = 0.0;
  var bmiType = "";
  var bgColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('BMI', style: TextStyle(fontSize: 21),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Measure your BMI', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 21,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: weightController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.line_weight),
                  label: Text('weight'),
                  hintText: "Enter your weight (in kg)",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21)
                  )
              ),
            ),
            SizedBox(
              height: 11,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: heightFtController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.height),
                  label: Text('feet'),
                  hintText: "Enter your feet (in ft)",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21)
                  )
              ),
            ),
            SizedBox(
              height: 11,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: heightInchController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.height),
                  label: Text('inch'),
                  hintText: "Enter your height in inches (in)",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21)
                  )
              ),
            ),
            SizedBox(
              height: 21,
            ),
            ElevatedButton(onPressed: (){
              calculateBmi();
            },
                child: Text('Calculate BMI')),
            SizedBox(
              height: 11,
            ),
            bmiScore == 0.0
                ? Container()
                : Text('BMI is ${bmiScore.toStringAsFixed(2)}', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
            bmiType == ""
                ? Container()
                : Text('You are $bmiType'),
            SizedBox(
              height: 11,
            ),
            ElevatedButton(
              onPressed: () {
                clearFields();
              },
              child: Text('Clear'),
            ),


          ],
        ),
      ),
    );
  }

  ///BMI Calculation
  void calculateBmi(){
    var weight = int.parse(weightController.text.toString());
    var feet = int.parse(heightFtController.text.toString());
    var inch = int.parse(heightInchController.text.toString());

    //ft and inch to m
    var totalInches = (feet * 12) + inch;
    var totalCM = totalInches * 2.54;

    //cm to m
    var totalM = totalCM/100;

    //bmi calculation
    var bmi = weight/(pow(totalM, 2.0));

    /// check the type from BMI
    if (bmi > 30){
      bmiType = "Obese";
      bgColor = Colors.red.shade400;
    } else if (bmi > 25){
      bmiType = "Over Weight";
      bgColor = Colors.yellow.shade400;
    } else if (bmi < 18.5){
      bmiType = "Under Weight";
      bgColor = Colors.blue.shade400;
    }  else {
      bmiType = "Healthy";
      bgColor = Colors.green.shade400;
    }

    bmiScore = bmi;


    setState(() {

    });

  }

  ///Clear Button
  void clearFields() {
    weightController.clear();
    heightFtController.clear();
    heightInchController.clear();
    bmiScore = 0.0;
    bmiType = "";
    bgColor = Colors.white;

    setState(() {});
  }

}