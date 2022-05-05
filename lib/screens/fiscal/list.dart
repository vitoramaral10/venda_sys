import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:venda_sys/bloc/fiscal_bloc.dart';
import 'package:venda_sys/components/base_widget.dart';
import 'package:venda_sys/components/error_popup.dart';
import 'package:venda_sys/functions/import_xml.dart';
import 'package:venda_sys/models/fiscal/nota_fiscal.dart';

class FiscalList extends StatelessWidget {
  FiscalList({Key? key}) : super(key: key);

  final f = DateFormat('dd/MM/yyy hh:mm');

  @override
  Widget build(BuildContext context) {
    BlocProvider.getBloc<FiscalBloc>().search();

    return BaseWidget(
      child: StreamBuilder(
        stream: BlocProvider.getBloc<FiscalBloc>().outNotaFiscal,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<NotaFiscal> fiscal = snapshot.data! as List<NotaFiscal>;

            fiscal.sort((a, b) => b.identificacao.dataEmissao
                .compareTo(a.identificacao.dataEmissao));

            return ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: fiscal.length,
              itemBuilder: (context, index) {
                return _listTile(index, fiscal[index], context);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ImportXml.importPopup(context);
        },
        child: const Icon(Icons.file_upload_outlined),
      ),
      title: 'Fiscal',
    );
  }

  Widget _listTile(int index, NotaFiscal nota, BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Dismissible(
          key: ValueKey<int>(index),
          direction: DismissDirection.startToEnd,
          confirmDismiss: (DismissDirection direction) async {
            if (direction == DismissDirection.startToEnd && !nota.cancelada) {
              final bool res = await _removePopup(context, nota);

              return res;
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
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(nota.identificacao.numeroNf.toString()),
              ],
            ),
            title: Row(
              children: [
                Text(
                  f.format(nota.identificacao.dataEmissao),
                  maxLines: 1,
                ),
                nota.cancelada
                    ? const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Chip(
                          label: Text(
                            'Cancelada',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      )
                    : Container(),
              ],
            ),
            subtitle: (nota.identificacao.tipo == 0)
                ? const Text('Nota de entrada')
                : const Text('Nota de saída'),
            trailing: Text('R\$ ${_corrigeValor(nota.total.vNF)}'),
          ),
        ),
      ),
    );
  }

  String _corrigeValor(dynamic valor) {
    return (valor != null) ? valor.toString() : '-';
  }

  _removePopup(BuildContext context, NotaFiscal nota) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text("Tem certeza que deseja cancelar essa nota?"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Cancelar",
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              ElevatedButton(
                child: const Text(
                  "Sim",
                ),
                onPressed: () async {
                  try {
                    await BlocProvider.getBloc<FiscalBloc>().cancel(nota.id);
                    Navigator.pop(context);
                  } catch (e) {
                    errorPopup(
                        context: context,
                        title: 'Erro desconhecido',
                        text: e.toString());
                  }
                },
              ),
            ],
          );
        });
  }
}
