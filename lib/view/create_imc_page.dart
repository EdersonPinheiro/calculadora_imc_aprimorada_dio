// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../db/db.dart';
import 'package:uuid/uuid.dart';

import '../components/button.dart';
import '../imc_controllers/imc_controller.dart';

class CreateImcPage extends StatefulWidget {
  final Function reload;
  const CreateImcPage({super.key, required this.reload});
  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateImcPage> {
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
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      nome = value;
                      imcController.nomeController.text = nome;
                    });
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
                      imcController.pesoController.text =
                          peso.toStringAsFixed(2);
                    });
                  },
                  min: 1.0,
                  max: 200.0,
                ),
                SizedBox(height: 16.0),
                Text('Altura: ${altura.toStringAsFixed(1)} cm'),
                Slider(
                  value: altura,
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
                ElevatedButton(
                    onPressed: () {
                      imcController.saveIMCData();
                      Get.back();
                      widget.reload();
                    },
                    child: Text("Salvar IMC"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
