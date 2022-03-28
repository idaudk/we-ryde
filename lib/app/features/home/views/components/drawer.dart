part of home_view;

class CustomDrawer extends GetView<HomeController> {
  CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: 25),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () => controller.logout(),
          ),
        ],
      ),
    );
  }
}
