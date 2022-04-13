part of more_view;

class _AppBar extends GetView<MoreController> {
  final _auth = FirebaseAuth.instance;

  _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Account',
            style: TextStyle(fontSize: 16.r, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          // const Icon(
          //   Iconsax.heart5,
          //   color: Colors.red,
          // ),
          SizedBox(
            width: 16.h,
          ),
          InkWell(
            onTap: () => _Logout(),
            child: const Icon(Iconsax.logout_14),
          )
        ],
      ),
    );
  }

  _Logout() async {
    await _auth.signOut().then((value) => Get.offNamed(Routes.login));
  }
}
