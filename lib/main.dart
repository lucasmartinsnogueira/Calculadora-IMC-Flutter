import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String infoTexto = 'Informe seus dados';
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  Widget buildTextField(String label, TextEditingController c) {
    return TextField(
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.green, fontSize: 20.0),
          border: OutlineInputBorder()),
      style: TextStyle(color: Colors.green, fontSize: 25),
      keyboardType: TextInputType.number,
      controller: c,
    );
  }

  void _reseFields() {
    setState(() {
      weightController.text = '';
      heightController.text = '';
      infoTexto = 'informe seus dados';
    });
  }

  void _calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text) / 100;
    double imc = weight / (height * height);
    setState(() {
      if (imc < 17) {
        infoTexto = 'Muito abaixo do peso (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 17 && imc <= 18.49) {
        infoTexto = 'Abaixo do peso (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 18.5 && imc <= 24.99) {
        infoTexto = 'Peso ideal ou normal (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 25 && imc <= 29.99) {
        infoTexto = 'Acima do peso (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 30 && imc <= 34.99) {
        infoTexto = 'Obesidade I (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 35 && imc <= 39.99) {
        infoTexto = 'Obesidade II (severa) (${imc.toStringAsPrecision(4)})';
      } else if (imc >= 40) {
        infoTexto = 'Obesidade III (órbida) (${imc.toStringAsPrecision(4)})';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _reseFields();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset('assets/imagens/logo.jpg'),
            Divider(),
            buildTextField('Peso (kg)', weightController),
            Divider(),
            buildTextField('Altura (cm)', heightController),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                height: 50.0,
                child: RaisedButton(
                  child: Text(
                    "Verificar",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                  onPressed: () {
                    _calculate();
                  },
                  color: Colors.green,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                infoTexto,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
