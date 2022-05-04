import 'package:flutter/material.dart';

class Constants {
  static const double defaultPadding = 16.0;

  static const Color primary = Colors.red;
  static const Color secondary = Color(0xFFF3413F);
  static const Color background = Color(0xFFf8f8f8);
  static const Color buttonColor = Colors.white;
  static const Color buttonColorHover = Color(0xFF2a2a2a);

  static const imagemProfileDecorator =
      DecorationImage(image: AssetImage('assets/images/userBlank.png'));

  static const tiposPessoa = {
    'J': 'Jurídica',
    'F': 'Física',
  };

  static const estados = {
    '-': 'Selecione',
    'AC': 'Acre',
    'AL': 'Alagoas',
    'AP': 'Amapá',
    'AM': 'Amazonas',
    'BA': 'Bahia',
    'CE': 'Ceará',
    'DF': 'Distrito Federal',
    'ES': 'Espírito Santo',
    'GO': 'Goiás',
    'MA': 'Maranhão',
    'MT': 'Mato Grosso',
    'MS': 'Mato Grosso do Sul',
    'MG': 'Minas Gerais',
    'PA': 'Pará',
    'PB': 'Paraíba',
    'PR': 'Paraná',
    'PE': 'Pernambuco',
    'PI': 'Piauí',
    'RJ': 'Rio de Janeiro',
    'RN': 'Rio Grande do Norte',
    'RS': 'Rio Grande do Sul',
    'RO': 'Rondônia',
    'RR': 'Roraima',
    'SC': 'Santa Catarina',
    'SP': 'São Paulo',
    'SE': 'Sergipe',
    'TO': 'Tocantins',
  };
}
