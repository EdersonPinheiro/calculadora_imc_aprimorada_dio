import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../db/db.dart';
import '../models/imc.dart';
import 'create_imc_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getIMCsDB();
  }

  final db = DB();
  final imcList = <IMC>[].obs;
  bool isLoading = true;

  Future<void> getIMCsDB() async {
    imcList.value = await db.getIMCDB();
    for (var element in imcList) {
      element.nome;
    }
    print(imcList.value);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Calculadora IMC')),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: imcList.length,
          itemBuilder: (BuildContext context, int index) {
            IMC imc = imcList[index];
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Make the name and IMC labels 100% width
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Nome: ${imc.nome}",
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text("IMC: ${imc.resultado.toStringAsFixed(2)}"),
                    ),
                    // Make the weight and height labels 50% width
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            "Peso: ${imc.peso.toStringAsFixed(2)}",
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Altura: ${imc.altura.toStringAsFixed(2)}m",
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Text("Classificacao: ${imc.classificacao}",
                        textAlign: TextAlign.center),
                    SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            "Data: ${imc.data}",
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            CreateImcPage(reload: getIMCsDB),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
