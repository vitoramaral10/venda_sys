import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:venda_sys/bloc/fiscal_bloc.dart';
import 'package:venda_sys/components/error_popup.dart';
import 'package:venda_sys/models/fiscal_xml/nota_fiscal_xml.dart';
import 'package:xml2json/xml2json.dart';

class ImportXml {
  static void importPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Importar XML'),
            content: ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['xml'],
                  );

                  if (result != null) {
                    Uint8List? uploadfile = result.files.single.bytes;

                    String xml = String.fromCharCodes(uploadfile!);

                    final myTransformer = Xml2Json();

                    myTransformer.parse(xml);

                    var json = myTransformer.toParker();
                    Map<String, dynamic> data = jsonDecode(json);

                    NotaFiscalXML nota = NotaFiscalXML.fromJson(
                        data['nfeProc']['NFe']['infNFe']);

                    final _imported = await BlocProvider.getBloc<FiscalBloc>()
                        .importXML(context, nota);

                    if (_imported == 'ok') {
                      Navigator.pop(context);
                    } else {
                      String _text = (_imported == 'duplicated')
                          ? 'Esta nota já foi importada anteriormente!'
                          : 'Ocorreu um erro ao importar a nota, tente novamente';
                      errorPopup(
                        context: context,
                        title: 'Erro ao importar',
                        text: _text,
                      );
                    }
                  } else {
                    // User canceled the picker
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Buscar arquivo'),
                )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Sair")),
            ],
          );
        });
  }
}
