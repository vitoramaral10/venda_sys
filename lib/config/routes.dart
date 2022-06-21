import 'package:get/get.dart';
import 'package:venda_sys/views/products/products/products_page.dart';

import '../bindings/auth_bindings.dart';
import '../bindings/products_bindings.dart';
import '../bindings/units_of_measurement.dart';
import '../middlewares/auth_middleware.dart';
import '../views/auth/login_page.dart';
import '../views/home/home_page.dart';
import '../views/products/units_of_measurement/units_of_measurement_page.dart';

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
  ];
}
