part of home_view;

class OfferPool extends GetView<HomeController> {
  const OfferPool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Align(
              alignment: Alignment.topCenter,
              child: CircularProgressIndicator())
          : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: const [
                          ListTile(
                            leading: Icon(
                              Iconsax.message,
                            ),
                            title: Text(
                              "Support",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Connect us for issues & queries"),
                            //onTap: () => Get.toNamed(Routes.support),
                          ),
                          ListTile(
                            leading: Icon(
                              Iconsax.message,
                            ),
                            title: Text(
                              "Support",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Connect us for issues & queries"),
                            //onTap: () => Get.toNamed(Routes.support),
                          ),
                          
                        ]),
                  ),
    );
  }
}
