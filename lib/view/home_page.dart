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
      body: Obx(() => ListView.builder(
            itemCount: imcList.length,
            itemBuilder: (BuildContext context, int index) {
              IMC imc = imcList[index];
              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: ListTile(
                      leading: Column(
                        crossAxisAlignment: CrossAxisAlignment
                            .start,
                        children: [
                          Text("Nome: ${imc.nome}"),
                          Text("Peso: ${imc.peso.toStringAsFixed(2)}"),
                          Text("Altura: ${imc.altura.toStringAsFixed(2)}"),
                        ],
                      ),
                      title: Text("IMC: ${imc.resultado.toStringAsFixed(2)}"),
                      subtitle: Text("Classificação: ${imc.classificacao}"),
                      onTap: () async {
                        print(imc.toJson());
                      },
                      trailing: Column(
                        children: [Text("${imc.data}")],
                      )),
                ),
              );
            },
          )),
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
