import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/views/widgets/base_widget.dart';
import 'package:venda_sys/views/widgets/loading_widget.dart';

import '../../../controllers/units_of_measurement_controller.dart';

class UnitsOfMeasurementPage extends GetView<UnitsOfMeasurementController> {
  const UnitsOfMeasurementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: controller.loading
          ? const LoadingWidget()
          : Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemCount: controller.units.length,
                itemBuilder: (context, index) {
                  final unit = controller.units[index];

                  return Card(
                    child: ListTile(
                      title: Text(unit.description),
                      subtitle: Text(unit.abbreviation),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
