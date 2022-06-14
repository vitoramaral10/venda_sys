import 'destinatario.dart';
import 'emitente.dart';
import 'identificacao.dart';
import 'product.dart';
import 'total.dart';

class NotaFiscal {
  final String id;
  final NotaFiscalIdentificacao identificacao;
  final NotaFiscalEmitente emitente;
  final NotaFiscalDestinatario destinatario;
  final List<NotaFiscalProduct> products;
  final NotaFiscalTotal total;
  final bool cancelada;

  NotaFiscal(
    this.id,
    this.identificacao,
    this.emitente,
    this.destinatario,
    this.products,
    this.total,
    this.cancelada,
  );

  NotaFiscal.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        identificacao = NotaFiscalIdentificacao.fromJson(json['identificacao']),
        emitente = NotaFiscalEmitente.fromJson(json['emitente']),
        destinatario = NotaFiscalDestinatario.fromJson(json['destinatario']),
        products = NotaFiscalProduct.fromMap(json['products']),
        total = NotaFiscalTotal.fromJson(json['total']),
        cancelada = json['cancelada'] ?? false;

  Map<String, dynamic> toJson() => {
        'identificacao': identificacao.toJson(),
        'emitente': emitente.toJson(),
        'destinatario': destinatario.toJson(),
        'products': products.map((e) => e.toJson()).toList(),
        'total': total.toJson(),
        'cancelada': cancelada,
      };

  static NotaFiscal empty = NotaFiscal(
    '',
    NotaFiscalIdentificacao.empty,
    NotaFiscalEmitente.empty,
    NotaFiscalDestinatario.empty,
    [],
    NotaFiscalTotal.empty,
    false,
  );

  @override
  String toString() {
    return 'NotaFiscal{id: $id, identificacao: $identificacao, emitente: $emitente, destinatario: $destinatario, products: $products, total: $total, cancelada: $cancelada}';
  }
}
