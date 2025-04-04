import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar (
          title: Text("BMI Calculator"),
        ),
        body: const BMIForm(),
        ),
    );
  }
}


// Define a custom Form widget.
class BMIForm extends StatefulWidget {
  const BMIForm({super.key});

  @override
  BMIFormState createState() {
    return BMIFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class BMIFormState extends State<BMIForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<BMIFormState>.
  final _formKey = GlobalKey<FormState>();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  String result(height,weight) {
    double doubleHeight = double.parse(height);
    double doubleWeight = double.parse(weight);
    return (doubleWeight/(doubleHeight*doubleHeight)).toStringAsFixed(2);
  }

  bool isNumber(String input) {
    return num.tryParse(input) != null;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    weightController.dispose();
    heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your weight(kg)',
                ),
              validator: (value) {
               if (value == null || value.isEmpty || isNumber(value) == false ) {
                return 'Please enter a number';
                }
                return null;
                },
              controller: weightController,
                ),
            SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                 labelText: 'Enter your height(m)',
                 ),  
              validator: (value) {
                if (value == null || value.isEmpty || isNumber(value) == false ) {
                 return 'Please enter a number';
                 }
                 return null;
                 },
              controller: heightController,
                ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text("Your BMI is :  ${result(heightController.text,weightController.text)}"),
                        );
                      },
                    );                    
                 }
                },
                 child: Text('Calculate')
                ),
          ],
        ),
      )
      );
  }
}
