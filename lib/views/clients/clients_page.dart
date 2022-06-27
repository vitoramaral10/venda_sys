import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/controllers/clients_controller.dart';
import 'package:venda_sys/libraries/utils.dart';
import 'package:venda_sys/models/client.dart';
import 'package:venda_sys/views/clients/client_view.dart';
import 'package:venda_sys/views/widgets/base_widget.dart';
import 'package:venda_sys/views/widgets/loading_widget.dart';

class ClientsPage extends GetView<ClientsController> {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseWidget(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => Utils.dialog(
        //     title: 'client'.tr,
        //     content: ClientForm(),
        //   ),
        //   child: const Icon(FontAwesomeIcons.plus),
        // ),
        child: controller.loading
            ? const LoadingWidget()
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.clients.length,
                itemBuilder: (context, index) {
                  final Client client = controller.clients[index];

                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClientView(
                              client: client,
                            ),
                          ),
                        );
                      },
                      child: Dismissible(
                        key: ValueKey<int>(index),
                        direction: DismissDirection.startToEnd,
                        confirmDismiss: (DismissDirection direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            return await Utils.dialog(
                              title: 'remove_unit_of_measurement'.tr,
                              content: Text(
                                  'do_you_want_to_remove_this_unit_of_measurement'
                                      .tr),
                              onConfirm: () async {
                                try {
                                  await controller.delete(client);
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
                        background: Container(
                          alignment: AlignmentDirectional.centerStart,
                          color: Colors.red,
                          child: const Padding(
                            padding: EdgeInsets.only(left: 16.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            client.corporateName,
                            maxLines: 1,
                          ),
                          subtitle: Text(
                            UtilBrasilFields.obterCnpj(client.cnpj.toString()),
                            maxLines: 1,
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
