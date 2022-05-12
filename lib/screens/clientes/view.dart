import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/fiscal_bloc.dart';
import 'package:venda_sys/components/base_widget.dart';
import 'package:venda_sys/components/carregando_widget.dart';
import 'package:venda_sys/components/voltar_button.dart';
import 'package:venda_sys/libraries/constants.dart';
import 'package:venda_sys/models/cliente/cliente.dart';
import 'package:venda_sys/models/fiscal/nota_fiscal.dart';

class ClientesView extends StatelessWidget {
  final Cliente cliente;
  final FiscalBloc _bloc = BlocProvider.getBloc<FiscalBloc>();

  ClientesView({Key? key, required this.cliente}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _bloc.searchByCnpj(cliente.cnpj);

    return BaseWidget(
      title: 'Dados do cliente',
      child: Column(
        children: [
          const VoltarButton(),
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
                        child: InfoField(
                          title: 'CNPJ:',
                          value: UtilBrasilFields.obterCnpj(cliente.cnpj),
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        child: InfoField(
                          title: 'Inscrição Estadual:',
                          value: cliente.ie,
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        child: InfoField(
                          title: 'Tipo de Pessoa:',
                          value: Constants.tiposPessoa[cliente.tipoPessoa]!,
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        flex: 2,
                        child: InfoField(
                          title: 'Razão Social:',
                          value: cliente.razaoSocial,
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        flex: 2,
                        child: InfoField(
                          title: 'Nome Fantasia:',
                          value: cliente.nomeFantasia,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Constants.defaultPadding),
                  Row(
                    children: [
                      cliente.emails!.isNotEmpty
                          ? Expanded(
                              child: InfoField(
                                title: 'Email:',
                                value: cliente.emails![0].email,
                              ),
                            )
                          : Container(),
                      const SizedBox(height: Constants.defaultPadding),
                      cliente.telefone.toString().length > 9
                          ? Expanded(
                              child: InfoField(
                                title: 'Telefone:',
                                value: UtilBrasilFields.obterTelefone(
                                  cliente.telefone.toString(),
                                ),
                              ),
                            )
                          : Container(),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        child: InfoField(
                          title: 'Contato:',
                          value: cliente.contato,
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        child: InfoField(
                          title: 'Comentário:',
                          value: cliente.comentario,
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
                        child: InfoField(
                          title: 'CEP:',
                          value: UtilBrasilFields.obterCep(
                              cliente.endereco.cep.toString()),
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        flex: 3,
                        child: InfoField(
                          title: 'Logradouro:',
                          value: cliente.endereco.logradouro,
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        child: InfoField(
                          title: 'Número:',
                          value: cliente.endereco.numero,
                        ),
                      ),
                      const SizedBox(height: Constants.defaultPadding),
                      Expanded(
                        flex: 2,
                        child: InfoField(
                          title: 'Bairro:',
                          value: cliente.endereco.bairro,
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        flex: 2,
                        child: InfoField(
                          title: 'Cidade:',
                          value: cliente.endereco.municipio,
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        flex: 2,
                        child: InfoField(
                          title: 'Estado:',
                          value: cliente.endereco.uf,
                        ),
                      ),
                      const SizedBox(width: Constants.defaultPadding),
                      Expanded(
                        flex: 2,
                        child: InfoField(
                          title: 'Complemento:',
                          value: cliente.endereco.complemento,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Constants.defaultPadding),
          StreamBuilder<List<NotaFiscal>>(
            stream: _bloc.outNotaFiscalFiltered,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CarregandoWidget();
              }

              if (snapshot.data!.isEmpty) {
                return Container();
              }

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Constants.defaultPadding),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(Constants.defaultPadding),
                  child: ExpansionTile(
                    textColor: Constants.primary,
                    iconColor: Constants.primary,
                    title: const Text(
                      'Notas emitidas',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      const Divider(
                        color: Constants.primary,
                      ),
                      const SizedBox(height: Constants.defaultPadding),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final notaFiscal = snapshot.data![index];
                          return ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  notaFiscal.identificacao.numeroNf.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            title: Text(
                              UtilData.obterDataDDMMAAAA(
                                      notaFiscal.identificacao.dataEmissao) +
                                  " " +
                                  UtilData.obterHoraHHMM(
                                      notaFiscal.identificacao.dataEmissao),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              "Quantidade de itens: " +
                                  notaFiscal.produtos.length.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            trailing: Text(
                              "Valor Total: " +
                                  UtilBrasilFields.obterReal(
                                      notaFiscal.total.vNF),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/nota-fiscal',
                                arguments: notaFiscal,
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
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
