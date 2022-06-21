// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:get/get.dart';
import 'package:venda_sys/services/firebase_service.dart';

import '../models/unit_of_measurement.dart';

class UnitsOfMeasurementController extends GetxController {
  static UnitsOfMeasurementController get to =>
      Get.find<UnitsOfMeasurementController>();
  final _units = <UnitOfMeasurement>[].obs;
  final _loading = false.obs;

  List<UnitOfMeasurement> get units => _units.value;
  bool get loading => _loading.value;

  @override
  void onInit() {
    super.onInit();
    loadUnits();
  }

  void loadUnits() {
    _loading.value = true;
    update();

    FirebaseService().getUnitsOfMeasurement().then((units) {
      _units.value = units
          .map<UnitOfMeasurement>((e) => UnitOfMeasurement.fromJson(e))
          .toList();
    });
    _loading.value = false;

    update();
  }

  Future<void> create(UnitOfMeasurement unit) async {
    try {
      await FirebaseService().createUnitOfMeasurement(unit);

      loadUnits();

      Get.back();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> delete(UnitOfMeasurement unit) async {
    try {
      await FirebaseService().deleteUnitOfMeasurement(unit);
      loadUnits();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
