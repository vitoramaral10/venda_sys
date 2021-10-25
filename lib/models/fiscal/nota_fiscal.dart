import 'destinatario.dart';
import 'emitente.dart';
import 'identificacao.dart';
import 'produto.dart';
import 'total.dart';

class NotaFiscal {
  final String id;
  final NotaFiscalIdentificacao identificacao;
  final NotaFiscalEmitente emitente;
  final NotaFiscalDestinatario destinatario;
  final List<NotaFiscalProduto> produtos;
  final NotaFiscalTotal total;
  final bool cancelada;

  NotaFiscal(
    this.id,
    this.identificacao,
    this.emitente,
    this.destinatario,
    this.produtos,
    this.total,
    this.cancelada,
  );

  NotaFiscal.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        identificacao = NotaFiscalIdentificacao.fromJson(json['identificacao']),
        emitente = NotaFiscalEmitente.fromJson(json['emitente']),
        destinatario = NotaFiscalDestinatario.fromJson(json['destinatario']),
        produtos = NotaFiscalProduto.fromMap(json['produtos']),
        total = NotaFiscalTotal.fromJson(json['total']),
        cancelada = json['cancelada'] ?? false;

  Map<String, dynamic> toJson() => {
        'identificacao': identificacao.toJson(),
        'emitente': emitente.toJson(),
        'destinatario': destinatario.toJson(),
        'produtos': produtos.map((e) => e.toJson()).toList(),
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
}
