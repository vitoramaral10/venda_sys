import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/controllers/units_of_measurement_controller.dart';
import 'package:venda_sys/libraries/utils.dart';
import 'package:venda_sys/models/unit_of_measurement.dart';

// ignore: must_be_immutable
class UnitsOfMeasurementForm extends GetView<UnitsOfMeasurementController> {
  UnitOfMeasurement? unitOfMeasurement;
  final formKey = GlobalKey<FormState>();

  UnitsOfMeasurementForm({Key? key, this.unitOfMeasurement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UnitOfMeasurement? unitOfMeasurementEdited = unitOfMeasurement ??
        UnitOfMeasurement(
          description: '',
          abbreviation: '',
        );

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) => unitOfMeasurementEdited.description = value,
            initialValue: unitOfMeasurementEdited.description,
            decoration: InputDecoration(
              labelText: 'description'.tr,
            ),
          ),
          const SizedBox(height: Constants.defaultPadding),
          TextFormField(
            onChanged: (value) => unitOfMeasurementEdited.abbreviation = value,
            initialValue: unitOfMeasurementEdited.abbreviation,
            decoration: InputDecoration(
              labelText: 'abbreviation'.tr,
            ),
          ),
          const SizedBox(
            height: Constants.defaultPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'cancel'.tr,
                ),
              ),
              const SizedBox(width: Constants.defaultPadding),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      Get.back();
                      Utils.loading();

                      if (unitOfMeasurement != null) {
                        await controller
                            .updateUnitOfMeasurement(unitOfMeasurementEdited);
                      } else {
                        await controller.create(unitOfMeasurementEdited);
                      }

                      Get.back();
                    } catch (e) {
                      Get.back();
                      Utils.dialog();
                    }
                  }
                },
                child:
                    Text(unitOfMeasurement == null ? 'register'.tr : 'edit'.tr),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
