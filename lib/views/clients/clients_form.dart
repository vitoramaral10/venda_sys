import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:search_cep/search_cep.dart';
import 'package:venda_sys/config/constants.dart';
import 'package:venda_sys/controllers/clients_controller.dart';
import 'package:venda_sys/libraries/utils.dart';
import 'package:venda_sys/models/client.dart';
import 'package:venda_sys/views/widgets/base_widget.dart';

// ignore: must_be_immutable
class ClientsForm extends GetView<ClientsController> {
  Client? client;
  final _formKey = GlobalKey<FormState>();
  final _postalCodeController = TextEditingController();
  final _addressController = TextEditingController();
  final _numberController = TextEditingController();
  final _complementController = TextEditingController();
  final _districtController = TextEditingController();
  final _cityController = TextEditingController();
  final _numberFocus = FocusNode();

  ClientsForm({Key? key, this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Client clientEdited = client ?? Client.empty();

    _postalCodeController.text = clientEdited.address.cep;
    _addressController.text = clientEdited.address.street;
    _numberController.text = clientEdited.address.number;
    _complementController.text = clientEdited.address.complement;
    _districtController.text = clientEdited.address.district;
    _cityController.text = clientEdited.address.city;
    controller.state = clientEdited.address.uf;

    return BaseWidget(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(Constants.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Dados da Empresa',
                      style: Get.textTheme.headline4,
                    ),
                    const Divider(),
                    const SizedBox(height: Constants.defaultPadding),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: clientEdited.cnpj,
                            onChanged: (value) => clientEdited.cnpj = value,
                            decoration:
                                const InputDecoration(labelText: 'CNPJ'),
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
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Inscrição Estadual',
                            ),
                            initialValue: clientEdited.ie,
                            onChanged: (value) => clientEdited.ie = value,
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            items: Constants.tiposPessoa
                                .map((tipoPessoa) => DropdownMenuItem<String>(
                                      value: tipoPessoa['key'],
                                      child: Text(tipoPessoa['value']!),
                                    ))
                                .toList(),
                            value: clientEdited.typePerson,
                            onChanged: (value) {
                              clientEdited.typePerson = value!;
                            },
                            validator: (value) {
                              return (value!.isEmpty)
                                  ? 'required_field'.tr
                                  : null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Constants.defaultPadding),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: clientEdited.corporateName,
                            onChanged: (value) =>
                                clientEdited.corporateName = value,
                            decoration: const InputDecoration(
                              labelText: 'Razão Social',
                            ),
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
                          child: TextFormField(
                            initialValue: clientEdited.fantasyName,
                            onChanged: (value) =>
                                clientEdited.fantasyName = value,
                            decoration: const InputDecoration(
                              labelText: 'Nome Fantasia',
                            ),
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          child: TextFormField(
                            initialValue: clientEdited.email,
                            onChanged: (value) => clientEdited.email = value,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                            ),
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
                          child: TextFormField(
                            initialValue: clientEdited.phone,
                            onChanged: (value) => clientEdited.phone = value,
                            decoration: const InputDecoration(
                              labelText: 'Telefone',
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter(),
                            ],
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          child: TextFormField(
                            initialValue: clientEdited.contact,
                            onChanged: (value) => clientEdited.contact = value,
                            decoration: const InputDecoration(
                              labelText: 'Contato',
                            ),
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          child: TextFormField(
                            initialValue: clientEdited.comment,
                            onChanged: (value) => clientEdited.comment = value,
                            decoration: const InputDecoration(
                              labelText: 'Comentário',
                            ),
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
              child: Padding(
                padding: const EdgeInsets.all(Constants.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Endereço', style: Get.textTheme.headline3),
                    const Divider(),
                    const SizedBox(height: Constants.defaultPadding),
                    Row(
                      children: [
                        Expanded(
                          flex: Constants.flex2,
                          child: TextFormField(
                            controller: _postalCodeController,
                            decoration: const InputDecoration(labelText: 'CEP'),
                            keyboardType: TextInputType.number,
                            onChanged: _searchCEP,
                            inputFormatters: [
                              // obrigatório
                              FilteringTextInputFormatter.digitsOnly,
                              CepInputFormatter(),
                            ],
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return (value!.isEmpty)
                                  ? 'required_field'.tr
                                  : null;
                            },
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          flex: Constants.flex4,
                          child: TextFormField(
                            controller: _addressController,
                            decoration:
                                const InputDecoration(labelText: 'Logradouro'),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return (value!.isEmpty)
                                  ? 'required_field'.tr
                                  : null;
                            },
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          flex: Constants.flex2,
                          child: TextFormField(
                            controller: _numberController,
                            focusNode: _numberFocus,
                            decoration:
                                const InputDecoration(labelText: 'Número'),
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          flex: Constants.flex4,
                          child: TextFormField(
                            controller: _complementController,
                            decoration:
                                const InputDecoration(labelText: 'Complemento'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Constants.defaultPadding),
                    Row(
                      children: [
                        Expanded(
                          flex: Constants.flex5,
                          child: TextFormField(
                            controller: _districtController,
                            decoration:
                                const InputDecoration(labelText: 'Bairro'),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return (value!.isEmpty)
                                  ? 'required_field'.tr
                                  : null;
                            },
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          flex: Constants.flex5,
                          child: TextFormField(
                            controller: _cityController,
                            decoration:
                                const InputDecoration(labelText: 'Cidade'),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return (value!.isEmpty)
                                  ? 'required_field'.tr
                                  : null;
                            },
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          flex: Constants.flex2,
                          child: Obx(
                            () => DropdownButtonFormField<String>(
                              hint: const Text('UF'),
                              onChanged: (regiaoSelecionada) {
                                clientEdited.address.uf = regiaoSelecionada!;
                              },
                              value: (Estados.listaEstadosSigla
                                      .contains(controller.state))
                                  ? controller.state
                                  : null,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                return (value!.isEmpty)
                                    ? 'required_field'.tr
                                    : null;
                              },
                              items: Estados.listaEstadosSigla
                                  .map((String regiao) {
                                return DropdownMenuItem(
                                  value: regiao,
                                  child: Text(regiao),
                                );
                              }).toList(),
                            ),
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
                ElevatedButton(
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
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _searchCEP(value) async {
    var other = 10;

    if (value.length == other) {
      try {
        Utils.loading();

        final infoCepJSON = await ViaCepSearchCep().searchInfoByCep(
          cep: value.replaceAll('.', '').replaceAll('-', ''),
        );

        infoCepJSON.fold((_) => null, (data) {
          _cityController.text = data.localidade!;
          _districtController.text = data.bairro!;
          _addressController.text = data.logradouro!;
          controller.state = data.uf ?? 'SP';
          _complementController.text = data.complemento!;
          _numberController.text = '';

          _numberFocus.requestFocus();
        });

        Get.back();
      } catch (e) {
        _postalCodeController.text = '';
        _cityController.text = '';
        _districtController.text = '';
        _addressController.text = '';
        controller.state = 'SP';
        _complementController.text = '';
        _numberController.text = '';

        Get.back();

        Utils.dialog(
          title: 'CEP Inválido',
          content: Column(
            children: [
              const Text(
                'Por favor revise a informação.',
              ),
              const SizedBox(
                height: Constants.defaultPadding,
              ),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }
}
