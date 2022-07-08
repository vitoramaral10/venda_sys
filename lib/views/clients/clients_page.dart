import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:venda_sys/controllers/clients_controller.dart';
import 'package:venda_sys/models/client.dart';
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
                        Get.toNamed('/clients/view', arguments: client);
                      },
                      child: ListTile(
                        title: Text(
                          client.corporateName,
                          maxLines: 1,
                        ),
                        subtitle: Text(
                          UtilBrasilFields.obterCnpj(client.cnpj.toString()),
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
