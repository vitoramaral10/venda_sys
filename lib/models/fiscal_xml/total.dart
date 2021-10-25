class NotaFiscalXMLTotal {
  final double vBC;
  final double vICMS;
  final double vICMSDeson;
  final double vFCPUFDest;
  final double vICMSUFDest;
  final double vICMSUFRemet;
  final double vFCP;
  final double vBCST;
  final double vST;
  final double vFCPST;
  final double vFCPSTRet;
  final double vProd;
  final double vFrete;
  final double vSeg;
  final double vDesc;
  final double vII;
  final double vIPI;
  final double vIPIDevol;
  final double vPIS;
  final double vCOFINS;
  final double vOutro;
  final double vNF;

  NotaFiscalXMLTotal(
    this.vBC,
    this.vICMS,
    this.vICMSDeson,
    this.vFCPUFDest,
    this.vICMSUFDest,
    this.vICMSUFRemet,
    this.vFCP,
    this.vBCST,
    this.vST,
    this.vFCPST,
    this.vFCPSTRet,
    this.vProd,
    this.vFrete,
    this.vSeg,
    this.vDesc,
    this.vII,
    this.vIPI,
    this.vIPIDevol,
    this.vPIS,
    this.vCOFINS,
    this.vOutro,
    this.vNF,
  );

  NotaFiscalXMLTotal.fromJson(Map<String, dynamic> json)
      : vBC = double.tryParse(json['vBC']) ?? 0,
        vICMS = double.tryParse(json['vICMS']) ?? 0,
        vICMSDeson = double.tryParse(json['vICMSDeson']) ?? 0,
        vFCPUFDest = double.tryParse(json['vFCPUFDest']) ?? 0,
        vICMSUFDest = double.tryParse(json['vICMSUFDest']) ?? 0,
        vICMSUFRemet = double.tryParse(json['vICMSUFRemet']) ?? 0,
        vFCP = double.tryParse(json['vFCP']) ?? 0,
        vBCST = double.tryParse(json['vBCST']) ?? 0,
        vST = double.tryParse(json['vST']) ?? 0,
        vFCPST = double.tryParse(json['vFCPST']) ?? 0,
        vFCPSTRet = double.tryParse(json['vFCPSTRet']) ?? 0,
        vProd = double.tryParse(json['vProd']) ?? 0,
        vFrete = double.tryParse(json['vFrete']) ?? 0,
        vSeg = double.tryParse(json['vSeg']) ?? 0,
        vDesc = double.tryParse(json['vDesc']) ?? 0,
        vII = double.tryParse(json['vII']) ?? 0,
        vIPI = double.tryParse(json['vIPI']) ?? 0,
        vIPIDevol = double.tryParse(json['vIPIDevol']) ?? 0,
        vPIS = double.tryParse(json['vPIS']) ?? 0,
        vCOFINS = double.tryParse(json['vCOFINS']) ?? 0,
        vOutro = double.tryParse(json['vOutro']) ?? 0,
        vNF = double.tryParse(json['vNF']) ?? 0;

  Map<String, dynamic> toJson() => {
        'vBC': vBC,
        'vICMS': vICMS,
        'vICMSDeson': vICMSDeson,
        'vFCPUFDest': vFCPUFDest,
        'vICMSUFDest': vICMSUFDest,
        'vICMSUFRemet': vICMSUFRemet,
        'vFCP': vFCP,
        'vBCST': vBCST,
        'vST': vST,
        'vFCPST': vFCPST,
        'vFCPSTRet': vFCPSTRet,
        'vProd': vProd,
        'vFrete': vFrete,
        'vSeg': vSeg,
        'vDesc': vDesc,
        'vII': vII,
        'vIPI': vIPI,
        'vIPIDevol': vIPIDevol,
        'vPIS': vPIS,
        'vCOFINS': vCOFINS,
        'vOutro': vOutro,
        'vNF': vNF,
      };
  static NotaFiscalXMLTotal empty = NotaFiscalXMLTotal(
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  );
}
