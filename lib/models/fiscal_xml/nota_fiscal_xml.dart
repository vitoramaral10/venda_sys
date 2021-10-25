import 'destinatario.dart';
import 'emitente.dart';
import 'identificacao.dart';
import 'produto.dart';
import 'total.dart';

class NotaFiscalXML {
  final String id;
  final NotaFiscalXMLIdentificacao identificacao;
  final NotaFiscalXMLEmitente emitente;
  final NotaFiscalXMLDestinatario destinatario;
  final dynamic produtos;
  final NotaFiscalXMLTotal total;

  NotaFiscalXML(
    this.id,
    this.identificacao,
    this.emitente,
    this.destinatario,
    this.produtos,
    this.total,
  );

  NotaFiscalXML.fromJson(Map<String, dynamic> json)
      : id = json['ide']['cNF'],
        identificacao = NotaFiscalXMLIdentificacao.fromJson(json['ide']),
        emitente = NotaFiscalXMLEmitente.fromJson(json['emit']),
        destinatario = NotaFiscalXMLDestinatario.fromJson(json['dest']),
        produtos = (json['det'][0] != null)
            ? NotaFiscalXMLProduto.fromMap(json['det'])
            : [NotaFiscalXMLProduto.fromJson(json['det'])],
        total = NotaFiscalXMLTotal.fromJson(json['total']['ICMSTot']);

  Map<String, dynamic> toJson() => {
        'identificacao': identificacao.toJson(),
        'emitente': emitente.toJson(),
        'destinatario': destinatario.toJson(),
        'produtos': produtos.map((e) => e.toJson()).toList(),
        'total': total.toJson(),
      };
  static NotaFiscalXML empty = NotaFiscalXML(
    '',
    NotaFiscalXMLIdentificacao.empty,
    NotaFiscalXMLEmitente.empty,
    NotaFiscalXMLDestinatario.empty,
    [],
    NotaFiscalXMLTotal.empty,
  );
}
