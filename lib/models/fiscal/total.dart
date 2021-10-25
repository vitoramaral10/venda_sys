class NotaFiscalTotal {
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

  NotaFiscalTotal(
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

  NotaFiscalTotal.fromJson(Map<String, dynamic> json)
      : vBC = json['vBC'],
        vICMS = json['vICMS'],
        vICMSDeson = json['vICMSDeson'],
        vFCPUFDest = json['vFCPUFDest'],
        vICMSUFDest = json['vICMSUFDest'],
        vICMSUFRemet = json['vICMSUFRemet'],
        vFCP = json['vFCP'],
        vBCST = json['vBCST'],
        vST = json['vST'],
        vFCPST = json['vFCPST'],
        vFCPSTRet = json['vFCPSTRet'],
        vProd = json['vProd'],
        vFrete = json['vFrete'],
        vSeg = json['vSeg'],
        vDesc = json['vDesc'],
        vII = json['vII'],
        vIPI = json['vIPI'],
        vIPIDevol = json['vIPIDevol'],
        vPIS = json['vPIS'],
        vCOFINS = json['vCOFINS'],
        vOutro = json['vOutro'],
        vNF = json['vNF'];

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
  static NotaFiscalTotal empty = NotaFiscalTotal(
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
