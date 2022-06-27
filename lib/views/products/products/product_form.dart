// ignore: must_be_immutable
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/controllers/products_controller.dart';
import 'package:venda_sys/controllers/units_of_measurement_controller.dart';
import 'package:venda_sys/libraries/dropdown_decoration.dart';
import 'package:venda_sys/libraries/input_formatters/currency_input_formatter.dart';
import 'package:venda_sys/libraries/utils.dart';
import 'package:venda_sys/models/product.dart';
import 'package:venda_sys/models/unit_of_measurement.dart';
import 'package:venda_sys/views/widgets/custom_text_field.dart';
import 'package:venda_sys/views/widgets/loading_widget.dart';

// ignore: must_be_immutable
class ProductForm extends GetView<ProductsController> {
  Product? product;

  ProductForm({
    Key? key,
    this.product,
  }) : super(key: key);

  final formKey = GlobalKey<FormState>();
  bool firstOpen = true;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => UnitsOfMeasurementController());

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

    return Obx(
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

          if (product != null && firstOpen == true) {
            for (var unit in units) {
              if (unit.id == product!.unitOfMeasurement) {
                UnitsOfMeasurementController.to
                    .selectUnitId(product!.unitOfMeasurement);
                firstOpen = false;
              }
            }
          }

          if (product != null) {}

          return Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                  onChanged: (value) => productEdited.code = value,
                  initialValue: productEdited.code,
                  label: 'code'.tr,
                ),
                const SizedBox(height: Constants.defaultPadding),
                CustomTextField(
                  onChanged: (value) => productEdited.description = value,
                  initialValue: productEdited.description,
                  label: 'description'.tr,
                ),
                const SizedBox(height: Constants.defaultPadding),
                CustomTextField(
                  onChanged: (value) =>
                      productEdited.resumedDescription = value,
                  initialValue: productEdited.resumedDescription,
                  label: 'resumedDescription'.tr,
                ),
                const SizedBox(height: Constants.defaultPadding),
                CustomTextField(
                  onChanged: (value) =>
                      productEdited.quantity = int.parse(value),
                  initialValue: productEdited.quantity.toString(),
                  label: 'quantity'.tr,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const SizedBox(height: Constants.defaultPadding),
                CustomTextField(
                  onChanged: (value) =>
                      productEdited.buyingPrice = Utils.cleanMoney(value)!,
                  initialValue:
                      UtilBrasilFields.obterReal(productEdited.buyingPrice!),
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
                  initialValue:
                      UtilBrasilFields.obterReal(productEdited.buyingPrice!),
                  label: 'sellingPrice'.tr,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyInputFormatter()
                  ],
                ),
                const SizedBox(height: Constants.defaultPadding),
                CustomTextField(
                  onChanged: (value) => productEdited.ncm = value,
                  initialValue: productEdited.ncm,
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
                      child: Text(product == null ? 'register'.tr : 'edit'.tr),
                    ),
                  ],
                )
              ],
            ),
          );
        }
      },
    );
  }
}
