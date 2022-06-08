part of trips_screen;

class _RequestedPool extends GetView<TripsController> {
  const _RequestedPool({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 10.0.w, right: 10.0.w, top: 2.h),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white),
      child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("ride")
                    .where('driverID',
                        isEqualTo: controller.auth.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.length == 0) {
                      return const Center(
                        child: Text("No ride found"),
                      );
                    }
                    return Flex(
                      direction: Axis.vertical,
                      children: snapshot.data!.docs.map((e) {
                        return _RequestItem(
                            ride: RideModel.fromDocumentSnapshot(snapshot: e),
                            context: context);
                      }).toList(),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ]),
    );
  }
}

Widget _RequestItem({required RideModel ride, required BuildContext context}) {
  return Container(
    padding: EdgeInsets.all(13),
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    decoration: BoxDecoration(
      color: Color(0xffebf2f8),
      borderRadius: BorderRadius.circular(15),
      // border: Border.all(width: 0.5),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0),
          spreadRadius: 2,
          blurRadius: 3,
          // offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${ride.time.format(context)}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.r),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Icon(
                      Iconsax.calendar,
                      size: 14.r,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${Jiffy(ride.startDate).MMMd}",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            CircleAvatar()
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            Icon(
              Icons.circle,
              size: 9.r,
              color: Colors.green,
            ),
            SizedBox(
              width: 5.w,
            ),
            Container(
              alignment: Alignment.topLeft,
              width: Get.width / 1.45,
              child: Text(
                "${ride.startAddress}",
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 1,
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: Get.width / 98),
              alignment: Alignment.center,
              height: 20,
              child: const DottedLine(
                dashGapRadius: 5,
                direction: Axis.vertical,
                dashLength: 1.0,
                dashColor: Colors.green,
                lineThickness: 3.0,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.circle,
              size: 9.r,
              color: Colors.red,
            ),
            SizedBox(
              width: 5.w,
            ),
            Container(
              alignment: Alignment.topLeft,
              width: Get.width / 1.45,
              child: Text(
                "${ride.endAddress}",
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 1,
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Posted: ${Jiffy(ride.postedAt).fromNow()}",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 10.r),
            ),
          ],
        )
      ],
    ),
  );
}
