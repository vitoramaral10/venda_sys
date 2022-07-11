import 'package:get/get.dart';
import 'package:venda_sys/bindings/auth_bindings.dart';
import 'package:venda_sys/bindings/clients_bindings.dart';
import 'package:venda_sys/bindings/products_bindings.dart';
import 'package:venda_sys/bindings/units_of_measurement_bindings.dart';
import 'package:venda_sys/middlewares/auth_middleware.dart';
import 'package:venda_sys/views/auth/login_page.dart';
import 'package:venda_sys/views/clients/client_view.dart';
import 'package:venda_sys/views/clients/clients_form.dart';
import 'package:venda_sys/views/clients/clients_page.dart';
import 'package:venda_sys/views/home/home_page.dart';
import 'package:venda_sys/views/products/products/products_page.dart';
import 'package:venda_sys/views/products/units_of_measurement/units_of_measurement_page.dart';

class Routes {
  static const initialRoute = '/login';

  static final List<GetPage> pages = [
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      binding: AuthBindings(),
    ),
    GetPage(
      name: '/home',
      page: () => const HomePage(),
      middlewares: [
        AuthMiddleware(),
      ],
      binding: AuthBindings(),
    ),
    GetPage(
      name: '/products/products',
      page: () => const ProductsPage(),
      middlewares: [
        AuthMiddleware(),
      ],
      binding: ProductsBindings(),
    ),
    GetPage(
      name: '/products/units_of_measurement',
      page: () => const UnitsOfMeasurementPage(),
      middlewares: [
        AuthMiddleware(),
      ],
      binding: UnitsOfMeasurementBindings(),
    ),
    GetPage(
      name: '/clients',
      page: () => const ClientsPage(),
      middlewares: [
        AuthMiddleware(),
      ],
      binding: ClientsBindings(),
    ),
    GetPage(
      name: '/clients/view',
      page: () => ClientView(),
      middlewares: [
        AuthMiddleware(),
      ],
      binding: ClientsBindings(),
    ),
    GetPage(
      name: '/clients/register',
      page: () => ClientsForm(),
      middlewares: [
        AuthMiddleware(),
      ],
      binding: ClientsBindings(),
    ),
    GetPage(
      name: '/clients/edit',
      page: () => ClientsForm(),
      middlewares: const [
        // AuthMiddleware(),
      ],
      binding: ClientsBindings(),
    ),
  ];
}
