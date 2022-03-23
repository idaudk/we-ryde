import 'package:get/get.dart';
import 'package:weryde/app/features/authentication/bindings/authentication_binding.dart';
import 'package:weryde/app/features/authentication/views/screens/authentication_screen.dart';
import 'package:weryde/app/features/bottom_nav_bar/bindings/bottom_nav_binding.dart';
import 'package:weryde/app/features/home/bindings/home_binding.dart';
import 'package:weryde/app/features/home/views/views/home_screen.dart';
import 'package:weryde/app/features/login/bindings/login_binding.dart';
import 'package:weryde/app/features/login/views/screens/login_screen.dart';
import 'package:weryde/app/features/more/views/screens/more_screen.dart';
import 'package:weryde/app/features/registration/bindings/registration_binding.dart';
import 'package:weryde/app/features/registration/views/screens/registration_screen.dart';
import 'package:weryde/app/features/splash/views/screens/splash_screen.dart';

part 'app_routes.dart';

abstract class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: _Paths.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.registration,
      page: () => RegistrationScreen(),
      binding: RegistrationBinding(),
    ),
    GetPage(
        name: _Paths.authentication,
        page: () => AuthenticationScreen(),
        transition: Transition.cupertino,
        binding: AuthenticationBinding()),
    GetPage(
      name: _Paths.home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.more,
      page: () => MoreScreen(),
      binding: MoreBinding(),
    )
  ];
}
