import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:venda_sys/bloc/fiscal_bloc.dart';
import 'package:venda_sys/models/fiscal/nota_fiscal.dart';

import 'import.dart';

class FiscalList extends StatelessWidget {
  const FiscalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.getBloc<FiscalBloc>().search();

    return Scaffold(
      appBar: AppBar(
        title: Text('Fiscal'),
      ),
      body: StreamBuilder(
        stream: BlocProvider.getBloc<FiscalBloc>().outFiscal,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<NotaFiscal> fiscal = snapshot.data! as List<NotaFiscal>;

            fiscal.sort((a, b) => b.identificacao.dataEmissao.compareTo(a.identificacao.dataEmissao));

            return ListView.builder(
              padding: EdgeInsets.only(bottom: 80),
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
          Navigator.push(context, MaterialPageRoute(builder: (context) => FiscalImport()));
        },
        child: Icon(Icons.file_upload_outlined),
      ),
    );
  }

  Widget _listTile(int index, NotaFiscal fiscal, BuildContext context) {
    final f = new DateFormat('dd/MM/yyy hh:mm');

    return Card(
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(fiscal.identificacao.numeroNf.toString()),
          ],
        ),
        title: Text(
          f.format(fiscal.identificacao.dataEmissao),
          maxLines: 1,
        ),
        subtitle: (fiscal.identificacao.tipo == 0) ? Text('Nota de entrada') : Text('Nota de saída'),
        trailing: Text('R\$ ${_corrigeValor(fiscal.total.vNF)}'),
      ),
    );
  }

  String _corrigeValor(dynamic valor) {
    return (valor != null) ? valor.toString() : '-';
  }
}
