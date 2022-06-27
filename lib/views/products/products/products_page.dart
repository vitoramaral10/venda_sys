import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/controllers/products_controller.dart';
import 'package:venda_sys/libraries/utils.dart';
import 'package:venda_sys/views/widgets/base_widget.dart';
import 'package:venda_sys/views/widgets/loading_widget.dart';

import '../../../models/product.dart';
import 'product_form.dart';

class ProductsPage extends GetView<ProductsController> {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseWidget(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Utils.dialog(
            title: 'product'.tr,
            content: ProductForm(),
          ),
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
}
