import 'package:get/get.dart';

class I18n extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'title': 'Venda Sys',
          'importXml': 'Import XML',
          'products': 'Products',
        },
        'pt_BR': {
          'title': 'Venda Sys',
          'importXml': 'Importar XML',
          'products': 'Products',
        },
      };
}
