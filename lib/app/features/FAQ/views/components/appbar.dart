part of faq_screen;

class _AppBar extends StatelessWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back)),
          SizedBox(width: 16.h),
          Text(
            'FAQs',
            style: TextStyle(fontSize: 16.r, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          // const Icon(
          //   Iconsax.heart5,
          //   color: Colors.red,
          // ),
          // SizedBox(
          //   width: 16.h,
          // ),
          // const Icon(Iconsax.menu_1)
        ],
      ),
    );
  }
}
