import 'package:get/get.dart';

import '../bindings/auth_bindings.dart';
import '../middlewares/auth_middleware.dart';
import '../views/auth/login_page.dart';
import '../views/home/home_page.dart';

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
  ];
}
