import 'package:calculadora_imc_aprimorada_dio/models/imc.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../db/db.dart';
import 'package:intl/intl.dart';

class ImcController {
  final nomeController = TextEditingController();
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();
  final dataController = TextEditingController();
  final resultadoController = TextEditingController();
  final db = DB();

  void saveIMCData() async {
    double? result = calculaIMC(
        double.parse(pesoController.text), double.parse(alturaController.text));
    resultadoController.text = result!.toStringAsFixed(2);

    String classification = getClassificacao(result);

    final dataFormatada = DateFormat.MMMd().format(DateTime.now());

    IMC imcData = IMC(
      localId: Uuid().v4(),
      nome: nomeController.text,
      peso: double.parse(pesoController.text),
      altura: double.parse(alturaController.text),
      data: dataFormatada.toString(),
      resultado: double.parse(result.toStringAsFixed(2)),
      classificacao: classification,
    );

    db.addIMC(imcData);
    print('IMC Data saved to the database.');
  }

  String getClassificacao(double resultado) {
    if (resultado < 16) {
      return "Magreza grave";
    } else if (resultado < 17) {
      return "Magreza moderada";
    } else if (resultado < 18.5) {
      return "Magreza leve";
    } else if (resultado < 25) {
      return "Saudável";
    } else if (resultado < 30) {
      return "Sobrepeso";
    } else if (resultado < 35) {
      return "Obesidade Grau I";
    } else if (resultado < 40) {
      return "Obesidade Grau II(severa)";
    } else {
      return "Obesidade Grau III(mórbida)";
    }
  }

  double? calculaIMC(double peso, double altura) {
    try {
      double resultado = peso / (altura * altura);
      return resultado;
    } catch (e) {
      print('Erro: Os valores de peso e altura devem ser números válidos.');
    }
  }

  void printClassificacao(double resultado) {
    if (resultado < 16) {
      print("Classificação: Magreza grave");
    } else if (resultado == 16 || resultado < 17) {
      print("Classificação: Magreza moderada");
    } else if (resultado == 17 || resultado < 18.5) {
      print("Classificação: Magreza leve");
    } else if (resultado == 18.5 || resultado < 25) {
      print("Classificação: Saudável");
    } else if (resultado == 25 || resultado < 30) {
      print("Classificação: Sobrepeso");
    } else if (resultado == 30 || resultado < 35) {
      print("Classificação: Obesidade Grau I");
    } else if (resultado == 35 || resultado < 40) {
      print("Classificação: Obesidade Grau II(severa)");
    } else if (resultado >= 40) {
      print("Classificação: Obesidade Grau III(mórbida)");
    }
  }
}
