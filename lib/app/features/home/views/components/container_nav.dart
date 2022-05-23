part of home_view;

class ContainerNav extends GetView<HomeController> {
  const ContainerNav({Key? key}) : super(key: key);
  //HomeController homeController = HomeCOn

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Align(
              alignment: Alignment.center, child: CircularProgressIndicator())
          : Container(
              //color: const Color(0xff0ec874),
              decoration: const BoxDecoration(
                  //color: Color.fromARGB(255, 5, 177, 99),
                  color: Color(0xffebf2f8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(11),
                    topRight: Radius.circular(11),
                  )),
              height: 250.h,
              child: TabContainer(
                radius: 11,
                tabCurve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  animation =
                      CurvedAnimation(curve: Curves.easeIn, parent: animation);
                  return SlideTransition(
                    position: Tween(
                      begin: const Offset(0.2, 0.0),
                      end: const Offset(0.0, 0.0),
                    ).animate(animation),
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },

                childPadding: EdgeInsets.symmetric(vertical: 2.h),
                //color: Theme.of(context).colorScheme.primary,
                color: Colors.white,
                children: [
                  FindPool(),
                  OfferPool(),
                ],
                tabs: [
                  TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Iconsax.car,
                      ),
                      label: const Text(
                        "Find Pool",
                        style: TextStyle(),
                      )),
                  TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Iconsax.people,
                      ),
                      label: const Text("Offer Pool", style: TextStyle())),
                ],
              ),
            ),
      // : Container(
      //     padding: const EdgeInsets.all(8.0),
      //     color: Colors.white,
      //     width: MediaQuery.of(context).size.width,
      //     height: 220.h,
      //     child: ContainedTabBarView(
      //       tabs: [
      //         Text('Find Pool'),
      //         Text('Offer Pool'),
      //       ],
      //       views: [
      //   Container(
      //     padding: const EdgeInsets.symmetric(horizontal: 24.0),
      //     decoration: const BoxDecoration(
      //         color: Colors.white,
      //         borderRadius: BorderRadius.only(
      //             topLeft: Radius.circular(20),
      //             topRight: Radius.circular(20))),
      //     child: ListView(
      //         physics: const BouncingScrollPhysics(),
      //         shrinkWrap: true,
      //         children: const [
      //           ListTile(
      //             leading: Icon(
      //               Iconsax.car,
      //               color: Color(0xff0ec874),
      //             ),
      //             title: Text(
      //               "My Vehicle",
      //               style: TextStyle(fontWeight: FontWeight.bold),
      //             ),
      //             subtitle: Text("Add vehicle Information"),
      //             //onTap: () => Get.toNamed(Routes.myvehicles),
      //           ),
      //           ListTile(
      //             leading: Icon(
      //               Iconsax.message,
      //               color: Color(0xff0ec874),
      //             ),
      //             title: Text(
      //               "Support",
      //               style: TextStyle(fontWeight: FontWeight.bold),
      //             ),
      //             subtitle: Text("Connect us for issues & queries"),
      //             //onTap: () => Get.toNamed(Routes.support),
      //           ),
      //         ]),
      //   ),
      //   Container(color: Colors.green)
      // ],
      // onChange: (index) => print(index),
      // tabBarViewProperties: TabBarViewProperties(
      //   physics: NeverScrollableScrollPhysics(),
      // ),
      //),
      //),
    );
  }
}
