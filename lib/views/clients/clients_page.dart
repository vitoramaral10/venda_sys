import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed('/clients/register'),
          child: const Icon(FontAwesomeIcons.plus),
        ),
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
                            bool remove = false;

                            Utils.dialog(
                              title: 'Remover Cliente',
                              content: const Text(
                                'O cliente será removido permanentemente. Deseja continuar?',
                              ),
                              actionParams: {
                                'onConfirm': () async {
                                  await controller.delete(client);

                                  remove = true;
                                },
                                'onCancel': () => remove = false,
                              },
                            );
                            Get.back();

                            return remove;
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
