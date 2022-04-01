import 'package:get/get.dart';
import 'package:weryde/app/features/FAQ/bindings/faq_binding.dart';
import 'package:weryde/app/features/Support/bindings/support_binding.dart';
import 'package:weryde/app/features/Support/views/screen/support_screen.dart';
import 'package:weryde/app/features/authentication/bindings/authentication_binding.dart';
import 'package:weryde/app/features/authentication/views/screens/authentication_screen.dart';
import 'package:weryde/app/features/bottom_nav_bar/bindings/bottom_nav_binding.dart';
import 'package:weryde/app/features/bottom_nav_bar/views/bottom_nav_bar.dart';
import 'package:weryde/app/features/chats/bindings/chats_bindings.dart';
import 'package:weryde/app/features/chats/views/screens/chats_screen.dart';
import 'package:weryde/app/features/home/bindings/home_binding.dart';
import 'package:weryde/app/features/home/views/views/home_screen.dart';
import 'package:weryde/app/features/login/bindings/login_binding.dart';
import 'package:weryde/app/features/login/views/screens/login_screen.dart';
import 'package:weryde/app/features/more/views/screens/more_screen.dart';
import 'package:weryde/app/features/my_vehicles/bindings/my_vehicles_binding.dart';
import 'package:weryde/app/features/my_vehicles/views/screens/my_vehicle_screen.dart';
import 'package:weryde/app/features/registration/bindings/registration_binding.dart';
import 'package:weryde/app/features/registration/views/screens/registration_screen.dart';
import 'package:weryde/app/features/splash/views/screens/splash_screen.dart';
import 'package:weryde/app/features/trips/bindings/trips_binding.dart';
import 'package:weryde/app/features/trips/views/screens/trips_screen.dart';
import 'package:weryde/app/features/user_profile/bindings/user_profile_binding.dart';
import 'package:weryde/app/features/user_profile/views/screen/user_profile.dart';

import '../../features/FAQ/views/screen/faq_screen.dart';
import '../../features/manage_address/bindings/manage_address.dart';
import '../../features/manage_address/views/screen/manage_address.dart';
import '../../features/more/bindings/more_binding.dart';

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
    ),
    GetPage(
      name: _Paths.bottomnav,
      page: () => BottomNavigationBarUI(),
      binding: BottomNavigationBinding(),
    ),
    GetPage(
      name: _Paths.myvehicles,
      page: () => MyVehiclesScreen(),
      binding: MyVehiclesBinding(),
    ),
    GetPage(
      name: _Paths.support,
      page: () => SupportScreen(),
      binding: SupportBinding(),
    ),
    GetPage(
      name: _Paths.manageaddress,
      page: () => ManageAddressScreen(),
      binding: ManageAddress(),
    ),
    GetPage(
        name: _Paths.user_profile,
        page: () => UserProfileScreen(),
        binding: UserProfileBinding(),
        transition: Transition.cupertino),
    GetPage(
      name: _Paths.faq,
      page: () => FaqScreen(),
      binding: FaqBinding(),
    ),
    GetPage(
      page: () => ChatsScreen(),
      name: _Paths.chats,
      binding: ChatsBinding(),
    ),
    GetPage(
      page: () => TripsScreen(),
      name: _Paths.trips,
      binding: TripsBinding(),
    )
  ];
}
