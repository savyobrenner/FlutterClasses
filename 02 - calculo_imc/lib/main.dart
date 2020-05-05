import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController wheightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  void _resetFields() {
    wheightController.text = "";
    heightController.text = "";
    setState(() {
      _infoTeste = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double wheight = double.parse(wheightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = wheight/(height*height);
      if (imc < 18.6){
        _infoTeste = "Abaixo do peso, (${imc.toStringAsPrecision(4)})";
      } else if ( imc >= 18.6 && imc <24.9 ) {
        _infoTeste = "Peso ideal, (${imc.toStringAsPrecision(4)})";
      }else if ( imc >= 24.9 && imc <29.9 ) {
        _infoTeste = "Levemente acima do peso, (${imc.toStringAsPrecision(4)})";
      }else if ( imc >= 29.9 && imc <34.9 ) {
        _infoTeste = "Obesidade grau I, (${imc.toStringAsPrecision(4)})";
      }else if ( imc >= 34.9 && imc <39.9 ) {
        _infoTeste = "Obesidade grau II, (${imc.toStringAsPrecision(4)})";
      }else if ( imc >= 40.0 ) {
        _infoTeste = "Obesidade grau III, (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  String _infoTeste = "Informe seus dados";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _resetFields();
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 120.0, color: Colors.green),
                TextFormField(
                    keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
                    decoration: InputDecoration(
                        labelText: "Peso (Kg)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    controller: wheightController,
                validator: (value) {
                      if (value.isEmpty){
                        return "Insira seu Peso";
                      }
                }),
                TextFormField(
                    keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true) ,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                    controller: heightController,
                  validator: (value){
                      if (value.isEmpty){
                        return "Insira sua altura";
                      }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.green,
                        onPressed: (){
                          if (_formKey.currentState.validate()){
                            _calculate();
                          }
                        },
                      )),
                ),
                Text(
                  _infoTeste,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                ),
              ],
            ),
          ),
        ));
  }
}
