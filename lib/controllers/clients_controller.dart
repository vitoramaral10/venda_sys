// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:get/get.dart';
import 'package:venda_sys/models/client.dart';
import 'package:venda_sys/services/firebase_service.dart';

class ClientsController extends GetxController {
  final _clients = <Client>[].obs;
  final _loading = false.obs;
  final _state = ''.obs;

  static ClientsController get to => Get.find<ClientsController>();
  List<Client> get clients => _clients.value;
  bool get loading => _loading.value;
  String get state => _state.value;

  set state(String value) => _state.value = value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadClients();
  }

  Future<void> loadClients() async {
    try {
      _loading.value = true;
      update();

      _clients.value = await FirebaseService().getClients();
      _loading.value = false;

      update();
    } catch (e) {
      log(e.toString(), name: 'loadClients');

      rethrow;
    }
  }

  Future<void> create(Client client) async {
    try {
      await FirebaseService().createClient(client);

      await loadClients();
    } catch (e) {
      log(e.toString(), name: 'createClient');
      rethrow;
    }
  }

  Future<void> delete(Client client) async {
    try {
      await FirebaseService().deleteClient(client);
      await loadClients();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> updateClient(Client client) async {
    try {
      await FirebaseService().updateClient(client);

      await loadClients();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
