part of my_vehciles_screen;

class _Banner extends GetView<MyVehiclesController> {
  const _Banner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SlideAnimation(
            begin: Offset(-250, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Vehicles",
                  style: TextStyle(fontSize: 28.r, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Vehicles you own",
                  style: TextStyle(fontSize: 12.r, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          SlideAnimation(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              height: 90.h,
              width: 90.w,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Icon(Iconsax.car)),
            ),
          )
        ],
      ),
    );
  }
}
