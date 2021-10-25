import 'dart:convert';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/fiscal_bloc.dart';
import 'package:venda_sys/components/error_popup.dart';
import 'package:venda_sys/models/fiscal_xml/nota_fiscal_xml.dart';
import 'package:xml2json/xml2json.dart';

class FiscalImport extends StatefulWidget {
  const FiscalImport({Key? key}) : super(key: key);

  @override
  State<FiscalImport> createState() => _FiscalImportState();
}

class _FiscalImportState extends State<FiscalImport> {
  int countInicial = 0;
  int countFinal = 0;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Importar XML'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  countInicial = 0;
                  countFinal = 0;
                  loading = true;
                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['xml'],
                  );

                  if (result != null) {
                    File file = File(result.files.single.path!);

                    String xml = await file.readAsString();

                    final myTransformer = Xml2Json();

                    myTransformer.parse(xml);

                    var json = myTransformer.toParker();
                    Map<String, dynamic> data = jsonDecode(json);

                    NotaFiscalXML nota = NotaFiscalXML.fromJson(data['nfeProc']['NFe']['infNFe']);

                    bool _imported = await BlocProvider.getBloc<FiscalBloc>().importXML(context, nota);

                    if (_imported) {
                      Navigator.pop(context);
                    } else {
                      errorPopup(
                        context: context,
                        title: 'Erro ao importar',
                        text: 'Ocorreu um erro ao importar a nota, tente novamente',
                      );
                    }
                    file.delete();
                  } else {
                    // User canceled the picker
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Buscar arquivo'),
                )),
            loading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Fiscal importados:'),
                  )
                : Container(),
            loading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('$countFinal de $countInicial'),
                  )
                : Container(),
            loading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      value: (countInicial / 100) * countFinal - 1,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
