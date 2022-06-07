import 'package:get/get.dart';
import 'package:venda_sys/bindings/auth_binding.dart';
import 'package:venda_sys/views/login_page.dart';
import 'package:venda_sys/views/products/product_form_page.dart';

import '../bindings/product_binding.dart';
import '../middleware/auth_middleware.dart';
import '../views/clients/clients_form_page.dart';
import '../views/clients/clients_page.dart';
import '../views/home_page.dart';
import '../views/invoices/invoices_page.dart';
import '../views/products/products_page.dart';
import '../views/unit_measurement/unit_measurement_page.dart';
import '../views/users/users_page.dart';

class Routes {
  static final List<GetPage> pages = [
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: '/home',
      page: () => const HomePage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/products',
      page: () => const ProductsPage(),
      binding: ProductBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/products/new',
      page: () => ProductFormPage(),
      binding: ProductBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/unit_measurement',
      page: () => const UnitMeasurementPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/invoices',
      page: () => InvoicesPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/users',
      page: () => const UsersPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/clients',
      page: () => const ClientsPage(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/clients/new',
      page: () => ClientsFormPage(),
      middlewares: [AuthMiddleware()],
    ),
  ];

  static String initial = '/login';
}
