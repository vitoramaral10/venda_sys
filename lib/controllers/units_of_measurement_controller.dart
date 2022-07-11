// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:get/get.dart';
import 'package:venda_sys/services/firebase_service.dart';

import '../models/unit_of_measurement.dart';

class UnitsOfMeasurementController extends GetxController {
  final _units = <UnitOfMeasurement>[].obs;
  final _loading = false.obs;
  final _selectedUnitId = ''.obs;

  static UnitsOfMeasurementController get to =>
      Get.find<UnitsOfMeasurementController>();
  List<UnitOfMeasurement> get units => _units.value;
  bool get loading => _loading.value;
  String get selectedUnitId => _selectedUnitId.value;

  selectUnitId(String value) => _selectedUnitId.value = value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadUnits();
  }

  Future<void> loadUnits() async {
    try {
      _loading.value = true;
      update();

      _units.value = await FirebaseService().getUnitsOfMeasurement();
      _loading.value = false;

      update();
    } catch (e) {
      log(e.toString(), name: 'createUnitOfMeasurement');
    }
  }

  Future<void> create(UnitOfMeasurement unit) async {
    try {
      await FirebaseService().createUnitOfMeasurement(unit);

      await loadUnits();
    } catch (e) {
      log(e.toString(), name: 'createUnitOfMeasurement');
      rethrow;
    }
  }

  Future<void> delete(UnitOfMeasurement unit) async {
    try {
      await FirebaseService().deleteUnitOfMeasurement(unit);
      await loadUnits();
    } catch (e) {
      log(e.toString(), name: 'deleteUnitOfMeasurement');
      rethrow;
    }
  }

  Future<void> updateUnitOfMeasurement(UnitOfMeasurement unit) async {
    try {
      await FirebaseService().updateUnitOfMeasurement(unit);

      await loadUnits();
    } catch (e) {
      log(e.toString(), name: 'updateUnitOfMeasurement');
      rethrow;
    }
  }
}
