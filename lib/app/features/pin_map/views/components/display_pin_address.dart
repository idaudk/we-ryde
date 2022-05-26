part of pin_map_view;

class _DisplayPinAddress extends GetView<PinMapController> {
  _DisplayPinAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
      begin: Offset(0, 300),
      child: Container(
        height: 150.h,
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.h),
        decoration: BoxDecoration(
            color: AppBasicTheme().secondaryColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lcoation:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.r),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Obx(() {
                  return controller.pinMoving.value
                      ? SizedBox(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          child: Text(
                            controller.address == null
                                ? "No Address"
                                : controller.address.first.name.toString() +
                                    ",\n" +
                                    controller.address.first.subLocality
                                        .toString() +
                                    ",\n" +
                                    controller.address.first.locality
                                        .toString() +
                                    ",\n" +
                                    controller.address.first.administrativeArea
                                        .toString() +
                                    ", " +
                                    controller.address.first.isoCountryCode
                                        .toString(),

                            //textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                          ),
                        );
                })
              ],
            ),
            InkWell(
              onTap: () {
                controller.selectLocationButtonHandler();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppBasicTheme().primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                height: double.infinity,
                width: 100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "GO",
                      style: TextStyle(
                          color: Colors.white,
                          //fontWeight: FontWeight.bold,
                          fontSize: 15.r),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Icon(
                      Iconsax.arrow_right_1,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
