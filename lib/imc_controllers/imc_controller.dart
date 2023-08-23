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
  final classificacaoController = TextEditingController();
  final db = DB();

  void saveIMCData(IMC imc) async {
    final dataFormatada = DateFormat('dd/MM/yyyy').format(DateTime.now());

    if (imc.resultado < 16) {
      classificacaoController.text = "Magreza grave";
    } else if (imc.resultado == 16 || imc.resultado < 17) {
      classificacaoController.text = "Magreza moderada";
    } else if (imc.resultado == 17 || imc.resultado < 18.5) {
      classificacaoController.text = "Magreza leve";
    } else if (imc.resultado == 18.5 || imc.resultado < 25) {
      classificacaoController.text = "Saudável";
    } else if (imc.resultado == 25 || imc.resultado < 30) {
      classificacaoController.text = "Sobrepeso";
    } else if (imc.resultado == 30 || imc.resultado < 35) {
      classificacaoController.text = "Obesidade Grau I";
    } else if (imc.resultado == 35 || imc.resultado < 40) {
      classificacaoController.text = "Obesidade Grau II(severa)";
    } else {
      classificacaoController.text = "Obesidade Grau III(mórbida)";
    }

    IMC imcData = IMC(
        localId: Uuid().v4(),
        nome: imc.nome,
        peso: imc.peso,
        altura: imc.altura,
        data: dataFormatada.toString(),
        resultado: imc.resultado,
        classificacao: classificacaoController.text);

    await db.addIMC(imcData);
    print('IMC Data saved to the database.');
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
