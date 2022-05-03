import 'package:flutter/material.dart';
import 'package:venda_sys/components/base_widget.dart';
import 'package:venda_sys/components/custom_text_field.dart';
import 'package:venda_sys/components/dropdown_field.dart';
import 'package:venda_sys/libraries/constants.dart';

class ClientesForm extends StatefulWidget {
  const ClientesForm({Key? key}) : super(key: key);

  @override
  State<ClientesForm> createState() => _ClientesFormState();
}

class _ClientesFormState extends State<ClientesForm> {
  final TextEditingController _cnpjController = TextEditingController();

  final TextEditingController _ieController = TextEditingController();

  final TextEditingController _razaoSocialController = TextEditingController();

  final TextEditingController _nomeFantasiaController = TextEditingController();

  String _tipoPessoa = 'F';

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        title: 'Novo Cliente',
        child: Column(
          children: [
            Card(
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
                    const Divider(
                      color: Constants.primary,
                    ),
                    const SizedBox(height: Constants.defaultPadding),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: 'CNPJ',
                            controller: _cnpjController,
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          child: CustomTextField(
                            label: 'Inscrição Estadual',
                            controller: _ieController,
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          child: DropdownField(
                            items: const {
                              'F': 'Física',
                              'J': 'Jurídica',
                            },
                            value: 'F',
                            onChanged: (value) {
                              setState(() {
                                _tipoPessoa = value!;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: Constants.defaultPadding),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: 'Razão Social',
                            controller: _razaoSocialController,
                          ),
                        ),
                        const SizedBox(width: Constants.defaultPadding),
                        Expanded(
                          child: CustomTextField(
                            label: 'Nome Fantasia',
                            controller: _nomeFantasiaController,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
