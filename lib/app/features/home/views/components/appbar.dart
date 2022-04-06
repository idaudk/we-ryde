part of home_view;

class _AppBar extends GetView<HomeController> {
  _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Home',
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
          const Icon(Iconsax.logout_14)
        ],
      ),
    );
  }
}
