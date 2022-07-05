import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/controllers/clients_controller.dart';
import 'package:venda_sys/models/client.dart';
import 'package:venda_sys/views/widgets/base_widget.dart';

class ClientView extends GetView<ClientsController> {
  final Client client = Get.arguments;

  ClientView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.middlePadding),
            ),
            child: Padding(
              padding: const EdgeInsets.all(Constants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Dados da Empresa',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: Constants.defaultPadding),
                  Row(
                    children: [
                      Expanded(
                        child: InfoField(
                          title: 'CNPJ:',
                          value: UtilBrasilFields.obterCnpj(client.cnpj),
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        child: InfoField(
                          title: 'Inscrição Estadual:',
                          value: client.ie,
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        child: InfoField(
                          title: 'Tipo de Pessoa:',
                          value: Constants.tiposPessoa[client.typePerson]!,
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        flex: Constants.flex2,
                        child: InfoField(
                          title: 'Razão Social:',
                          value: client.corporateName,
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        flex: Constants.flex2,
                        child: InfoField(
                          title: 'Nome Fantasia:',
                          value: client.fantasyName,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Constants.defaultPadding),
                  Row(
                    children: [
                      Expanded(
                        child: InfoField(
                          title: 'Email:',
                          value: client.email,
                        ),
                      ),
                      const SizedBox(height: Constants.defaultPadding),
                      client.phone.toString().length > Constants.phoneLength
                          ? Expanded(
                              child: InfoField(
                                title: 'Telefone:',
                                value: UtilBrasilFields.obterTelefone(
                                  client.phone.toString(),
                                ),
                              ),
                            )
                          : Container(),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        child: InfoField(
                          title: 'Contato:',
                          value: client.contact,
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        child: InfoField(
                          title: 'Comentário:',
                          value: client.comment,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Constants.defaultPadding),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.middlePadding),
            ),
            child: Padding(
              padding: const EdgeInsets.all(Constants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Endereço',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: Constants.defaultPadding),
                  Row(
                    children: [
                      Expanded(
                        child: InfoField(
                          title: 'CEP:',
                          value: client.address.cep,
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        flex: Constants.flex3,
                        child: InfoField(
                          title: 'Logradouro:',
                          value: client.address.street,
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        child: InfoField(
                          title: 'Número:',
                          value: client.address.number,
                        ),
                      ),
                      const SizedBox(height: Constants.defaultPadding),
                      Expanded(
                        flex: Constants.flex2,
                        child: InfoField(
                          title: 'Bairro:',
                          value: client.address.district,
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        flex: Constants.flex2,
                        child: InfoField(
                          title: 'Cidade:',
                          value: client.address.city,
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        flex: Constants.flex2,
                        child: InfoField(
                          title: 'Estado:',
                          value: client.address.uf,
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        flex: Constants.flex2,
                        child: InfoField(
                          title: 'Complemento:',
                          value: client.address.complement,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Constants.defaultPadding),
          // StreamBuilder<List<NotaFiscal>>(
          //   stream: _bloc.outNotaFiscalFiltered,
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return const LoadingWidget();
          //     }

          //     if (snapshot.data!.isEmpty) {
          //       return Container();
          //     }

          //     return Card(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(Constants.defaultPadding),
          //       ),
          //       elevation: 4,
          //       child: Padding(
          //         padding: const EdgeInsets.all(Constants.defaultPadding),
          //         child: ExpansionTile(
          //           title: const Text(
          //             'Notas emitidas',
          //             style: TextStyle(
          //               fontSize: 16,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //           children: [
          //             const Divider(),
          //             const SizedBox(height: Constants.defaultPadding),
          //             ListView.builder(
          //               shrinkWrap: true,
          //               physics: const NeverScrollableScrollPhysics(),
          //               itemCount: snapshot.data!.length,
          //               itemBuilder: (context, index) {
          //                 final notaFiscal = snapshot.data![index];
          //                 return ListTile(
          //                   leading: Column(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     crossAxisAlignment: CrossAxisAlignment.center,
          //                     children: [
          //                       Text(
          //                         notaFiscal.identificacao.numeroNf.toString(),
          //                         style: const TextStyle(
          //                           fontSize: 16,
          //                           fontWeight: FontWeight.bold,
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                   title: Text(
          //                     "${UtilData.obterDataDDMMAAAA(notaFiscal.identificacao.dataEmissao)} ${UtilData.obterHoraHHMM(notaFiscal.identificacao.dataEmissao)}",
          //                     style: const TextStyle(
          //                       fontSize: 16,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                   subtitle: Text(
          //                     "Quantidade de itens: ${notaFiscal.products.length}",
          //                     style: const TextStyle(
          //                       fontSize: 14,
          //                     ),
          //                   ),
          //                   trailing: Text(
          //                     "Valor Total: ${UtilBrasilFields.obterReal(notaFiscal.total.vNF)}",
          //                     style: const TextStyle(
          //                       fontSize: 16,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                   onTap: () {
          //                     Navigator.pushNamed(
          //                       context,
          //                       '/nota-fiscal',
          //                       arguments: notaFiscal,
          //                     );
          //                   },
          //                 );
          //               },
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}

class InfoField extends StatelessWidget {
  final String title;
  final String value;

  const InfoField({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
