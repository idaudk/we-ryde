part of home_view;

class Profile extends GetView<HomeController> {
  const Profile({Key? key}) : super(key: key);
  //HomeController homeController = HomeCOn

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? Align(
              alignment: Alignment.topCenter,
              child: CircularProgressIndicator())
          : Card(
              child: ListTile(
                title: Text(controller.user.value?.name ?? "-"),
                subtitle: Text(controller.user.value?.phoneNumber ?? "-"),
              ),
            ),
    );
  }
}
