import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../db/db.dart';
import '../imc_controllers/imc_controller.dart';
import '../models/imc.dart';
import 'create_imc_page.dart';

class CreateImcPage extends StatefulWidget {
  final Function reload;
  const CreateImcPage({super.key, required this.reload});

  @override
  State<CreateImcPage> createState() => _CreateImcPageState();
}

class _CreateImcPageState extends State<CreateImcPage> {
  final db = DB();
  double peso = 50.0;
  double altura = 150.0;
  String nome = '';
  ImcController imcController = ImcController();

  double calculateIMC() {
    double alturaMetros = altura / 100;
    final calc = peso / (alturaMetros * alturaMetros);
    imcController.resultadoController.text = calc.toStringAsFixed(2);
    return calc;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMC"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                onChanged: (value) {
                  if (value.length <= 10) {
                    // Enforce maximum length of 10 characters
                    setState(() {
                      nome = value;
                      imcController.nomeController.text = nome;
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              SizedBox(height: 16.0),
              Text('Peso: ${peso.toStringAsFixed(1)} kg'),
              Slider(
                value: peso,
                onChanged: (newValue) {
                  setState(() {
                    peso = newValue;
                    imcController.pesoController.text = peso.toStringAsFixed(2);
                  });
                },
                min: 1.0,
                max: 200.0,
              ),
              SizedBox(height: 16.0),
              Text('Altura: ${(altura / 100).toStringAsFixed(2)} m'),
              Slider(
                value: double.parse(altura.toStringAsFixed(2)),
                onChanged: (newValue) {
                  setState(() {
                    altura = newValue;
                    imcController.alturaController.text =
                        altura.toStringAsFixed(2);
                  });
                },
                min: 50.0,
                max: 250.0,
              ),
              SizedBox(height: 16.0),
              Text('IMC: ${calculateIMC().toStringAsFixed(2)}'),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        final imc = IMC(
                            localId: Uuid().v4(),
                            nome: imcController.nomeController.text,
                            peso: peso,
                            altura: altura / 100,
                            data: DateTime.now().toString(),
                            resultado: calculateIMC(),
                            classificacao:
                                imcController.resultadoController.text);
                        imcController.saveIMCData(imc);
                        widget.reload();
                        Get.back();
                      },
                      child: Text("Salvar IMC")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
