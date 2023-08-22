import 'package:uuid/uuid.dart';

class IMC {
  String localId;
  String nome;
  double peso;
  double altura;
  double resultado;
  String data;
  String classificacao;

  IMC({
    required this.localId,
    required this.nome,
    required this.peso,
    required this.altura,
    required this.resultado,
    required this.data,
    this.classificacao = ''
  });

  factory IMC.fromJson(Map<String, dynamic> json) {
    return IMC(
        localId: json['localId'] ?? '',
        nome: json['nome'],
        peso: json['peso'],
        altura: json['altura'],
        resultado: json['resultado'],
        data: json['data'],
        classificacao: json['classificacao']);
  }

  Map<String, dynamic> toJson() => {
        'localId': localId,
        'nome': nome,
        'peso': peso,
        'altura': altura,
        'resultado': resultado,
        'data': data,
        'classificacao': classificacao
      };
}
