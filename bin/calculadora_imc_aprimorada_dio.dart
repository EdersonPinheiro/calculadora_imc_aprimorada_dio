import 'dart:io';

import 'package:calculadora_imc_aprimorada_dio/imc_controllers/imc_controller.dart';
import 'package:calculadora_imc_aprimorada_dio/models/imc.dart';
import 'package:uuid/uuid.dart';

Future<void> main() async {
  ImcController imcController = ImcController();
  try {
    stdout.write('Informe o nome da pessoa: ');
    var nome = stdin.readLineSync();
    stdout.write('Informe o peso da pessoa: ');
    var peso = double.parse(stdin.readLineSync()!);
    stdout.write('Informe a altura da pessoa: ');
    var altura = double.parse(stdin.readLineSync()!);
    var imc = IMC(
      localId: const Uuid().v4(),
      nome: "Ederson",
      peso: peso,
      altura: altura,
      data: '',
      resultado: 0,
    );

    print('Nome: ${imc.nome}');
    print('Peso: ${imc.peso}');
    print('Altura: ${imc.altura}');

    double? resultado = imcController.calculaIMC(peso, altura);

    imcController.printClassificacao(resultado!);
    print('IMC: ${resultado.toStringAsFixed(2)}');
  } catch (e) {
    if (e is FormatException) {
      print('Insira um valor válido');
    } else {
      print(e.toString());
    }
  }
}
