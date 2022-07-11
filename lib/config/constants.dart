import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Constants {
  static const int flex1 = 1;
  static const int flex2 = 2;
  static const int flex3 = 3;
  static const int flex4 = 4;
  static const int flex5 = 5;
  static const int flex6 = 6;
  static const int flex7 = 7;
  static const int flex8 = 8;
  static const int flex9 = 9;
  static const int flex10 = 10;
  static const int flex11 = 11;
  static const int flex12 = 12;

  static const double defaultPadding = 16.0;
  static const double middlePadding = Constants.defaultPadding / 2;
  static const double doublePadding = defaultPadding * 2;
  static const double smallButtonRadius = Constants.defaultPadding / 3;
  static const int minPasswordLength = 6;

  static const double logoWidth = 180;
  static const double widthMobile = 500;
  static const double dialogHeight = 200;
  static const double dialogWidth = 100;

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
  static String products = 'produtos';
  static String clients = 'clientes';

  static const double radius = Constants.defaultPadding / 2;

  static const double buttonRadius = 10;

  static const Map<String, String> personType = {
    'J': 'Jurídica',
    'F': 'Física',
  };

  static const double datePickerSize = 300;

  static Box box = Hive.box(boxName);

  static String boxName = 'vendasys';

  static String collection = (const String.fromEnvironment('flavor') != 'dev')
      ? 'empresas'
      : 'empresas_teste';

  static const tiposPessoa = [
    {'key': '', 'value': 'Selecione'},
    {'key': 'PJ', 'value': 'Pessoa Jurídica'},
    {'key': 'PF', 'value': 'Pessoa Física'},
  ];

  static const int phoneLength = 9;

  static Map<String, String> estados() {
    Map<String, String> estados = {'': 'Selecione'};

    for (var element in Estados.listaEstados) {
      estados.addAll({element: element});
    }

    return estados;
  }
}
