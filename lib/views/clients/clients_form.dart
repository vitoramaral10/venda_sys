import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/controllers/clients_controller.dart';
import 'package:venda_sys/models/client.dart';
import 'package:venda_sys/views/widgets/base_widget.dart';
import 'package:venda_sys/views/widgets/custom_text_field.dart';
import 'package:venda_sys/views/widgets/dropdown_field.dart';

// ignore: must_be_immutable
class ClientsForm extends GetView<ClientsController> {
  Client? client;
  final _formKey = GlobalKey<FormState>();

  ClientsForm({Key? key, this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Client clientEdited = client ?? Client.empty();

    return BaseWidget(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constants.defaultPadding),
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
                          child: CustomTextField(
                            initialValue: clientEdited.cnpj,
                            onChanged: (value) => clientEdited.cnpj = value,
                            label: 'CNPJ',
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Campo obrigatório';
                              }
                              if (!UtilBrasilFields.isCNPJValido(value)) {
                                return 'CNPJ inválido';
                              }

                              return null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CnpjInputFormatter(),
                            ],
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          child: CustomTextField(
                            label: 'Inscrição Estadual',
                            initialValue: clientEdited.ie,
                            onChanged: (value) => clientEdited.ie = value,
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          child: DropdownField(
                            items: Constants.tiposPessoa,
                            value: clientEdited.typePerson,
                            onChanged: (value) {
                              clientEdited.typePerson = value!;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Constants.defaultPadding),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            initialValue: clientEdited.corporateName,
                            onChanged: (value) =>
                                clientEdited.corporateName = value,
                            label: 'Razão Social',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Campo obrigatório';
                              }

                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          child: CustomTextField(
                            initialValue: clientEdited.fantasyName,
                            onChanged: (value) =>
                                clientEdited.fantasyName = value,
                            label: 'Nome Fantasia',
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          child: CustomTextField(
                            initialValue: clientEdited.email,
                            onChanged: (value) => clientEdited.email = value,
                            label: 'Email',
                            validator: (value) {
                              if (!value!.contains('@')) {
                                return 'Email inválido';
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Constants.defaultPadding),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            initialValue: clientEdited.phone,
                            onChanged: (value) => clientEdited.phone = value,
                            label: 'Telefone',
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter(),
                            ],
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          child: CustomTextField(
                            initialValue: clientEdited.contact,
                            onChanged: (value) => clientEdited.contact = value,
                            label: 'Contato',
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          child: CustomTextField(
                            initialValue: clientEdited.comment,
                            onChanged: (value) => clientEdited.comment = value,
                            label: 'Comentário',
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
                borderRadius: BorderRadius.circular(Constants.defaultPadding),
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
                          flex: Constants.flex3,
                          child: CustomTextField(
                            initialValue: clientEdited.address.cep,
                            onChanged: (value) =>
                                clientEdited.address.cep = value,
                            label: 'CEP',
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CepInputFormatter(),
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Campo obrigatório';
                              }
                              var other = 10;
                              if (value.length != other) {
                                return 'CEP inválido';
                              }

                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          flex: Constants.flex7,
                          child: CustomTextField(
                            initialValue: clientEdited.address.street,
                            onChanged: (value) =>
                                clientEdited.address.street = value,
                            label: 'Logradouro',
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          flex: Constants.flex2,
                          child: CustomTextField(
                            initialValue: clientEdited.address.number,
                            onChanged: (value) =>
                                clientEdited.address.number = value,
                            label: 'Número',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Constants.defaultPadding),
                    Row(
                      children: [
                        Expanded(
                          flex: Constants.flex4,
                          child: CustomTextField(
                            initialValue: clientEdited.address.complement,
                            onChanged: (value) =>
                                clientEdited.address.complement = value,
                            label: 'Complemento',
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          flex: Constants.flex4,
                          child: CustomTextField(
                            initialValue: clientEdited.address.district,
                            onChanged: (value) =>
                                clientEdited.address.district = value,
                            label: 'Bairro',
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          flex: Constants.flex4,
                          child: CustomTextField(
                            initialValue: clientEdited.address.city,
                            onChanged: (value) =>
                                clientEdited.address.city = value,
                            label: 'Cidade',
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          flex: Constants.flex3,
                          child: DropdownField(
                            items: Constants.estados(),
                            value: clientEdited.address.uf,
                            onChanged: (value) {
                              clientEdited.address.uf = value!;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Constants.defaultPadding),
            Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                SizedBox(
                  height: Constants.buttonHeight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.defaultPadding),
                      ),
                    ),
                    onPressed: () {
                      try {
                        if (_formKey.currentState!.validate()) {
                          if (client == null) {
                            controller.create(clientEdited);
                          } else {
                            controller.updateClient(clientEdited);
                          }
                        }
                      } catch (e) {
                        Get.snackbar(
                          'error'.tr,
                          e.toString(),
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
