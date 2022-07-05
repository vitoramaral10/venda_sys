import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/libraries/utils.dart';
import 'package:venda_sys/views/widgets/base_widget.dart';
import 'package:venda_sys/views/widgets/loading_widget.dart';

import '../../../controllers/units_of_measurement_controller.dart';
import 'unit_of_measurement_form.dart';

class UnitsOfMeasurementPage extends GetView<UnitsOfMeasurementController> {
  const UnitsOfMeasurementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseWidget(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Utils.dialog(
            title: 'units_of_measurement'.tr,
            content: UnitsOfMeasurementForm(),
          ),
          child: const Icon(FontAwesomeIcons.plus),
        ),
        child: controller.loading
            ? const LoadingWidget()
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.units.length,
                itemBuilder: (context, index) {
                  final unit = controller.units[index];

                  return Dismissible(
                    key: Key(unit.id.toString()),
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        bool remove = false;

                        Utils.dialog(
                          title: 'Remover Unidade de medida',
                          content: const Text(
                            'A unidade de medida será removida permanentemente. Deseja continuar?',
                          ),
                          actionParams: {
                            'onConfirm': () async {
                              await controller.delete(unit);

                              remove = true;
                              Get.back();
                            },
                            'onCancel': () {
                              remove = false;
                              Get.back();
                            },
                          },
                        );

                        return remove;
                      }

                      return null;
                    },
                    background: Card(
                      color: Colors.red,
                      child: Container(
                        padding: const EdgeInsets.all(Constants.defaultPadding),
                        alignment: Alignment.centerLeft,
                        child: const Icon(
                          FontAwesomeIcons.trash,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: Card(
                      child: InkWell(
                        onTap: () => Utils.dialog(
                          title: 'edit'.tr,
                          content: UnitsOfMeasurementForm(
                            unitOfMeasurement: unit,
                          ),
                        ),
                        child: ListTile(
                          title: Text(unit.description),
                          subtitle: Text(unit.abbreviation),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
