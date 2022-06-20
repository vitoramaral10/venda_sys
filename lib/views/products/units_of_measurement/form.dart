import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/controllers/units_of_measurement_controller.dart';
import 'package:venda_sys/models/unit_of_measurement.dart';
import 'package:venda_sys/views/widgets/custom_text_field.dart';

class UnitsOfMeasurementForm {
  UnitsOfMeasurementForm();

  void show() {
    TextEditingController descriptionController = TextEditingController();
    TextEditingController abbreviationController = TextEditingController();

    Get.defaultDialog(
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
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('cancel'.tr),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.defaultPadding / 3),
            ),
          ),
          onPressed: () => UnitsOfMeasurementController.to.create(
            UnitOfMeasurement(
              description: descriptionController.text,
              abbreviation: abbreviationController.text,
            ),
          ),
          child: Text('save'.tr),
        ),
      ],
    );
  }
}
