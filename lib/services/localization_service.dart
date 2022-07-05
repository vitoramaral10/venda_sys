import 'package:get/get.dart';

class LocalizationService extends Translations {
  final Map<String, Map<String, String>> _translationKeys;

  @override
  Map<String, Map<String, String>> get keys => _translationKeys;

  LocalizationService(this._translationKeys);
}
