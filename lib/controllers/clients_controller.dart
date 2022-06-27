// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:get/get.dart';
import 'package:venda_sys/libraries/utils.dart';
import 'package:venda_sys/models/client.dart';
import 'package:venda_sys/services/firebase_service.dart';

class ClientsController extends GetxController {
  static ClientsController get to => Get.find<ClientsController>();
  final _clients = <Client>[].obs;
  final _loading = false.obs;

  List<Client> get clients => _clients.value;
  bool get loading => _loading.value;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadClients();
  }

  Future<void> loadClients() async {
    _loading.value = true;
    update();

    _clients.value = await FirebaseService().getClients();
    _loading.value = false;

    update();
  }

  Future<void> create(Client client) async {
    try {
      Utils.loading();
      await FirebaseService().createClient(client);

      await loadClients();

      Get.back();
      Get.back();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> delete(Client client) async {
    try {
      Utils.loading();
      await FirebaseService().deleteClient(client);
      await loadClients();
      Get.back();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<void> updateClient(Client client) async {
    try {
      Utils.loading();
      await FirebaseService().updateClient(client);

      await loadClients();

      Get.back();
      Get.back();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
