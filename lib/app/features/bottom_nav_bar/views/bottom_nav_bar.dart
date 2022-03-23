import 'package:flutter/material.dart';
import 'package:weryde/app/features/home/views/views/home_screen.dart';
import 'package:weryde/app/features/more/views/screens/more_screen.dart';

class BottomNavigationBarUI extends StatelessWidget {
  BottomNavigationBarUI({Key? key}) : super(key: key);

  final screens = [
    HomeScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: 0,
        children: screens,
      )
    );
  }
}


// bottomNavigationBar: Container(
//         padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//         decoration: BoxDecoration(color: Colors.white, boxShadow: [
//           BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.1))
//         ]),
//         child: GNav(
//             selectedIndex: 0,
//             onTabChange: (index) {},
//             rippleColor: Colors.grey[300]!,
//             hoverColor: Colors.grey[100]!,
//             gap: 8,
//             activeColor: Colors.black,
//             //backgroundColor: Colors.white,
//             iconSize: 24,
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             duration: Duration(milliseconds: 400),
//             tabBackgroundColor: Colors.grey[100]!,
//             color: Colors.black,
//             tabs: [
//               GButton(
//                 icon: Icons.home,
//                 text: "Home",
//               ),
//               GButton(
//                 icon: Icons.location_on_outlined,
//                 text: "My Trips",
//               ),
//               GButton(
//                 icon: Icons.chat_sharp,
//                 text: "Chats",
//               ),
//               GButton(
//                 icon: Icons.menu,
//                 text: "More",
//               ),
//             ]),
//       ),