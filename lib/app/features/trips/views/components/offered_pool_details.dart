part of trips_screen;

class OfferedPoolDetails extends GetView<TripsController> {
  RideModel rideModel;
  OfferedPoolDetails({Key? key, required this.rideModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
            color: Color(0xffebf2f8),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                ScaleAnimation(
                  child: SlideAnimation(
                    begin: Offset(-300, 0),
                    child: Container(
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
                            'Trip to ' +
                                rideModel.endSubLocality +
                                ", " +
                                rideModel.endCity,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16.r, fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Expanded(
                              child: Container(height: 10, color: Colors.red))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Expanded(
                  child: SlideAnimation(
                    begin: const Offset(0, 300),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        //sconstraints: BoxConstraints.expand(),
                        height: MediaQuery.of(context).size.height - 230.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                        ),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.white),
                        child: ListView(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Ride starts on ' +
                                      Jiffy(rideModel.startDate).MMMd +
                                      ', ' +
                                      rideModel.time.format(context),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.r),
                                )
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 12.r,
                                      color: AppBasicTheme().primaryColor,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 5.h, top: 2.h, bottom: 2.h),
                                      height: 46.h,
                                      child: DottedLine(
                                        dashGapLength: 2.0,
                                        dashColor:
                                            Colors.black.withOpacity(0.5),
                                        direction: Axis.vertical,
                                      ),
                                    ),
                                    Icon(
                                      Icons.circle,
                                      size: 12.r,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20.h,
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            rideModel.startSubLocality,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.r),
                                          ),
                                          Text(
                                            rideModel.startAddress,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 10.r),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 28.h,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            rideModel.endSubLocality,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.r),
                                          ),
                                          Text(
                                            rideModel.endAddress,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 10.r),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Co-Passengers',
                                  style: TextStyle(
                                      fontSize: 18.r,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.8)),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                StreamBuilder<
                                        QuerySnapshot<Map<String, dynamic>>>(
                                    stream: FirebaseFirestore.instance
                                        .collection("request")
                                        .where('rideID',
                                            isEqualTo: rideModel.id)
                                        .where('isConfirmed', isEqualTo: true)
                                        .orderBy('timestamp', descending: true)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data!.docs.isEmpty) {
                                          return const Center(
                                            child: Text("No passanger"),
                                          );
                                        }
                                        return Container(
                                          height: 100.h,
                                          width: Get.width,
                                          child: ListView(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            children:
                                                snapshot.data!.docs.map((e) {
                                              return _CoPassangerItem(
                                                requestModel: RequestModel
                                                    .fromDocumentSnapshot(
                                                        snapshot: e),
                                                context: context,
                                              );
                                            }).toList(),
                                          ),
                                        );
                                      } else {
                                        return SizedBox(
                                          height: Get.height,
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      }
                                    }),
                                SizedBox(height: 20.h),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Requests',
                                      style: TextStyle(
                                          fontSize: 18.r,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black.withOpacity(0.8)),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    StreamBuilder<
                                            QuerySnapshot<
                                                Map<String, dynamic>>>(
                                        stream: FirebaseFirestore.instance
                                            .collection("request")
                                            .where('rideID',
                                                isEqualTo: rideModel.id)
                                            .orderBy('timestamp',
                                                descending: true)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            if (snapshot.data!.docs.length ==
                                                0) {
                                              return const Center(
                                                child: Text("No Request found"),
                                              );
                                            }
                                            return Flex(
                                              direction: Axis.vertical,
                                              children:
                                                  snapshot.data!.docs.map((e) {
                                                return _RideRequestItem(
                                                  rideModel: rideModel,
                                                  requestModel: RequestModel
                                                      .fromDocumentSnapshot(
                                                          snapshot: e),
                                                  context: context,
                                                );
                                              }).toList(),
                                            );
                                          } else {
                                            return SizedBox(
                                              height: Get.height,
                                              child: Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                            );
                                          }
                                        }),
                                  ],
                                ),
                                SizedBox(
                                  height: 30.h,
                                ),
                                Center(
                                    child: Text("Cancel ride",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.red))),
                                SizedBox(
                                  height: 30.h,
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

Widget _CoPassangerItem(
    {required BuildContext context, required RequestModel requestModel}) {
  return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(requestModel.passangerID)
          .snapshots(),
      builder: (BuildContext _, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Align(
              alignment: Alignment.center, child: CircularProgressIndicator());
        }
        return ScaleAnimation(
          child: Container(
            margin: EdgeInsets.only(right: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppBasicTheme().secondaryColor,
                      borderRadius: BorderRadius.circular(100)),
                  height: 65,
                  width: 65,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      snapshot.data!['profile_image'] == "-"
                          ? "https://img.freepik.com/free-photo/handsome-young-man-with-new-stylish-haircut_176420-19637.jpg?t=st=1648123180~exp=1648123780~hmac=39b64ea5a82853c6c17321282f5712adf297e8e24a418df12a77661f503584d2&w=996"
                          : snapshot.data!['profile_image'],
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  snapshot.data!['name'],
                  style: TextStyle(fontSize: 14.r, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.fade,
                )
              ],
            ),
          ),
        );
      });
}

Widget _RideRequestItem(
    {required RequestModel requestModel,
    required BuildContext context,
    required RideModel rideModel}) {
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
    child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(requestModel.passangerID)
            .snapshots(),
        builder: (BuildContext _, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        height: 50.h,
                        width: 50.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            snapshot.data!['profile_image'] == "-"
                                ? "https://img.freepik.com/free-photo/handsome-young-man-with-new-stylish-haircut_176420-19637.jpg?t=st=1648123180~exp=1648123780~hmac=39b64ea5a82853c6c17321282f5712adf297e8e24a418df12a77661f503584d2&w=996"
                                : snapshot.data!['profile_image'],
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(snapshot.data!['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.r)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Request: ${Jiffy(requestModel.requestedAt).fromNow()}",
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 10.r),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      requestModel.isConfirmed
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                  color: AppBasicTheme().primaryColor,
                                  borderRadius: BorderRadius.circular(24)),
                              child: Text(
                                'Confirmed',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 10.r,
                                    color: Colors.white),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24)),
                              child: Text(
                                'pending',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 10.r),
                              ),
                            ),
                    ],
                  ),
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
                      "${requestModel.startAddress}",
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
                      "${requestModel.endAddress}",
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 1,
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              requestModel.isConfirmed
                  ? ScaleAnimation(
                      child: FadeAnimation(
                        child: Row(children: [
                          Expanded(
                              child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(55)),
                            child: Icon(
                              Iconsax.messages_25,
                              color: AppBasicTheme().primaryColor,
                            ),
                          )),
                        ]),
                      ),
                    )
                  : FadeAnimation(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(55)),
                            child: Icon(
                              Iconsax.messages_25,
                              color: AppBasicTheme().primaryColor,
                            ),
                          )),
                          SizedBox(width: 15.w),
                          Expanded(
                              flex: 3,
                              child: _AcceptButton(
                                requestModel: requestModel,
                                rideModel: rideModel,
                              )),
                        ],
                      ),
                    )
            ],
          );
        }),
  );
}

