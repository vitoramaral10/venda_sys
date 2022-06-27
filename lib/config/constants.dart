import 'package:brasil_fields/brasil_fields.dart';
import 'package:hive/hive.dart';

class Constants {
  static const double defaultPadding = 16.0;

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
