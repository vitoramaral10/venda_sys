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
import 'package:venda_sys/views/widgets/loading_widget.dart';

// ignore: must_be_immutable
class ProductForm extends GetView<ProductsController> {
  Product? product;
  final formKey = GlobalKey<FormState>();
  bool firstOpen = true;

  ProductForm({
    Key? key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

          if (product != null && firstOpen) {
            for (var unit in units) {
              if (unit.id == product!.unitOfMeasurement) {
                UnitsOfMeasurementController.to
                    .selectUnitId(product!.unitOfMeasurement);
                firstOpen = false;
              }
            }
          }

          return Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) => productEdited.code = value,
                  initialValue: productEdited.code,
                  decoration: InputDecoration(
                    labelText: 'reference'.tr,
                  ),
                ),
                const SizedBox(height: Constants.defaultPadding),
                TextFormField(
                  onChanged: (value) => productEdited.description = value,
                  initialValue: productEdited.description,
                  decoration: InputDecoration(
                    labelText: 'description'.tr,
                  ),
                ),
                const SizedBox(height: Constants.defaultPadding),
                TextFormField(
                  onChanged: (value) =>
                      productEdited.resumedDescription = value,
                  initialValue: productEdited.resumedDescription,
                  decoration: InputDecoration(
                    labelText: 'resumed_description'.tr,
                  ),
                ),
                const SizedBox(height: Constants.defaultPadding),
                TextFormField(
                  onChanged: (value) =>
                      productEdited.quantity = int.parse(value),
                  initialValue: productEdited.quantity.toString(),
                  decoration: InputDecoration(
                    labelText: 'quantity'.tr,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const SizedBox(height: Constants.defaultPadding),
                TextFormField(
                  onChanged: (value) =>
                      productEdited.buyingPrice = Utils.cleanMoney(value)!,
                  initialValue:
                      UtilBrasilFields.obterReal(productEdited.buyingPrice!),
                  decoration: InputDecoration(
                    labelText: 'buying_price'.tr,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyInputFormatter(),
                  ],
                ),
                const SizedBox(height: Constants.defaultPadding),
                TextFormField(
                  onChanged: (value) =>
                      productEdited.sellingPrice = Utils.cleanMoney(value)!,
                  initialValue:
                      UtilBrasilFields.obterReal(productEdited.buyingPrice!),
                  decoration: InputDecoration(
                    labelText: 'selling_price'.tr,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyInputFormatter(),
                  ],
                ),
                const SizedBox(height: Constants.defaultPadding),
                TextFormField(
                  onChanged: (value) => productEdited.ncm = value,
                  initialValue: productEdited.ncm,
                  decoration: InputDecoration(
                    labelText: 'ncm'.tr,
                  ),
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
                            Constants.smallButtonRadius,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            Utils.loading();

                            if (product != null) {
                              await controller.updateProduct(productEdited);
                            } else {
                              await controller.create(productEdited);
                            }

                            Get.back();
                            Get.back();
                          } catch (e) {
                            Utils.dialog();
                          }
                        }
                      },
                      child: Text(product == null ? 'register'.tr : 'edit'.tr),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
