import 'destinatario.dart';
import 'emitente.dart';
import 'identificacao.dart';
import 'product.dart';
import 'total.dart';

class NotaFiscalXML {
  final String id;
  final NotaFiscalXMLIdentificacao identificacao;
  final NotaFiscalXMLEmitente emitente;
  final NotaFiscalXMLDestinatario destinatario;
  final dynamic products;
  final NotaFiscalXMLTotal total;

  NotaFiscalXML(
    this.id,
    this.identificacao,
    this.emitente,
    this.destinatario,
    this.products,
    this.total,
  );

  NotaFiscalXML.fromJson(Map<String, dynamic> json)
      : id = json['ide']['cNF'],
        identificacao = NotaFiscalXMLIdentificacao.fromJson(json['ide']),
        emitente = NotaFiscalXMLEmitente.fromJson(json['emit']),
        destinatario = NotaFiscalXMLDestinatario.fromJson(json['dest']),
        products = (json['det'][0] != null)
            ? NotaFiscalXMLProduct.fromMap(json['det'])
            : [NotaFiscalXMLProduct.fromJson(json['det'])],
        total = NotaFiscalXMLTotal.fromJson(json['total']['ICMSTot']);

  Map<String, dynamic> toJson() => {
        'identificacao': identificacao.toJson(),
        'emitente': emitente.toJson(),
        'destinatario': destinatario.toJson(),
        'products': products.map((e) => e.toJson()).toList(),
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
