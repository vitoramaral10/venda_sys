import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/libraries/utils.dart';
import 'package:venda_sys/views/widgets/base_widget.dart';
import 'package:venda_sys/views/widgets/loading_widget.dart';

import '../../../controllers/units_of_measurement_controller.dart';
import 'form.dart';

class UnitsOfMeasurementPage extends GetView<UnitsOfMeasurementController> {
  const UnitsOfMeasurementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
              () => BaseWidget(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          UnitsOfMeasurementForm().show();
        },
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
                        return await Utils.dialog(
                          title: 'remove_unit_of_measurement'.tr,
                          content: Text(
                              'do_you_want_to_remove_this_unit_of_measurement'
                                  .tr),
                          onConfirm: () async {
                            try {
                              await controller.delete(unit);
                              Get.back();
                            } catch (e) {
                              if (e is Exception) {
                                Get.snackbar(
                                  'error'.tr,
                                  e.toString(),
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            }
                          },
                          onCancel: () => Get.back(),
                          confirmText: 'remove'.tr,
                          cancelText: 'cancel'.tr,
                        );
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
                      child: ListTile(
                        title: Text(unit.description),
                        subtitle: Text(unit.abbreviation),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
