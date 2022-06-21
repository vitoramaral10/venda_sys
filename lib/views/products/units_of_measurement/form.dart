import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/controllers/units_of_measurement_controller.dart';
import 'package:venda_sys/libraries/utils.dart';
import 'package:venda_sys/models/unit_of_measurement.dart';
import 'package:venda_sys/views/widgets/custom_text_field.dart';

class UnitsOfMeasurementForm {
  UnitsOfMeasurementForm();

  void show() {
    TextEditingController descriptionController = TextEditingController();
    TextEditingController abbreviationController = TextEditingController();

    Utils.dialog(
      title: 'units_of_measurement'.tr,
      content: Column(
        children: [
          CustomTextField(
            controller: descriptionController,
            label: 'description'.tr,
          ),
          const SizedBox(height: Constants.defaultPadding),
          CustomTextField(
            controller: abbreviationController,
            label: 'abbreviation'.tr,
          ),
        ],
      ),
      onCancel: () => Get.back(),
      onConfirm: () => UnitsOfMeasurementController.to.create(
        UnitOfMeasurement(
          description: descriptionController.text,
          abbreviation: abbreviationController.text,
        ),
      ),
      cancelText: 'cancel'.tr,
      confirmText: 'save'.tr,
    );
  }
}
