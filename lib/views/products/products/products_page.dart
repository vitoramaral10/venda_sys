import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/controllers/products_controller.dart';
import 'package:venda_sys/libraries/input_formatters/currency_input_formatter.dart';
import 'package:venda_sys/libraries/utils.dart';
import 'package:venda_sys/views/widgets/base_widget.dart';
import 'package:venda_sys/views/widgets/loading_widget.dart';

import '../../../controllers/units_of_measurement_controller.dart';
import '../../../libraries/dropdown_decoration.dart';
import '../../../models/product.dart';
import '../../../models/unit_of_measurement.dart';
import '../../widgets/custom_text_field.dart';

class ProductsPage extends GetView<ProductsController> {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseWidget(
        floatingActionButton: FloatingActionButton(
          onPressed: () => form(),
          child: const Icon(FontAwesomeIcons.plus),
        ),
        child: controller.loading
            ? const LoadingWidget()
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final Product product = controller.products[index];

                  return Dismissible(
                    key: Key(product.id.toString()),
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        return await Utils.dialog(
                          title: 'remove_unit_of_measurement'.tr,
                          content: Text(
                              'do_you_want_to_remove_this_unit_of_measurement'
                                  .tr),
                          onConfirm: () async {
                            try {
                              await controller.delete(product);
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
                      color: (product.quantity > 0)
                          ? Colors.white
                          : Colors.redAccent,
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              product.code,
                              style: TextStyle(
                                color: product.quantity < 0
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          product.description,
                          maxLines: 1,
                          style: TextStyle(
                            color: product.quantity < 0
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        subtitle: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Valor Compra: ${UtilBrasilFields.obterReal(product.buyingPrice!)}',
                              style: TextStyle(
                                color: product.quantity < 0
                                    ? Colors.white
                                    : Colors.black54,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Valor Venda: ${UtilBrasilFields.obterReal(product.sellingPrice!)}',
                              style: TextStyle(
                                color: product.quantity < 0
                                    ? Colors.white
                                    : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        trailing: Text(
                          '${product.quantity}',
                          style: TextStyle(
                            color: product.quantity < 0
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  form({Product? product}) {
    Get.lazyPut(() => UnitsOfMeasurementController());

    final formKey = GlobalKey<FormState>();

    Product? productEdited = product ??
        Product(
          buyingPrice: 0,
          code: '',
          description: '',
          ncm: '',
          quantity: 0,
          resumedDescription: '',
          sellingPrice: 0,
          unitOfMeasurement: '',
        );

    Utils.dialog(
      title: 'product'.tr,
      content: Obx(
        () {
          if (UnitsOfMeasurementController.to.loading) {
            return const LoadingWidget();
          } else {
            List<UnitOfMeasurement> units = [
              UnitOfMeasurement(
                id: '',
                abbreviation: '',
                description: 'select_one_unit_of_measurement'.tr,
              ),
            ];

            units.addAll(UnitsOfMeasurementController.to.units);

            return Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    onChanged: (value) => productEdited.code = value,
                    label: 'code'.tr,
                  ),
                  const SizedBox(height: Constants.defaultPadding),
                  CustomTextField(
                    onChanged: (value) => productEdited.description = value,
                    label: 'description'.tr,
                  ),
                  const SizedBox(height: Constants.defaultPadding),
                  CustomTextField(
                    onChanged: (value) =>
                        productEdited.resumedDescription = value,
                    label: 'resumedDescription'.tr,
                  ),
                  const SizedBox(height: Constants.defaultPadding),
                  CustomTextField(
                    onChanged: (value) =>
                        productEdited.quantity = int.parse(value),
                    label: 'quantity'.tr,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  const SizedBox(height: Constants.defaultPadding),
                  CustomTextField(
                    onChanged: (value) =>
                        productEdited.buyingPrice = Utils.cleanMoney(value)!,
                    label: 'buyingPrice'.tr,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter()
                    ],
                  ),
                  const SizedBox(height: Constants.defaultPadding),
                  CustomTextField(
                    onChanged: (value) =>
                        productEdited.sellingPrice = Utils.cleanMoney(value)!,
                    label: 'sellingPrice'.tr,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CurrencyInputFormatter()
                    ],
                  ),
                  const SizedBox(height: Constants.defaultPadding),
                  CustomTextField(
                    onChanged: (value) => productEdited.ncm = value,
                    label: 'ncm'.tr,
                  ),
                  const SizedBox(height: Constants.defaultPadding),
                  DropdownButtonFormField<String>(
                    decoration: DropdownDecoration.decoration(),
                    items: units
                        .map((profile) => DropdownMenuItem<String>(
                              value: profile.id,
                              child: Text(profile.description),
                            ))
                        .toList(),
                    value: UnitsOfMeasurementController.to.selectedUnitId,
                    onChanged: (value) {
                      UnitsOfMeasurementController.to.selectUnitId(value!);
                      productEdited.unitOfMeasurement = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'required_field'.tr;
                      }
                      return null;
                    },
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
                            borderRadius: BorderRadius.circular(
                                Constants.defaultPadding / 3),
                          ),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (product != null) {
                              controller.updateProduct(productEdited);
                            } else {
                              controller.create(productEdited);
                            }
                          }
                        },
                        child:
                            Text(product == null ? 'register'.tr : 'edit'.tr),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
