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
      : vBC = json['vBC'] + 0.0,
        vICMS = json['vICMS'] + 0.0,
        vICMSDeson = json['vICMSDeson'] + 0.0,
        vFCPUFDest = json['vFCPUFDest'] + 0.0,
        vICMSUFDest = json['vICMSUFDest'] + 0.0,
        vICMSUFRemet = json['vICMSUFRemet'] + 0.0,
        vFCP = json['vFCP'] + 0.0,
        vBCST = json['vBCST'] + 0.0,
        vST = json['vST'] + 0.0,
        vFCPST = json['vFCPST'] + 0.0,
        vFCPSTRet = json['vFCPSTRet'] + 0.0,
        vProd = json['vProd'] + 0.0,
        vFrete = json['vFrete'] + 0.0,
        vSeg = json['vSeg'] + 0.0,
        vDesc = json['vDesc'] + 0.0,
        vII = json['vII'] + 0.0,
        vIPI = json['vIPI'] + 0.0,
        vIPIDevol = json['vIPIDevol'] + 0.0,
        vPIS = json['vPIS'] + 0.0,
        vCOFINS = json['vCOFINS'] + 0.0,
        vOutro = json['vOutro'] + 0.0,
        vNF = json['vNF'] + 0.0;

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
