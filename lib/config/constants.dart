import 'package:hive/hive.dart';

class Constants {
  static const double defaultPadding = 16.0;

  static String unitsOfMeasurement = 'unidades_medidas';

  static Box box = Hive.box(boxName);

  static String boxName = 'vendasys';
}
