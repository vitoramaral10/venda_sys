import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:venda_sys/bloc/clientes_bloc.dart';
import 'package:venda_sys/components/base_widget.dart';
import 'package:venda_sys/components/custom_text_field.dart';
import 'package:venda_sys/components/dropdown_field.dart';
import 'package:venda_sys/libraries/constants.dart';
import 'package:venda_sys/models/cliente/cliente.dart';
import 'package:venda_sys/models/cliente/email.dart';
import 'package:venda_sys/models/cliente/endereco.dart';

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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _contatoController = TextEditingController();
  final TextEditingController _comentarioController = TextEditingController();

  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();

  String _tipoPessoa = 'J';
  String _estado = '-';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
        title: 'Novo Cliente',
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Constants.defaultPadding),
                ),
                elevation: 4,
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
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Campo obrigatório';
                                }
                                return null;
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CnpjInputFormatter()
                              ],
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
                              items: Constants.tiposPessoa,
                              value: _tipoPessoa,
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
                          const SizedBox(width: Constants.defaultPadding),
                          Expanded(
                              child: CustomTextField(
                            label: 'Email',
                            controller: _emailController,
                            validator: (value) {
                              if (!value!.contains('@')) {
                                return 'Email inválido';
                              }
                              return null;
                            },
                          )),
                        ],
                      ),
                      const SizedBox(height: Constants.defaultPadding),
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextField(
                            label: 'Telefone',
                            controller: _telefoneController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              TelefoneInputFormatter()
                            ],
                          )),
                          const SizedBox(width: Constants.defaultPadding),
                          Expanded(
                              child: CustomTextField(
                            label: 'Contato',
                            controller: _contatoController,
                          )),
                          const SizedBox(width: Constants.defaultPadding),
                          Expanded(
                              child: CustomTextField(
                            label: 'Comentário',
                            controller: _comentarioController,
                          )),
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
                elevation: 4,
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
                      const Divider(
                        color: Constants.primary,
                      ),
                      const SizedBox(height: Constants.defaultPadding),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CustomTextField(
                              label: 'CEP',
                              controller: _cepController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CepInputFormatter()
                              ],
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
                            flex: 7,
                            child: CustomTextField(
                              label: 'Logradouro',
                              controller: _logradouroController,
                            ),
                          ),
                          const SizedBox(width: Constants.defaultPadding),
                          Expanded(
                            flex: 2,
                            child: CustomTextField(
                              label: 'Número',
                              controller: _numeroController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Constants.defaultPadding),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: CustomTextField(
                              label: 'Complemento',
                              controller: _complementoController,
                            ),
                          ),
                          const SizedBox(width: Constants.defaultPadding),
                          Expanded(
                            flex: 4,
                            child: CustomTextField(
                              label: 'Bairro',
                              controller: _bairroController,
                            ),
                          ),
                          const SizedBox(width: Constants.defaultPadding),
                          Expanded(
                            flex: 4,
                            child: CustomTextField(
                              label: 'Cidade',
                              controller: _cidadeController,
                            ),
                          ),
                          const SizedBox(width: Constants.defaultPadding),
                          Expanded(
                            flex: 3,
                            child: DropdownField(
                              items: Constants.estados,
                              value: _estado,
                              onChanged: (value) {
                                setState(() {
                                  _estado = value!;
                                });
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
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Constants.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(Constants.defaultPadding),
                        ),
                      ),
                      onPressed: () {
                        _salvar();
                      },
                      child: const Text(
                        'Salvar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  _salvar() {
    if (_formKey.currentState!.validate()) {
      Cliente _cliente = Cliente(
        '',
        _cnpjController.text
            .replaceAll('.', '')
            .replaceAll('/', '')
            .replaceAll('-', ''),
        _razaoSocialController.text,
        _nomeFantasiaController.text,
        _ieController.text,
        [
          ClienteEndereco(
            _logradouroController.text,
            _numeroController.text,
            _bairroController.text,
            0,
            _cidadeController.text,
            _estado,
            int.parse(
                _cepController.text.replaceAll('-', '').replaceAll('.', '')),
            0,
            'Brasil',
            '',
          ),
        ],
        'J',
        [
          ClienteEmail(
            _emailController.text,
            true,
          ),
        ],
        int.parse(_telefoneController.text
            .replaceAll('(', '')
            .replaceAll(')', '')
            .replaceAll('-', '')
            .replaceAll(' ', '')),
        _contatoController.text,
        _comentarioController.text,
      );

      BlocProvider.getBloc<ClientesBloc>().save(_cliente);

      Navigator.pop(context);
    }
  }
}
