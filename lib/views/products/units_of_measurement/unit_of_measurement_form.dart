import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/controllers/units_of_measurement_controller.dart';
import 'package:venda_sys/models/unit_of_measurement.dart';
import 'package:venda_sys/views/widgets/custom_text_field.dart';

// ignore: must_be_immutable
class UnitsOfMeasurementForm extends GetView<UnitsOfMeasurementController> {
  UnitOfMeasurement? unitOfMeasurement;

  UnitsOfMeasurementForm({Key? key, this.unitOfMeasurement}) : super(key: key);

  final formKey = GlobalKey<FormState>();

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
          CustomTextField(
            onChanged: (value) => unitOfMeasurementEdited.description = value,
            initialValue: unitOfMeasurementEdited.description,
            label: 'description'.tr,
          ),
          const SizedBox(height: Constants.defaultPadding),
          CustomTextField(
            onChanged: (value) => unitOfMeasurementEdited.abbreviation = value,
            initialValue: unitOfMeasurementEdited.abbreviation,
            label: 'abbreviation'.tr,
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
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Constants.defaultPadding / 3),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (unitOfMeasurement != null) {
                      controller
                          .updateUnitOfMeasurement(unitOfMeasurementEdited);
                    } else {
                      controller.create(unitOfMeasurementEdited);
                    }
                  }
                },
                child:
                    Text(unitOfMeasurement == null ? 'register'.tr : 'edit'.tr),
              ),
            ],
          )
        ],
      ),
    );
  }
}
