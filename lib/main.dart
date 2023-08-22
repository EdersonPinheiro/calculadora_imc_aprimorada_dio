import 'package:calculadora_imc_aprimorada_dio/components/button.dart';
import 'package:calculadora_imc_aprimorada_dio/imc_controllers/imc_controller.dart';
import 'package:calculadora_imc_aprimorada_dio/view/create_imc_page.dart';
import 'package:calculadora_imc_aprimorada_dio/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'db/db.dart';
import 'models/imc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
