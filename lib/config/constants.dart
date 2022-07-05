import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Constants {
  static const double defaultPadding = 16.0;
  static const double middlePadding = Constants.defaultPadding / 2;
  static const double doublePadding = defaultPadding * 2;
  static const double smallButtonRadius = Constants.defaultPadding / 3;
  static const int minPasswordLength = 6;

  static const double logoWidth = 180;
  static const double widthMobile = 500;
  static const double dialogHeight = 200;
  static const double dialogWidth = 100;

  static const int flex2 = 2;
  static const int flex3 = 3;
  static const int flex4 = 4;
  static const int flex7 = 7;

  static const double iconSize = 20;
  static const int decimalPrecision = 2;
  static const double buttonHeight = 50;

  static const double fontSize12 = 12;
  static const double fontSize14 = 14;
  static const double fontSize16 = 16;
  static const double fontSize18 = 18;
  static const double fontSize20 = 20;
  static const double fontSize22 = 22;
  static const double fontSize24 = 24;

  static const Color primaryColor = Color(0xFFFFCD00);
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color textColor = Color(0xFF4D4D4D);

  static String unitsOfMeasurement = 'unidades_medidas';
  static String products = 'products';
  static String clients = 'clients';

  static Box box = Hive.box(boxName);

  static String boxName = 'vendasys';

  static String collection = (const String.fromEnvironment('flavor') == 'prod')
      ? 'empresas'
      : 'empresas_teste';

  static const tiposPessoa = {
    '': 'Selecione',
    'J': 'Jurídica',
    'F': 'Física',
  };



  static Map<String, String> estados() {
    Map<String, String> estados = {'': 'Selecione'};

    for (var element in Estados.listaEstados) {
      estados.addAll({element: element});
    }

    return estados;
  }
}
